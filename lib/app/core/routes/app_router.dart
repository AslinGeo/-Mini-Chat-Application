import 'package:go_router/go_router.dart';
import 'package:mini_chat/app/core/index.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/views/index.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.main,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RoutePaths.main,
      name: 'main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: RoutePaths.chat,
      name: 'chat',
      builder: (context, state) {
        return ChatScreen(userModel: state.extra as UserModel);
      },
    ),
  ],
);
