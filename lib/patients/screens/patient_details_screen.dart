import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sdapk_app/patients/models/patient.dart';
import 'package:sdapk_app/patients/providers/patient_provider.dart';
import 'package:sdapk_app/patients/screens/add_patient_screen.dart';

class PatientDetails extends ConsumerWidget {
  const PatientDetails({super.key, required this.patient});
  final Patient patient;
  void sendWhatsAppMessage() {}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(patientsProvider.notifier);
    String createdDate = patient.createdAt != null
        ? DateFormat("dd MMM yy").format(patient.createdAt!)
        : "";
    String dateOfBirth =
        patient.dob != null ? DateFormat("dd MMM yy").format(patient.dob!) : "";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<Patient>(
                  builder: (BuildContext context) =>
                      AddPatientScreen(isUpdate: true, patient: patient),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Patient Id: ${patient.id}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.errorContainer),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Registered on: $createdDate',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.errorContainer),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${patient.firstName} ${patient.lastName}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mobile_friendly,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      patient.mobileNumber,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      color: Colors.blueAccent,
                      onPressed: () {},
                      icon: const Icon(Icons.message),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'SMS',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton.filled(
                      color: Colors.greenAccent,
                      onPressed: sendWhatsAppMessage,
                      icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'WA',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mobile_friendly,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  patient.alternateMobileNumber??'',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  patient.email ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Reference: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(width: 5),
                Text(
                  patient.reference ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Occupation: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(width: 5),
                Text(
                  patient.occupation ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Address: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(width: 5),
                Text(
                  patient.address,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Gender: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(width: 5),
                Text(
                  patient.gender,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Date Of Birth: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      dateOfBirth,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Age: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      patient.age.toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          "Delete a patient record ?",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer),
                        ),
                        content: const Text(
                            "The deleted patient can't be recovered"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Cancel"),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(patientsProvider.notifier)
                                  .removePatient(patient.id);
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              //The Dialog popup is not closing with out repeating pop()
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("okay"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Delete Patient Record ?',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                Text(
                  maxLines: 2,
                  '** Before deleting patient record, delete corresponding appointments and health records',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
