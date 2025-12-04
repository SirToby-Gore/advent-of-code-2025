import 'dart:io';

void main() {
  part2();
}

void part1() {
  // starting value = 50
  int dial = 50;
  int dialAtZeroCount = 0;

  for (String line in File('input').readAsLinesSync()) {
    int value = int.parse(line.substring(1)); 
    
    if (line.startsWith('L')) {
      dial -= value;
    } else {
      dial += value;
    }

    dial %= 100;

    if (dial == 0) {
      dialAtZeroCount++;
    }
  }

  print(dialAtZeroCount);
}

void part2() {
  // starting value = 50
  int dial = 50;
  int dialAtZeroCount = 0;

  for (String line in File('input').readAsLinesSync()) {
    int value = int.parse(line.substring(1)); 

    while (value > 0) {
      if (line.startsWith('L')) {
        dial--;
      } else {
        dial++;
      }

      dial %= 100;

      if (dial == 0) {
        dialAtZeroCount++;
      }

      value--;
    }
  }

  print(dialAtZeroCount);
}