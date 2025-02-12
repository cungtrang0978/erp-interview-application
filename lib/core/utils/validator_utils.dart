class ValidatorUtils {
  const ValidatorUtils._();

  static String? email(String? email) {
    if (email == null || email.trim().isEmpty) return "Email is required";
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim()) ? null : "Invalid email";
  }

  /// Password must contain at least 1 letter and 1 number
  static String? password(String? password) {
    if (password == null || password.isEmpty) return "Password is required";
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passwordRegex.hasMatch(password) ? null : "The password must be at least 6 characters long and must contain at least 1 letter and 1 digit";
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) return "Confirm password is required";
    if (password != confirmPassword) return "Passwords do not match";
    return null;
  }

  static String? name(String? name) {
    if (name == null || name.trim().isEmpty) return "Name is required";
    return null;
  }
}
