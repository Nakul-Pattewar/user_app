import 'dart:async';

import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

import '../network/add_user_api.dart';

class AddUserCubit extends Cubit<UiState<bool>> {
  AddUserCubit() : super(Default());

  FutureOr<void> addUser(UserResponse user) async {
    emit(Loading());
    try {
      final apiResponse = await AddUserApi().addUser(user);
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
