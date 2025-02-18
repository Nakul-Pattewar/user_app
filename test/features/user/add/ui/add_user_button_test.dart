import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/features/user/add/ui/add_user_button.dart';

void main() {
  group("AddUserButton tests", () {
    testWidgets(
      'Given AddUserButton, '
      'When tapped, '
      'Then should show an alert dialog with title "Add user"',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AddUserButton(),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text(addUserDialogTitle), findsExactly(2));
      },
    );
  });
}
