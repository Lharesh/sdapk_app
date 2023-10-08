import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/patients/models/patient.dart';
import 'package:sdapk_app/patients/providers/patient_provider.dart';
import 'package:sdapk_app/patients/screens/add_patient_screen.dart';
import 'package:sdapk_app/patients/screens/patient_details_screen.dart';
import 'package:sdapk_app/patients/widgets/patient_card.dart';

class ListPatientsScreen extends ConsumerStatefulWidget {
  const ListPatientsScreen({super.key});

  @override
  ConsumerState<ListPatientsScreen> createState() => _ListPatientsScreenState();
}

class _ListPatientsScreenState extends ConsumerState<ListPatientsScreen> {
  void _onPatientTap(Patient patient) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PatientDetails(
          patient: patient,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Patient> patients = ref.watch(patientsProvider);
    return Scaffold(
      body: patients.isEmpty
          ? const Center(
              child: Text(
                'No Patients To Display.',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (ctx, index) => PatientCard(
                patient: patients[index],
                onPatientTap: _onPatientTap,
              ),
              // PatientCard(
              //     patient: patients[index], onPatientTap: _onPatientTap),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const AddPatientScreen(
              isUpdate: false,
            ),
          ));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
