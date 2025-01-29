import 'dart:async';

import 'package:user_app/features/user/list/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/network/user_api.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(UserLoading([])){
    fetchUsers();
  }


  FutureOr<void> fetchUsers() async {
    final users = await UserApi().getUsersList();
    if(users.isEmpty) emit(UserError([]));
    emit(UserLoaded(users));
  }
}