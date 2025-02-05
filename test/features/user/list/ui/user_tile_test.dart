import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/common/constants/strings.dart';
import 'package:user_app/common/widgets/popup_options_button.dart';
import 'package:user_app/common/widgets/user_status_widget.dart';
import 'package:user_app/features/user/list/network/user_response.dart';
import 'package:user_app/features/user/list/ui/user_tile.dart';

void main() {
  group('Tests for user tile widget', () {
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

    testWidgets(
        'Given UserResponse object, '
        'when UserTile widget rendered,'
        'then should render widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserTile(
              user: mockUser,
            ),
          ),
        ),
      );

      final nameFinder = find.text('NP');
      final emailFinder = find.text('abc@gmail.com');
      final genderFinder = find.byIcon(Icons.male);
      final statusFinder = find.byType(UserStatusWidget);

      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(genderFinder, findsOneWidget);
      expect(statusFinder, findsOneWidget);
    });

    testWidgets(
        'Given userResponse object mockUser, '
        'when user clicks on popup button, '
        'then should return popup options correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserTile(user: mockUser),
          ),
        ),
      );

      final popupButtonFinder = find.byType(PopupOptionsButton);
      expect(popupButtonFinder, findsOneWidget);

      await tester.tap(popupButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text(userDialogEditOptionText), findsOneWidget);
      expect(find.text(userDialogDeleteOptionText), findsOneWidget);
    });
  });
}
