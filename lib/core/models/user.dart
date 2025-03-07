import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id(assignable: true)
  int id;
  String name;
  String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
