import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/common/utils/utils.dart';

void main() {
  group('Tests for user name initials functions', () {
    test(
        'Given name in lowercase words, '
        'when getUserNameInitials is called, '
        'then should return user name initials', () {
      final initial = getUserNameInitials("nakul pattewar");
      expect(initial, "NP");
    });

    test(
        'Given single name, '
        'when getUserNameInitials is called, '
        'then should return first letter', () {
      final initial = getUserNameInitials("nakul");
      expect(initial, "N");
    });

    test(
        'Given name with multiple spaces, '
        'when getUserNameInitials is called, '
        'then should ignore extra spaces', () {
      final initial = getUserNameInitials("  nakul    pattewar  ");
      expect(initial, "NP");
    });

    test(
        'Given name with mixed case, '
        'when getUserNameInitials is called, '
        'then should return uppercase initials', () {
      final initial = getUserNameInitials("NaKuL paTtewAr");
      expect(initial, "NP");
    });

    test(
        'Given empty string, '
        'when getUserNameInitials is called, '
        'then should return empty string', () {
      final initial = getUserNameInitials("");
      expect(initial, "");
    });

    test(
        'Given name with special characters, '
        'when getUserNameInitials is called, '
        'then should return initials of alphabetic characters', () {
      final initial = getUserNameInitials("@nakul *pattewar");
      expect(initial, "NP");
    });

    test(
        'Given name with hyphen, '
        'when getUserNameInitials is called, '
        'then should return initials of both parts', () {
      final initial = getUserNameInitials("Jean-Paul Sartre");
      expect(initial, "JS");
    });

    test(
        'Given name with multiple middle names, '
        'when getUserNameInitials is called, '
        'then should return first two initials', () {
      final initial = getUserNameInitials("Nakul Pattewar BE PICT");
      expect(initial, "NP");
    });

    test(
        'Given name with newline characters, '
        'when getUserNameInitials is called, '
        'then should handle correctly', () {
      final initial = getUserNameInitials("nakul\npattewar");
      expect(initial, "NP");
    });

    test(
        'Given name with tab characters, '
        'when getUserNameInitials is called, '
        'then should handle correctly', () {
      final initial = getUserNameInitials("nakul\tpattewar");
      expect(initial, "NP");
    });
  });

  group('Tests for email validation', () {
    test(
        'Given an empty email, '
        'when validateEmail is called, '
        'then should return appropriate message', () {
      final result = validateEmail("");
      expect(result, "Email can't be empty");
    });

    test(
        'Given an email without @ symbol, '
        'when validateEmail is called, '
        'then should return "Enter a valid email"', () {
      final result = validateEmail("nakulpattewar.com");
      expect(result, "Enter a valid email");
    });

    test(
        'Given an email without domain, '
        'when validateEmail is called, '
        'then should return "Enter a valid email"', () {
      final result = validateEmail("nakul@");
      expect(result, "Enter a valid email");
    });

    test(
        'Given a valid email, '
        'when validateEmail is called, '
        'then should return null', () {
      final result = validateEmail("nakul.pattewar@example.com");
      expect(result, null);
    });

    test(
        'Given an email with spaces, '
        'when validateEmail is called, '
        'then should return "Enter a valid email"', () {
      final result = validateEmail("nakul @example.com");
      expect(result, "Enter a valid email");
    });
  });

  group('Tests for name validation', () {
    test(
        'Given an empty name, '
        'when validateName is called, '
        'then should return "Name can\'t be empty"', () {
      final result = validateName("");
      expect(result, "Name can't be empty");
    });

    test(
        'Given a valid name, '
        'when validateName is called, '
        'then should return null', () {
      final result = validateName("Nakul Pattewar");
      expect(result, null);
    });

    test(
        'Given a name with leading/trailing spaces, '
        'when validateName is called, '
        'then should return null', () {
      final result = validateName("  Nakul Pattewar  ");
      expect(result, null);
    });
  });
}
