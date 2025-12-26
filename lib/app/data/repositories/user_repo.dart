import 'package:hive/hive.dart';
import 'package:mini_chat/app/data/index.dart';


class UsersRepository {
  final Box<UserModel> box = Hive.box<UserModel>('usersBox');

  List<UserModel> getUsers() {
    return box.values.toList();
  }

  Future<void> addUser(UserModel user) async {
    await box.put(user.id, user);
  }

  Future<void> deleteUser(String id) async {
    await box.delete(id);
  }

  Future<void> clearUsers() async {
    await box.clear();
  }
}
