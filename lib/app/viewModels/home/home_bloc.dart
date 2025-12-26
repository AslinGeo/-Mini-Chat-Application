import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:mini_chat/app/data/index.dart';
import 'package:mini_chat/app/viewModels/index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UsersRepository repository;
  final List<UserModel> _users = [];
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      on<GetUsers>(_loadUsers);
      on<AddUser>(_addUser);
    });
  }

  Future<void> _loadUsers(GetUsers event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());

      final users = repository.getUsers();
      _users
        ..clear()
        ..addAll(users);
      emit(HomeLoaded(List.from(_users)));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _addUser(AddUser event, Emitter<HomeState> emit) async {
    try {
      final user = UserModel(
        id: Random().nextInt(100000).toString(),
        name: event.userName,
      );

      _users.add(user);
      await repository.addUser(user);

      emit(HomeLoaded(List.from(_users)));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
