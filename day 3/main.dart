import 'dart:io';

void main() {
  BigInt total = BigInt.zero;
  const int lengthOfString = 12;

  File('input').readAsLinesSync().forEach((String line) {
  // File('test').readAsLinesSync().forEach((String line) {
    // #region part 1

    // Set<String> values = {};

    // for (int i = 0; i < line.length - 1; i++) {
    //   String currentDigit = line[i];

    //   for (int j = i + 1; j < line.length; j++) {
    //     String currentSubDigit = line[j];

    //     values.add(currentDigit + currentSubDigit);
    //   }
    // }

    // List listVals = values.toList(); 
    // listVals.sort();
    
    // total += BigInt.parse(listVals.last);

    // #endregion part 1

    
    // #region part 2

    int digitsToDiscard = line.length - lengthOfString;
    List<String> result = []; 

    for (int i = 0; i < line.length; i++) {
      String currentDigit = line[i];

      while (digitsToDiscard > 0 && result.isNotEmpty && currentDigit.compareTo(result.last) > 0) {
        result.removeLast();

        digitsToDiscard--;
      }

      result.add(currentDigit);
    }

    String maxString = result.take(lengthOfString).join();
    
    total += BigInt.parse(maxString);

    // #endregion part 2
  });

  print('Total: ${total}');
}