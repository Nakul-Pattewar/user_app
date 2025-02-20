class StringCalculator {
  late int calledCount = 0;
  final String ultimateDelimiter = ",";

  int add(String numbers) {
    int sum = 0;
    bool doInputContainsNegatives = true;
    String negatives = "";

    calledCount++;

    if (numbers.isEmpty) return 0;

    //default delimiters
    Set<String> delimiters = {'\n', '[', ']', '/'};

    //get all delimiters
    if (numbers[0] == '/') {
      String currentDelimiter = "";
      bool isDelimiter = false;
      for (int i = 0; i < numbers.length; i++) {
        if (numbers[i] == '[') {
          isDelimiter = true;
        } else if (numbers[i] == ']') {
          delimiters.add(currentDelimiter);
          currentDelimiter = "";
          isDelimiter = false;
        } else if (isDelimiter) {
          currentDelimiter += numbers[i];
        }
      }
    }

    //format string using all delimiters
    String formattedNumbers = numbers;
    for (String delimiter in delimiters) {
      formattedNumbers =
          formattedNumbers.replaceAll(delimiter, ultimateDelimiter);
    }

    //get Strings array from formatted string
    final numbersArray = formattedNumbers.split(ultimateDelimiter);
    if (numbersArray.isEmpty && formattedNumbers.isNotEmpty) {
      numbersArray.add(formattedNumbers);
    }

    //calculate sum & handle edge cases
    for (String current in numbersArray) {
      if (current.isNotEmpty) {
        int currentNumber = int.parse(current);
        if (currentNumber < 0) {
          doInputContainsNegatives = false;
          negatives += ", $current";
        } else if (currentNumber >= 1000) {
          continue;
        }
        sum += currentNumber;
      }
    }
    if (!doInputContainsNegatives) {
      throw (Exception("negatives not allowed $negatives"));
    }
    return sum;
  }

  //function to get how many times add method is called
  int getCalledCount() {
    return calledCount;
  }
}
