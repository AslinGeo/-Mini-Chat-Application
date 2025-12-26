import 'package:get_it/get_it.dart';
import 'package:mini_chat/app/viewModels/bottom_nav/bottom_nav_bloc.dart';

final sl = GetIt.instance; // Service Locator

void setupLocator() {
    sl.registerFactory<BottomNavBloc>(() => BottomNavBloc());
}
