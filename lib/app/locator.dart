import 'package:get_it/get_it.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/viewModels/index.dart';

final sl = GetIt.instance; // Service Locator

void setupLocator() {
  // repo

  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepository(),
  );

  // bloc
  sl.registerFactory<BottomNavBloc>(() => BottomNavBloc());
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<UsersRepository>()));
}
