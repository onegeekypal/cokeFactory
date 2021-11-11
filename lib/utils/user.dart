enum UserRole { admin, manager, peasant }

class User {
  final String username;
  final UserRole userRole;

  const User({required this.username, required this.userRole}) : super();
}
