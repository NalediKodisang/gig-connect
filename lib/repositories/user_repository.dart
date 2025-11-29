// 📦 user_repository.dart
// Handles signup, login, roles, and current user session.

class User {
  final String email;
  final String password;
  final String role; // "poster" or "seeker"

  User({required this.email, required this.password, required this.role});
}

class UserRepository {
  static final List<User> _users = [];
  static User? currentUser;

  // 🧠 Sign up
  static Future<bool> signUp(String email, String password, String role) async {
    if (_users.any((u) => u.email == email)) return false;
    _users.add(User(email: email, password: password, role: role.toLowerCase()));
    return true;
  }

  // 🔐 Login — returns true if found
  static Future<bool> login(String email, String password) async {
    try {
      final user = _users.firstWhere(
              (u) => u.email == email && u.password == password);
      currentUser = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  static String? getCurrentUserEmail() => currentUser?.email;
  static String? getCurrentUserRole() => currentUser?.role;

  static void logout() => currentUser = null;
}
