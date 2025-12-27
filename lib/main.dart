import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_chat/app/core/routes/app_router.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/locator.dart';
import 'package:mini_chat/app/viewModels/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('usersBox');
  Hive.registerAdapter(UserChatAdapter());
  await Hive.openBox<UserChat>('chatBox');
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BottomNavBloc>()),
        BlocProvider(create: (_) => sl<ChatBloc>()),
        BlocProvider(create: (_) => sl<HomeBloc>()..add(GetUsers())),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
