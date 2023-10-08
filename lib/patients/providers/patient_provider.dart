import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/patients/models/patient.dart';

class PatientsNotifier extends StateNotifier<List<Patient>> {
  PatientsNotifier() : super(const []);
  final fireStore = FirebaseFirestore.instance;

  void addPatients() async {
    final collectionRef = fireStore.collection('patients');
    final docsRef = await collectionRef
        .orderBy('createdAt', descending: true)
        .limit(25)
        .get();
    state = docsRef.docs.map((doc) {
      Patient patient = Patient.fromMap(doc.data());
      return patient;
    }).toList();
  }

  Future<String> addPatient(
      Map<String, dynamic> formData, String userEmail) async {
    String uid = await generateId;
    if (formData.isNotEmpty) {
      final newPatient = Patient.fromMap(formData);
      newPatient.id = uid;
      newPatient.createdAt = DateTime.now();
      newPatient.createdBy = userEmail;
      if (formData['date_of_birth'] != null) {
        newPatient.dob = formData['date_of_birth'];
      }

      await upsertPatientToFireStore(newPatient);
      state = [newPatient, ...state];
    }
    return 'success';
  }

  Future<String> updatePatient(
      Map<String, dynamic> formData, String userName) async {
    if (formData.isNotEmpty) {
      final updatedPatient = Patient.fromMap(formData);
      if (formData['date_of_birth'] != null) {
        updatedPatient.dob = formData['date_of_birth'];
      }
      updatedPatient.updatedBy = userName;
      updatedPatient.updatedAt = DateTime.now();
      await upsertPatientToFireStore(updatedPatient);
      final List<Patient> updatedPatients = [...state];
      int index = updatedPatients.indexWhere(
        (patient) => patient.id == updatedPatient.id,
      );
      updatedPatients[index] = updatedPatient;
      state = updatedPatients;
    }
    return 'success';
  }

  void removePatient(String id) async {
    state = [...state.where((Patient patient) => patient.id != id)];
    //firestore to be added
    try {
      await fireStore.collection('patients').doc(id).delete();
    } catch (e) {
      'Error adding document: $e';
    }
  }

  // Helper Methods
  Future<String> get generateId async {
    final documentsRef = await fireStore
        .collection('patients')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (documentsRef.docs.isEmpty) {
      return 'P-1';
    }
    //split and regenerate Id before sending.
    int latestId =
        int.parse(await documentsRef.docs.first.data()['id'].substring(2)) + 1;
    return "P-$latestId";
  }

  Future<void> upsertPatientToFireStore(Patient patient) async {
    try {
      await fireStore
          .collection('patients')
          .doc(patient.id)
          .set(patient.toJson());
    } catch (e) {
      'Error adding document: $e';
    }
  }
}

final patientsProvider = StateNotifierProvider<PatientsNotifier, List<Patient>>(
    (ref) => PatientsNotifier());
