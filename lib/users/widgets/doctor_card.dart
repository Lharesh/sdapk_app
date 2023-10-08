import 'package:flutter/material.dart';
import 'package:sdapk_app/users/models/staff.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onDoctorEditTap,
  });

  final Staff doctor;
  final void Function(Staff doctor) onDoctorEditTap;

  @override
  Widget build(BuildContext context) {
    String addressing = 'Dr.';
    final String firstLetter =
        '${doctor.firstName[0].toUpperCase()}${doctor.lastName[0].toUpperCase()}';
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
            '$addressing ${doctor.firstName} ${doctor.lastName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            doctor.mobileNumber.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Column(
            children: [
              Text(
                doctor.registrationNumber!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(Icons.edit, color: Colors.black),
            ],
          ),
          onTap: () => onDoctorEditTap(doctor),
        ),
      ),
    );
  }
}
