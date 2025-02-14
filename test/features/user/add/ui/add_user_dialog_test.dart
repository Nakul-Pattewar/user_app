import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/common/state/ui_state.dart';
import 'package:user_app/features/user/add/bloc/add_user_cubit.dart';
import 'package:user_app/features/user/add/ui/add_user_dialog.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

class MockEditUserCubit extends MockCubit<UiState<bool>>
    implements AddUserCubit {}

late AddUserCubit _addUserCubit;

Future<void> _buildDialog({required WidgetTester tester}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => BlocProvider(
                create: (_) => _addUserCubit,
                child: AddUserDialog(),
              ),
            ),
            child: Text('Add User'),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('Add User'));
  await tester.pumpAndSettle();
}

void main() {
  group('tests for Add user dialog', () {
    setUp(() {
      _addUserCubit = MockEditUserCubit();

      when(() => _addUserCubit.state).thenReturn(Success(true));
    });

    testWidgets(
        'Given none, '
        'When User open AddUserDialog,'
        'Then should render widget correctly', (WidgetTester tester) async {
      await _buildDialog(tester: tester);

      expect(find.text(''), findsNWidgets(2));
      expect(find.text('male'), findsOneWidget);
      expect(find.text('female'), findsOneWidget);
      expect(find.text('active'), findsOneWidget);
      expect(find.text('inactive'), findsOneWidget);
    });

    testWidgets(
        'Given none,'
        'When User tap on radio and elevated buttons in dialog, '
        'Then should tap correctly on buttons and update respective values correctly',
        (WidgetTester tester) async {
      await _buildDialog(tester: tester);

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
        'Given none, '
        'When user clicks on cancel button, '
        'Should close the dialog', (WidgetTester tester) async {
      await _buildDialog(tester: tester);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
