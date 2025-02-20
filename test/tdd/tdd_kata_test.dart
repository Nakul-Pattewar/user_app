import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/tdd/tdd_kata.dart';

void main() {
  test(
      "Given add method,"
      "When empty string is passed,"
      "Should return 0", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("");

    expect(ans, 0);
  });

  test(
      "Given add method,"
      "When one number is provided in string format,"
      "Then should return that number in integer format", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("49");

    expect(ans, 49);
  });

  test(
      "Given add method,"
      "When multiple numbers are provided in string separated by commas,"
      "Then should return correct sum", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("1,2,56");

    expect(ans, 59);
  });

  test(
      "Given add method,"
      "When multiple numbers are provided in string separated by commas & newline'\n',"
      "Then should return correct sum", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("1,2\n56");

    expect(ans, 59);
  });

  test(
      "Given add method,"
      "When multiple numbers are provided in string with custom delimiters,"
      "Then should return correct sum", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("//[;]\n1;2");

    expect(ans, 3);
  });

  test(
      "Given add method,"
      "When negative number is provided in string,"
      "Then should throw exception", () {
    StringCalculator stringCalculator = StringCalculator();

    expect(() => stringCalculator.add("//[;]\n1;-2;-4;3;-7"),
        throwsA(isA<Exception>()));
  });

  test(
      "Given add method,"
      "When multiple negative numbers are provided in string,"
      "Then should throw exception with all negative numbers in string", () {
    StringCalculator stringCalculator = StringCalculator();

    expect(() => stringCalculator.add("//[;]\n1;-2;-4;3;-7"),
        throwsA(isA<Exception>()));
  });

  test(
      "Given getCalledCount method,"
      "When getCalledCount function is called,"
      "Then should return number representing how many times add function is called",
      () {
    StringCalculator stringCalculator = StringCalculator();
    stringCalculator.add("1,2");
    stringCalculator.add("//[;]\n2; 4; 5");
    int ans = stringCalculator.getCalledCount();

    expect(ans, 2);
  });

  test(
      "Given add method,"
      "When number greater than equal to 1000 comes in string,"
      "Then should ignore such numbers", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("1,1000,2,2000");

    expect(ans, 3);
  });

  test(
      "Given add method,"
      "When add function is called,"
      "Then should handle delimiter of any length", () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("//[***][;][&&]\n2*** 4; 5&&2");

    expect(ans, 13);
  });

  test(
      "Given add method,"
      "When add method is called,"
      "Then should handle multiple delimiters & each delimiter having multiple characters",
      () {
    StringCalculator stringCalculator = StringCalculator();
    int ans = stringCalculator.add("//[**][%%][*%]\n1**2%%3*%10");

    expect(ans, 16);
  });
}
