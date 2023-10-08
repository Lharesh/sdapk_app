import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/users/models/staff.dart';
import 'package:sdapk_app/users/providers/doctors_provider.dart';
import 'package:sdapk_app/users/screens/add_doctor_screen.dart';
import 'package:sdapk_app/users/widgets/doctor_card.dart';

class ListDoctorsScreen extends ConsumerWidget {
  const ListDoctorsScreen({super.key});

  void _onDoctorEditTap(Staff doctor, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              AddDoctorScreen(isUpdate: true, doctor: doctor)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Staff> doctors = ref.watch(doctorsProvider);
    return Scaffold(
      body: doctors.isEmpty
          ? const Center(
              child: Text(
                'No Doctors To Display.',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (ctx, index) => DoctorCard(
                doctor: doctors[index],
                onDoctorEditTap: (Staff doctor) =>
                    _onDoctorEditTap(doctor, context),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  const AddDoctorScreen(isUpdate: false),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
