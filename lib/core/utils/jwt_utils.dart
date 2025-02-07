import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtUtils {
  const JwtUtils._();

  static const _jwtSecret = "your_secret_key"; // TODO: 🔥 Replace with a strong secret

  static String generateJwt(int userId, String email) {
    final jwt = JWT({
      'userId': userId,
      'email': email,
      'exp': DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000, // Expires in 1 day
    });

    return jwt.sign(SecretKey(_jwtSecret));
  }

  static JwtStatus verifyJwt(String token) {
    try {
      JWT.verify(token, SecretKey(_jwtSecret));
      return JwtStatus.valid;
    } on JWTExpiredException {
      return JwtStatus.expired;
    } on JWTException catch (_) {
      return JwtStatus.invalid;
    } catch (e) {
      return JwtStatus.invalid;
    }
  }

  static bool checkExpired(String token) {
    try {
      JWT.verify(token, SecretKey(_jwtSecret));
      return false;
    } on JWTExpiredException {
      return true;
    } on JWTException catch (_) {
      return true;
    } catch (e) {
      return true;
    }
  }
}

enum JwtStatus {
  valid,
  expired,
  invalid,
}
