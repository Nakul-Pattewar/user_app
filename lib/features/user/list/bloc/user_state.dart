import 'package:user_app/features/user/list/network/user_response.dart';

class UserState {
  final List<UserResponse> users;
  const UserState(this.users);
}

class UserInitial extends UserState {
  const UserInitial(super.users);
}

class UserLoading extends UserState {
  const UserLoading(super.users);
}

class UserLoaded extends UserState {
  const UserLoaded(super.users);
}

class UserError extends UserState {
  const UserError(super.users);
}