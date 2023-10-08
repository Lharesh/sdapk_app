import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sdapk_app/authentication/services/auth_service.dart';
import 'package:sdapk_app/patients/models/patient.dart';
import 'package:sdapk_app/patients/providers/patient_provider.dart';

class AddPatientScreen extends ConsumerStatefulWidget {
  const AddPatientScreen({super.key, required this.isUpdate, this.patient});
  final bool isUpdate;
  final Patient? patient;

  @override
  ConsumerState<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  // ignore: unused_field
  String _selectedGender = '';
  void _saveAndValidate() async {
    // Get userName
    final userDataProvider = ref.read(authProvider);
    final userName = await userDataProvider.getUserName();
    if (_formKey.currentState!.saveAndValidate()) {
      // Form is valid, do something with the data
      Map<String, dynamic> formData = _formKey.currentState!.value;
      if (widget.patient != null) {
        formData = {
          ...formData,
          'createdAt': widget.patient!.createdAt,
          'createdBy': widget.patient!.createdBy,
          'id': widget.patient!.id
        };
      }

      if (widget.isUpdate) {
        await ref
            .read(patientsProvider.notifier)
            .updatePatient(formData, userName!);
      } else {
        await ref
            .read(patientsProvider.notifier)
            .addPatient(formData, userName!);
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Patients'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                FormBuilderTextField(
                  initialValue: widget.patient?.firstName,
                  name: 'first_name',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(50),
                  ]),
                ),
                FormBuilderTextField(
                  initialValue: widget.patient?.lastName,
                  name: 'last_name',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(50),
                  ]),
                ),
                FormBuilderTextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  initialValue: widget.patient?.mobileNumber,
                  name: 'phone_number',
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.phone,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                FormBuilderTextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  initialValue: widget.patient?.alternateMobileNumber,
                  name: 'alternate_phone_number',
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: 'Alternate Mobile Number'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                FormBuilderTextField(
                  initialValue: widget.patient?.email,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(),
                  ]),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        initialValue: widget.patient?.age.toString(),
                        name: 'age',
                        decoration: const InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FormBuilderDateTimePicker(
                        initialValue: widget.patient?.dob,
                        name: 'date_of_birth',
                        inputType: InputType.date,
                        keyboardType: TextInputType.datetime,
                        format: DateFormat("dd-MMM-yyyy"),
                        decoration:
                            const InputDecoration(labelText: 'Date of Birth'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilderRadioGroup<String>(
                  initialValue: widget.patient?.gender,
                  decoration: const InputDecoration(labelText: 'Select Gender'),
                  name: 'gender',
                  orientation: OptionsOrientation.wrap,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  options: const [
                    FormBuilderFieldOption(
                      key: Key('male'),
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    FormBuilderFieldOption(
                      key: Key('female'),
                      value: 'Female',
                      child: Text('Female'),
                    ),
                    FormBuilderFieldOption(
                      key: Key('other'),
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  initialValue: widget.patient?.address,
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(50),
                  ]),
                ),
                FormBuilderTextField(
                  initialValue: widget.patient?.occupation,
                  name: 'occupation',
                  decoration: const InputDecoration(labelText: 'Occupation'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.max(50),
                  ]),
                ),
                FormBuilderTextField(
                  initialValue: widget.patient?.reference,
                  name: 'reference',
                  decoration: const InputDecoration(labelText: 'Reference'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.max(50),
                  ]),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: _saveAndValidate,
                  child: widget.isUpdate
                      ? const Text('Update')
                      : const Text('Add New Client'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
