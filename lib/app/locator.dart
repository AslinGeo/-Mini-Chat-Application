import 'package:get_it/get_it.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/viewModels/index.dart';

final sl = GetIt.instance; // Service Locator

void setupLocator() {
  // repo

  sl.registerLazySingleton<UsersRepository>(() => UsersRepository());
  sl.registerLazySingleton<ChatRepository>(() => ChatRepository());

  // bloc
  sl.registerFactory<BottomNavBloc>(() => BottomNavBloc());
  sl.registerFactory<ChatBloc>(() => ChatBloc(sl<ChatRepository>()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<UsersRepository>()));
}
