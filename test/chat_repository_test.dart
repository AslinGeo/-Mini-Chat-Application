import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mini_chat/app/data/index.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/moct_http_clicent.dart';
import 'test_helper.dart';

void main() {
  late ChatRepository repository;
  late MockHttpClient mockClient;
  setUpAll(() {
    registerFallbackValue(Uri());
  });
  setUp(() async {
    await setUpHive();
    mockClient = MockHttpClient();

    repository = ChatRepository(client: mockClient);
  });

  tearDown(() async {
    await tearDownHive();
  });

  test('Add message to new user', () async {
    final message = ChatMessage(id: '1', message: 'Hello', isSender: true);

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

  test(
    'fetchRandomMessage returns quote when API call is successful',
    () async {
      // arrange
      final responseBody = {
        "id": 1,
        "quote": "Life is what happens when you're busy making other plans.",
        "author": "John Lennon",
      };

      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseBody), 200));

      // act
      final result = await repository.fetchRandomMessage();

      // assert
      expect(result, responseBody['quote']);
      verify(
        () => mockClient.get(Uri.parse('https://dummyjson.com/quotes/random')),
      ).called(1);
    },
  );

  test('fetchRandomMessage throws exception when API fails', () async {
    // arrange
    when(
      () => mockClient.get(any()),
    ).thenAnswer((_) async => http.Response('Error', 500));

    // act & assert
    expect(() => repository.fetchRandomMessage(), throwsException);
  });
}
