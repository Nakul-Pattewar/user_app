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
}
