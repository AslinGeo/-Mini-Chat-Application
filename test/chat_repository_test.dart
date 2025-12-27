import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/app/data/index.dart';

import 'test_helper.dart';

void main() {
  late ChatRepository repository;

  setUp(() async {
    await setUpHive();
    repository = ChatRepository();
  });

  tearDown(() async {
    await tearDownHive();
  });

  test('Add message to new user', () async {
    final message = ChatMessage(
      id: '1',
      message: 'Hello',
      isSender: true,
    );

    await repository.addMessage('user1', message);

    final messages = repository.getMessages('user1');

    expect(messages.length, 1);
    expect(messages.first.message, 'Hello');
  });

  test('Add message to existing user', () async {
    await repository.addMessage(
      'user1',
      ChatMessage(id: '1', message: 'Hi', isSender: true),
    );

    await repository.addMessage(
      'user1',
      ChatMessage(id: '2', message: 'How are you?', isSender: false),
    );

    final messages = repository.getMessages('user1');

    expect(messages.length, 2);
    expect(messages.last.message, 'How are you?');
  });

  test('Get messages for non-existing user', () {
    final messages = repository.getMessages('unknown');

    expect(messages.isEmpty, true);
  });

  test('Clear chat for user', () async {
    await repository.addMessage(
      'user1',
      ChatMessage(id: '1', message: 'Test', isSender: true),
    );

    await repository.clearChat('user1');

    final messages = repository.getMessages('user1');

    expect(messages.isEmpty, true);
  });
}
