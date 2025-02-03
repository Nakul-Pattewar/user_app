import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/common/constants/enums.dart';
import 'package:user_app/common/extensions/string_extensions.dart';

void main() {
  group("tests for gender parser", () {
    test(
        "Given string is completely uppercase, "
        "when toGender() called on string, "
        "then it should return correct gender", () {
      final Gender g = 'MALE'.toGender();
      expect(g, Gender.male);
    });

    test(
        "Given string is completely lowercase, "
        "when toGender() called, "
        "then it should return correct gender", () {
      final Gender g = 'female'.toGender();
      expect(g, Gender.female);
    });

    test(
        "Given string is not a gender, "
        "when toGender() is called, "
        "then it should return undefined", () {
      final Gender g = 'abc'.toGender();

      expect(g, Gender.undefined);
    });

    test(
        "Given string is empty, "
        "when toGender() is called, "
        "then it should return undefined", () {
      final Gender g = ''.toGender();

      expect(g, Gender.undefined);
    });

    test(
        "Given string is mix of lowercase and uppercase letters,"
        "when toGender() is called, "
        "then it should return correct gender", () {
      final Gender g = 'mALe'.toGender();

      expect(g, Gender.male);
    });

    test(
        "Given string contains trailing spaces, "
        "when toGender() is called, "
        "then it should return correct gender", () {
      final Gender g = 'male  '.toGender();
      expect(g, Gender.male);
    });

    test(
        "Given string contains leading spaces, "
        "when toGender() is called, "
        "then it should return correct gender", () {
      final Gender g = '  female'.toGender();
      expect(g, Gender.female);
    });

    test(
        "Given string contains multiple spaces in between, "
        "when toGender() is called, "
        "then it should return correct gender", () {
      final Gender g = 'f e m a l e'.toGender();
      expect(g, Gender.female);
    });

    test(
        "Given string contains special characters, "
        "when toGender() is called, "
        "then it should return undefined", () {
      final Gender g = 'm@le'.toGender();
      expect(g, Gender.undefined);
    });

    test(
        "Given string contains numbers, "
        "when toGender() is called, "
        "then it should return undefined", () {
      final Gender g = 'male123'.toGender();
      expect(g, Gender.undefined);
    });
  });

  group("test cases for status parser", () {
    test(
        "Given string is completely uppercase, "
        "when toStatus() called on string, "
        "then it should return correct status", () {
      final Status s = 'ACTIVE'.toStatus();
      expect(s, Status.active);
    });

    test(
        "Given string is completely lowercase, "
        "when toStatus() called, "
        "then it should return correct status", () {
      final Status s = 'inactive'.toStatus();
      expect(s, Status.inactive);
    });

    test(
        "Given string is not a status, "
        "when toStatus() is called, "
        "then it should return undefined", () {
      final Status s = 'abc'.toStatus();

      expect(s, Status.undefined);
    });

    test(
        "Given string is empty, "
        "when toStatus() is called, "
        "then it should return undefined", () {
      final Status s = ''.toStatus();

      expect(s, Status.undefined);
    });

    test(
        "Given string is mix of lowercase and uppercase letters,"
        "when toStatus() is called, "
        "then it should return correct status", () {
      final Status s = 'InAcTIve'.toStatus();

      expect(s, Status.inactive);
    });

    test(
        "Given string contains trailing spaces, "
        "when toStatus() is called, "
        "then it should return correct status", () {
      final Status s = 'active  '.toStatus();
      expect(s, Status.active);
    });

    test(
        "Given string contains leading spaces, "
        "when toStatus() is called, "
        "then it should return correct status", () {
      final Status s = '  active'.toStatus();
      expect(s, Status.active);
    });

    test(
        "Given string contains multiple spaces in between, "
        "when toStatus() is called, "
        "then it should return correct status", () {
      final Status s = 'i n ac t i v e '.toStatus();
      expect(s, Status.inactive);
    });

    test(
        "Given string contains special characters, "
        "when toStatus() is called, "
        "then it should return undefined", () {
      final Status s = 'in@ctive'.toStatus();
      expect(s, Status.undefined);
    });

    test(
        "Given string contains numbers, "
        "when toStatus() is called, "
        "then it should return undefined", () {
      final Status s = 'active123'.toStatus();
      expect(s, Status.undefined);
    });
  });
}
