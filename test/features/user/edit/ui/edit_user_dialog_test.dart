import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/features/user/edit/ui/edit_user_dialog.dart';
import 'package:user_app/features/user/list/network/user_response.dart';

void main() {
  group('tests for Edit user dialog', () {
    late UserResponse mockUser;

    setUp(() {
      mockUser = UserResponse(
        userId: 12345,
        userName: 'Nakul Pattewar',
        userGender: Gender.male,
        userEmail: 'abc@gmail.com',
        userStatus: Status.active,
      );
    });

    Future<void> _BuildDialog(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => EditUserDialog(user: mockUser),
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

    testWidgets(
        'Given mockUser, '
        'When User open edit dialog,'
        'Then should render widget correctly', (WidgetTester tester) async {
      await _BuildDialog(tester);

      expect(find.text('Nakul Pattewar'), findsOneWidget);
      expect(find.text('abc@gmail.com'), findsOneWidget);
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
      await _BuildDialog(tester);

      await tester.tap(find.text('female'));
      await tester.pumpAndSettle();
      final maleRadioTile = tester.widget<RadioListTile<Gender>>(
          find.widgetWithText(RadioListTile<Gender>, 'female'));
      expect(maleRadioTile.groupValue, Gender.female);

      await tester.tap(find.text('active'));
      await tester.pumpAndSettle();
      final activeRadioTile = tester.widget<RadioListTile<Status>>(
          find.widgetWithText(RadioListTile<Status>, 'active'));
      expect(activeRadioTile.groupValue, Status.active);

      await tester.tap(find.text('Save & Close'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Given mock user, '
        'When user clicks on cancel button, '
        'Should close the dialog', (WidgetTester tester) async {
      await _BuildDialog(tester);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
