import 'dart:async';

import 'package:user_app/common/state/ui_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/network/user_api.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class UserCubit extends Cubit<UiState<List<UserResponse>>> {
  UserCubit() : super(Default()) {
    fetchUsers();
  }

  FutureOr<void> fetchUsers() async {
    emit(Loading());
    try {
      final users = await UserApi().getUsersList();
      emit(Success<List<UserResponse>>(users));
    } catch (e) {
      emit(Error(Exception(e)));
    }
  }
}
