

class Patient {
  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.address,
    required this.gender,
    required this.age,
    this.alternateMobileNumber,
    this.dob,
    this.email,
    this.occupation,
    this.reference,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });
  String id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String address;
  final String gender;
  final int age;
  final String? alternateMobileNumber;
  final String? email;
  DateTime? dob;
  final String? occupation;
  final String? reference;
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
      'id': id,
      'age': age,
      'gender': gender,
      'reference': reference,
      'occupation': occupation,
      'date_of_birth': dob,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      firstName: map['first_name'],
      lastName: map['last_name'],
      mobileNumber: map['phone_number'],
      alternateMobileNumber: map['alternate_phone_number'],
      email: map['email'],
      age: int.parse(map['age'].toString()),
      id: map['id']??'',
      address: map['address'],
      gender: map['gender'],
      occupation: map['occupation'],
      reference: map['reference'],
      dob: DateTime.tryParse(map['date_of_birth'].toString()),
      createdAt: DateTime.tryParse(map['createdAt'].toString()),
      createdBy: map['createdBy']??'',
      updatedAt: DateTime.tryParse(map['updatedAt'].toString()),
      updatedBy: map['updatedBy']??'',
    );
  }
}
