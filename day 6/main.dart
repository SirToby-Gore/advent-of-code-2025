import 'dart:io';

void main() {
  // part1();
  part2();
}

void part1() {
  File inputFile = File('input');
  // File inputFile = File('test');

  List<List<String>> inputColumns = inputFile.readAsLinesSync().map((line) => line.split(' ').where((e) => e.trim().isNotEmpty).toList()).toList();
  int numberOfColumns = inputColumns.first.length;
  int numberOfRows = inputColumns.length;

  List<int> columns = [];
  String currentOperator = '';
  
  for (int col = 0; col < numberOfColumns; col++) {
    currentOperator = inputColumns.last.elementAt(col);
    switch (currentOperator) {
      case '*':
        columns.add(1);
        break;
      case '+':
        columns.add(0);
      default:
        throw ArgumentError.value('Operator ${currentOperator} not found');
    }

    for (int row = 0; row < numberOfRows - 1; row++) {
      switch (currentOperator) {
        case '*':
          columns.last *= int.parse(inputColumns.elementAt(row).elementAt(col));
          break;
        case '+':
          columns.last += int.parse(inputColumns.elementAt(row).elementAt(col));
        default:
          throw ArgumentError.value('Operator ${currentOperator} not found');
      }
    }
  }

  BigInt total = additiveSum(columns.map((number) => BigInt.from(number)).toList());

  print(total);
}

void part2() {
  File inputFile = File('input');
  // File inputFile = File('test');

  List<String> inputColumns = inputFile.readAsLinesSync().toList();
  int numberOfColumns = inputColumns.first.length;
  int numberOfRows = inputColumns.length;

  List<List<BigInt>> columns = [[]];
  String currentInteger = '';
  String currentChar = '';

  for (var column = numberOfColumns - 1; column >= 0; column--) {
    currentInteger = '';
    
    for (var row = 0; row < numberOfRows; row++) {
      currentChar = inputColumns[row][column];

      if (currentChar == '+' || currentChar == '*') {
        break;
      } 

      currentInteger += currentChar;
    }

    if (currentInteger.trim().isNotEmpty) {
      columns.last.add(BigInt.parse(currentInteger));
    }

    switch (currentChar) {
      case '*':
        columns.last = [multiplicativeSum(columns.last)];

        columns.add([]);
        break;
        
      case '+':
        columns.last = [additiveSum(columns.last)];

        columns.add([]);
        break;

      default:
        continue;
    }
  }

  columns = columns.where((column) => column.isNotEmpty).toList();
  print(additiveSum(columns.map((nums) => nums.first).toList()));
  print('3263827');
}

BigInt additiveSum(List<BigInt> nums) {
  BigInt total = BigInt.zero;

  nums.forEach((number) => total += number);

  return total;
}


BigInt multiplicativeSum(List<BigInt> nums) {
  BigInt total = BigInt.one;

  nums.forEach((number) => total *= number);

  return total;
}