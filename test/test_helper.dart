import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:path_provider_platform_interface/src/method_channel_path_provider.dart';

import 'package:mini_chat/app/data/index.dart';

class TestPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    final dir = Directory.systemTemp.createTempSync();
    return dir.path;
  }
}

Future<void> setUpHive() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = TestPathProviderPlatform();

  Hive.init(await PathProviderPlatform.instance.getTemporaryPath()!);

  // 🔥 Register adapters ONLY ONCE
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ChatMessageAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(UserChatAdapter());
  }

  await Hive.openBox<UserChat>('chatBox');
  await Hive.openBox<UserModel>('usersBox');
}

Future<void> tearDownHive() async {
  await Hive.close();
  await Hive.deleteFromDisk();
}
