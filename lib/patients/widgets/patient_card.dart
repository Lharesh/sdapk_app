import 'package:flutter/material.dart';
import 'package:sdapk_app/patients/models/patient.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.patient,
    required this.onPatientTap,
  });

  final Patient patient;
  final void Function(Patient patient) onPatientTap;

  @override
  Widget build(BuildContext context) {
    String addressing = patient.gender == 'Male' ? 'Mr.' : 'Ms.';
    String firstLetter =
        '${patient.firstName[0].toUpperCase()}${patient.lastName[0].toUpperCase()}';
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.onBackground.withOpacity(.90),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(255, 72, 126, 72),
            child: Text(
              firstLetter,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          title: Text(
            '$addressing ${patient.firstName} ${patient.lastName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            patient.mobileNumber,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Column(
            children: [
              Text(
                patient.id,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(Icons.keyboard_arrow_right, color: Colors.black),
            ],
          ),
          onTap: () => onPatientTap(patient),
        ),
      ),
    );
  }
}
