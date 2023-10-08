import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/users/models/staff.dart';

class DoctorsNotifier extends StateNotifier<List<Staff>> {
  DoctorsNotifier() : super(const []);
  final fireStore = FirebaseFirestore.instance;
  void addDoctors() async {
    final collectionRef = fireStore.collection('doctors');
    final docsRef = await collectionRef
        .orderBy('createdAt', descending: true)
        .limit(25)
        .get();
    state = docsRef.docs.map((doc) => Staff.fromMap(doc.data())).toList();
  }

  Future<String> addDoctor(
      Map<String, dynamic> formData, String userEmail) async {
    String uid = await generateId;
    if (formData.isNotEmpty) {
      final newDoctor = Staff.fromMap(formData);
      newDoctor.id = uid;
      newDoctor.createdAt = DateTime.now();
      newDoctor.createdBy = userEmail;
      await upsertDoctorToFireStore(newDoctor);
      state = [newDoctor, ...state];
    }
    return 'success';
  }

  Future<String> updateDoctor(Map<String, dynamic> formData) async {
    if (formData.isNotEmpty) {
      final updatedDoctor = Staff.fromMap(formData);
      await upsertDoctorToFireStore(updatedDoctor);
      final List<Staff> updatedDoctors = [...state];
      int index = updatedDoctors.indexWhere(
        (doctor) => doctor.id == updatedDoctor.id,
      );
      updatedDoctors[index] = updatedDoctor;
      state = updatedDoctors;
    }
    return 'success';
  }

  void removeDoctor(String id) async {
    state = [...state.where((Staff doctor) => doctor.id != id)];
    //firestore to be added
    try {
      await fireStore.collection('doctors').doc(id).delete();
    } catch (e) {
      'Error adding document: $e';
    }
  }

  // Helper Methods
  Future<String> get generateId async {
    final documentsRef = await fireStore
        .collection('doctors')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (documentsRef.docs.isEmpty) {
      return 'D-1';
    }
    //split and regenerate Id before sending.
    int latestId =
        int.parse(await documentsRef.docs.first.data()['id'].substring(2)) + 1;
    return "D-$latestId";
  }

  Future<void> upsertDoctorToFireStore(Staff doctor) async {
    try {
      await fireStore.collection('doctors').doc(doctor.id).set(doctor.toJson());
    } catch (e) {
      'Error adding document: $e';
    }
  }
}

final doctorsProvider = StateNotifierProvider<DoctorsNotifier, List<Staff>>(
    (ref) => DoctorsNotifier());
