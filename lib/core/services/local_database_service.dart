import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../objectbox.g.dart';
import '../models/user.dart';
import 'object_box.dart';

@LazySingleton()
class LocalDatabaseService {
  late final Box<User> _userBox;
  static const _storage = FlutterSecureStorage();

  Future<void> init() async {
    final objectBox = await ObjectBox.create();
    _userBox = objectBox.store.box<User>();
  }

  List<User> getUsers() => _userBox.getAll();

  Future<void> saveUser(User user, String jwt) async {
    _userBox.put(user);
    await _storage.write(key: 'jwt_${user.id}', value: jwt);
    await _storage.write(key: 'jwt', value: jwt);
  }

  Future<void> removeUser(User user) async {
    _userBox.remove(user.id);
    await _storage.delete(key: 'jwt_${user.id}');
  }

  Future<void> saveJwtOnly(User user, String jwt) async {
    await _storage.write(key: 'jwt', value: jwt);
    await removeUser(user);
  }

  Future<void> updateJwt(String jwt) async {
    await _storage.write(key: 'jwt', value: jwt);
  }

  User? getUser(User user) => _userBox.get(user.id);

  Future<String?> getJwtByUser(User user) async {
    return await _storage.read(key: 'jwt_${user.id}');
  }
}
