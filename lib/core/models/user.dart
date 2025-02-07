import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id(assignable: true)
  int id;
  String name;
  String email;

  User({required this.id, required this.name, required this.email});
}
