class User {
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String uniqueId;
  final String city;
  late final String profileImage;

  User({required this.firstName, required this.lastName, required this.email, required this.userName, required this.uniqueId, required this.city, required this.profileImage});
}