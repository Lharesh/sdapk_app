import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sdapk_app/authentication/services/auth_service.dart';
import 'package:sdapk_app/users/models/staff.dart';
import 'package:sdapk_app/users/providers/doctors_provider.dart';

class AddDoctorScreen extends ConsumerStatefulWidget {
  const AddDoctorScreen({super.key, required this.isUpdate, this.doctor});
  final bool isUpdate;
  final Staff? doctor;

  @override
  ConsumerState<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends ConsumerState<AddDoctorScreen> {
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
      if (widget.doctor != null) {
        formData = {
          ...formData,
          'createdAt': widget.doctor!.createdAt,
          'createdBy': widget.doctor!.createdBy,
          'updatedAt': DateTime.now(),
          'updatedBy': userName,
          'id': widget.doctor!.id
        };
        await ref
            .read(doctorsProvider.notifier)
            .updateDoctor(formData);
      } else {
        await ref.read(doctorsProvider.notifier).addDoctor(formData, userName!);
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Doctors'),
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
                  initialValue: widget.doctor?.firstName,
                  name: 'first_name',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(50),
                  ]),
                ),
                FormBuilderTextField(
                  initialValue: widget.doctor?.lastName,
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
                  initialValue: widget.doctor?.mobileNumber,
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
                  initialValue: widget.doctor?.alternateMobileNumber,
                  name: 'alternate_phone_number',
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: 'Alternate Mobile Number'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                FormBuilderTextField(
                  initialValue: widget.doctor?.email,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
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
                        initialValue: widget.doctor?.age.toString(),
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
                        initialValue: widget.doctor?.doj,
                        name: 'date_of_joining',
                        inputType: InputType.date,
                        keyboardType: TextInputType.datetime,
                        format: DateFormat("dd-MMM-yyyy"),
                        decoration:
                            const InputDecoration(labelText: 'Date of Joining'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilderRadioGroup<String>(
                  initialValue: widget.doctor?.gender,
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
                  initialValue: widget.doctor?.address,
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(50),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        initialValue: widget.doctor?.specialization,
                        name: 'specialization',
                        decoration:
                            const InputDecoration(labelText: 'Specialization'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.max(50),
                        ]),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FormBuilderTextField(
                        initialValue: widget.doctor?.specialization,
                        name: 'education',
                        decoration:
                            const InputDecoration(labelText: 'Education'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        initialValue: widget.doctor?.registrationNumber,
                        name: 'registration_number',
                        decoration: const InputDecoration(
                            labelText: 'Registration Number'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormBuilderTextField(
                        initialValue: widget.doctor?.registrationNumber,
                        name: 'role',
                        decoration: const InputDecoration(labelText: 'Role'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: _saveAndValidate,
                  child: widget.isUpdate
                      ? const Text('Update Doctor')
                      : const Text('Add Doctor'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
