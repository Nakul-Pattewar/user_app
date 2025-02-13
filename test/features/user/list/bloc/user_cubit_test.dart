import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/features/user/edit/bloc/edit_user_cubit.dart';
import 'package:user_app/features/user/list/bloc/user_cubit.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:user_app/features/user/list/network/user_api.dart';

class MockUserApi extends Mock implements UserApi {}

void main() {
  late UserCubit userCubit;
  late MockUserApi mockUserApi;
  late UserResponse mockUser;
  late String jsonResponse;

  setUpAll(() {
    mockUserApi = MockUserApi();
    mockUser = UserResponse(
      userId: 1,
      userName: "Test User",
      userEmail: "test@example.com",
      userGender: Gender.male,
      userStatus: Status.active,
    );
    registerFallbackValue(mockUser);
    jsonResponse = jsonEncode([
      {
        "id": 7646618,
        "name": "Prof. Mohini Varrier",
        "email": "prof_mohini_varrier@grady-trantow.test",
        "gender": "female",
        "status": "inactive"
      },
      {
        "id": 7646617,
        "name": "Paramartha Trivedi",
        "email": "trivedi_paramartha@hickle-lowe.example",
        "gender": "female",
        "status": "active"
      }
    ]).toString();
  });

  setUp(() {
    userCubit = UserCubit(mockUserApi);
  });

  blocTest<UserCubit, UiState<List<UserResponse>>>(
    "Given userApi, "
    "When fetchUsers method is called & it returns users list, "
    "Then should emit Loading and Success state",
    build: () {
      // Stubbing
      when(() => mockUserApi.getUsersList()).thenAnswer((_) async =>
          (jsonDecode(jsonResponse) as List)
              .map((json) => UserResponse.fromJson(json))
              .toList());

      return userCubit;
    },
    act: (bloc) => bloc.fetchUsers(),
    expect: () => [
      isA<Loading<List<UserResponse>>>(),
      isA<Success<List<UserResponse>>>(),
    ],
    verify: (_) {
      verify(() => mockUserApi.getUsersList());
    },
  );

  blocTest<UserCubit, UiState<List<UserResponse>>>(
    "Given userApi, "
    "When fetchUsers method is called & it throws an exception, "
    "Then should emit Loading and Error state",
    build: () {
      // Stubbing
      when(() => mockUserApi.getUsersList())
          .thenThrow(Exception("Failed to fetch users"));

      return userCubit;
    },
    act: (bloc) => bloc.fetchUsers(),
    expect: () => [
      isA<Loading<List<UserResponse>>>(),
      isA<Error<List<UserResponse>>>(),
    ],
    verify: (_) {
      verify(() => mockUserApi.getUsersList());
    },
  );
}
