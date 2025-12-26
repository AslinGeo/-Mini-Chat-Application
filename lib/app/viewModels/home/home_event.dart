

abstract class HomeEvent {
  const HomeEvent();

  
}

class GetUsers extends HomeEvent {}

class AddUser extends HomeEvent {
  final String userName;

  const AddUser(this.userName);
}
