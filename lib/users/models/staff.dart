

class Staff {
  Staff(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.address,
      required this.gender,
      required this.age,
      required this.email,
      required this.doj,
      required this.education,
      required this.role,
      required this.id,
      this.registrationNumber,
      this.alternateMobileNumber,
      this.specialization,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy});
  String id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String address;
  final String gender;
  final String email;
  final int age;
  final DateTime? doj;
  final String role;
  final String education;
  final String? registrationNumber;
  final String? alternateMobileNumber;
  final String? specialization;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? updatedBy;
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': mobileNumber,
      'alternate_phone_number': alternateMobileNumber,
      'email': email,
      'address': address,
      'role': role,
      'education': education,
      'id': id,
      'age': age,
      'gender': gender,
      'registration_number': registrationNumber,
      'specialization': specialization,
      'date_of_joining': doj,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      firstName: map['first_name'],
      lastName: map['last_name'],
      mobileNumber: map['phone_number'],
      alternateMobileNumber: map['alternate_phone_number'],
      email: map['email'],
      age: int.parse(map['age'].toString()),
      id: map['id'] ?? '',
      education: map['education'],
      role: map['role'],
      address: map['address'],
      gender: map['gender'],
      doj: DateTime.tryParse(map['date_of_joining'].toString()),
      specialization: map['specialization'] ?? '',
      registrationNumber: map['registration_number'],
      createdAt: DateTime.tryParse(map['createdAt'].toString()),
      createdBy: map['createdBy'] ?? '',
      updatedAt: DateTime.tryParse(map['updatedAt'].toString()),
      updatedBy: map['updatedBy'] ?? '',
    );
  }
}
