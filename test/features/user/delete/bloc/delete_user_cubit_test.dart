import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/features/user/delete/bloc/delete_user_cubit.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:user_app/features/user/list/network/user_api.dart';

class MockUserApi extends Mock implements UserApi {}

void main() {
  late DeleteUserCubit deleteUserCubit;
  late MockUserApi mockUserApi;
  late UserResponse mockUser;

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
  });

  setUp(() {
    deleteUserCubit = DeleteUserCubit(mockUserApi);
  });

  blocTest<DeleteUserCubit, UiState<bool>>(
    "Given userApi, "
    "When delete user method is called & it returns true, "
    "Then should emit Loading and Success state",
    build: () {
      // Stubbing
      when(() => mockUserApi.deleteUser(any())).thenAnswer((_) async => true);

      return deleteUserCubit;
    },
    act: (bloc) => bloc.deleteUser(mockUser.userId),
    expect: () => [
      isA<Loading>(),
      isA<Success<bool>>().having((s) => s.data, 'data', true),
    ],
    verify: (_) {
      verify(() => mockUserApi.deleteUser(any())).called(1);
    },
  );

  blocTest<DeleteUserCubit, UiState<bool>>(
    "Given userApi, "
    "When delete user method is called & it returns false, "
    "Then should emit Loading and Error state",
    build: () {
      // Stubbing
      when(() => mockUserApi.deleteUser(any())).thenAnswer((_) async => false);

      return deleteUserCubit;
    },
    act: (bloc) => bloc.deleteUser(mockUser.userId),
    expect: () => [
      isA<Loading>(),
      isA<Error>(),
    ],
    verify: (_) {
      verify(() => mockUserApi.deleteUser(any())).called(1);
    },
  );
}
