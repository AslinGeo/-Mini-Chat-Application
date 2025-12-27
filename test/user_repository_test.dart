import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/app/data/index.dart';

import 'test_helper.dart';

void main() {
  late UsersRepository repository;

  setUp(() async {
    await setUpHive();
    repository = UsersRepository();
  });

  tearDown(() async {
    await tearDownHive();
  });

  test('Add user', () async {
    final user = UserModel(id: '1', name: 'John');

    await repository.addUser(user);

    final users = repository.getUsers();

    expect(users.length, 1);
    expect(users.first.name, 'John');
  });

  test('Delete user', () async {
    final user = UserModel(id: '1', name: 'John');

    await repository.addUser(user);
    await repository.deleteUser('1');

    final users = repository.getUsers();

    expect(users.isEmpty, true);
  });

  test('Clear users', () async {
    await repository.addUser(UserModel(id: '1', name: 'John'));
    await repository.addUser(UserModel(id: '2', name: 'Alex'));

    await repository.clearUsers();

    final users = repository.getUsers();

    expect(users.isEmpty, true);
  });
}
