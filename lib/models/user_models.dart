class UserModel {
  String id;
  String email;
  String password;
  String fullName;
  String phoneNumber;
  String designation;
  String city;
  String status;
  String joinDate;

  UserModel({
    required this.email,
    required this.password,
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.city,
    required this.joinDate,
    required this.designation,
    required this.status,
  });
}
