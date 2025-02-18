import 'dart:async';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

import '../../list/network/user_api.dart';

class DeleteUserCubit extends Cubit<UiState<bool>> {
  final UserApi userApi;

  DeleteUserCubit(this.userApi) : super(Default());

  FutureOr<void> deleteUser(int userId) async {
    emit(Loading());
    try {
      final apiResponse = await userApi.deleteUser(userId);
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
