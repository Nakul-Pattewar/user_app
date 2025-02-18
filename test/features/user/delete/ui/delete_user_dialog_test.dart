import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:user_app/features/user/delete/bloc/delete_user_cubit.dart';
import 'package:user_app/features/user/delete/ui/delete_user_dialog.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class MockDeleteUserCubit extends MockCubit<UiState<bool>>
    implements DeleteUserCubit {}

late DeleteUserCubit _deleteUserCubit;

Future<void> _buildDialog(
    {required WidgetTester tester, required UserResponse mockUser}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => BlocProvider(
                create: (_) => _deleteUserCubit,
                child: DeleteUserDialog(user: mockUser),
              ),
            ),
            child: Text('Open Dialog'),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('Open Dialog'));
  await tester.pumpAndSettle();
}

void main() {
  group('tests for Delete user dialog', () {
    late UserResponse mockUser;

    setUp(() {
      mockUser = UserResponse(
        userId: 12345,
        userName: 'Test User',
        userGender: Gender.undefined,
        userEmail: 'test@gmail.com',
        userStatus: Status.undefined,
      );
      _deleteUserCubit = MockDeleteUserCubit();

      when(() => _deleteUserCubit.state).thenReturn(Success(true));
    });

    testWidgets(
        'Given mockUser, '
        'When User open delete dialog,'
        'Then should render widget correctly', (WidgetTester tester) async {
      await _buildDialog(tester: tester, mockUser: mockUser);

      expect(find.text('Delete User'), findsOneWidget);
    });

    testWidgets(
        'Given mock user, '
        'When user clicks on cancel button, '
        'Should close the dialog', (WidgetTester tester) async {
      await _buildDialog(tester: tester, mockUser: mockUser);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
