import 'dart:async';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

import '../../list/network/user_api.dart';

class AddUserCubit extends Cubit<UiState<bool>> {
  final UserApi userApi;

  AddUserCubit(this.userApi) : super(Default());

  FutureOr<void> addUser(UserResponse user) async {
    emit(Loading());
    try {
      final apiResponse = await userApi.addUser(user);
      if (apiResponse) {
        emit(Success<bool>(apiResponse));
      } else {
        emit(Error(Exception(unexpectedErrorMessage)));
      }
    } catch (e) {
      emit(Error(Exception(e)));
    }
  }
}
