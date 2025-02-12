import 'dart:async';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

import '../../list/network/user_api.dart';

class EditUserCubit extends Cubit<UiState<bool>> {
  EditUserCubit() : super(Default());

  FutureOr<void> updateUser(UserResponse user) async {
    emit(Loading());
    try {
      final apiResponse = await UserApi().updateUser(user);
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
