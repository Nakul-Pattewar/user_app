import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:user_app/features/user/edit/bloc/edit_user_cubit.dart';
import 'package:user_app/features/user/edit/ui/edit_user_dialog.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class MockEditUserCubit extends MockCubit<UiState<bool>>
    implements EditUserCubit {}

late EditUserCubit _editUserCubit;

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
                create: (_) => _editUserCubit,
                child: EditUserDialog(user: mockUser),
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
  group('tests for Edit user dialog', () {
    late UserResponse mockUser;

    setUp(() {
      mockUser = UserResponse(
        userId: 12345,
        userName: 'Nakul Pattewar',
        userGender: Gender.male,
        userEmail: 'pattewarnakul@gmail.com',
        userStatus: Status.active,
      );
      _editUserCubit = MockEditUserCubit();

      when(() => _editUserCubit.state).thenReturn(Success(true));
    });

    testWidgets(
        'Given mockUser, '
        'When User open edit dialog,'
        'Then should render widget correctly', (WidgetTester tester) async {
      await _buildDialog(tester: tester, mockUser: mockUser);

      expect(find.text('Nakul Pattewar'), findsOneWidget);
      expect(find.text('pattewarnakul@gmail.com'), findsOneWidget);
      expect(find.text('male'), findsOneWidget);
      expect(find.text('female'), findsOneWidget);
      expect(find.text('active'), findsOneWidget);
      expect(find.text('inactive'), findsOneWidget);
    });

    testWidgets(
        'Given mock user,'
        'When User tap on radio and elevated buttons in dialog, '
        'Then should tap correctly on buttons and update respective values correctly',
        (WidgetTester tester) async {
      await _buildDialog(tester: tester, mockUser: mockUser);

      await tester.tap(find.text('female'));
      await tester.pumpAndSettle();
      final femaleRadioTile = tester.widget<RadioListTile<Gender>>(
          find.widgetWithText(RadioListTile<Gender>, 'female'));
      expect(femaleRadioTile.groupValue, Gender.female);

      await tester.tap(find.text('active'));
      await tester.pumpAndSettle();
      final activeRadioTile = tester.widget<RadioListTile<Status>>(
          find.widgetWithText(RadioListTile<Status>, 'active'));
      expect(activeRadioTile.groupValue, Status.active);
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
