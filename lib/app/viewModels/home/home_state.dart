

import 'package:mini_chat/app/data/index.dart';

abstract class HomeState  {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<UserModel> users;

  const HomeLoaded(this.users);
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
