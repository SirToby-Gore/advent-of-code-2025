import 'dart:io';

void main() {
  // List<String> lines = File('test').readAsLinesSync().map((line) => '.${line}.').toList();
  List<String> lines = File('input').readAsLinesSync().map((line) => '.${line}.').toList();
  lines = [
    '.' * lines.first.length,
    ...lines,
    '.' * lines.first.length,
  ];

  int numberOFMoveablePaper = 0;
  
  // step 2
  int removedNumberOfRolls = 0;

  // step 2
  while (true) {
    print('\n\n');
    removedNumberOfRolls = 0;

    // step 1
    for (var row = 1; row < lines.length - 1; row++) {
      for (var column = 1; column < lines.elementAt(row).length - 1; column++) {
        if (lines[row][column] != '@') {
          stdout.write('.');
          continue;
        }
        
        int countOfPaper = 0;

        for (var superColumn = column - 1; superColumn < column + 2; superColumn++) {
          for (var superRow = row - 1; superRow < row + 2; superRow++) {
            if (row == superRow && column == superColumn) {
              continue;
            }

            if (lines[superRow][superColumn] == '@') {
              countOfPaper++;
            }
          }
        }

        if (countOfPaper < 4) {
          numberOFMoveablePaper++;
          removedNumberOfRolls++;
          stdout.write('x');

          String newLine = '';

          for (var subColumn = 0; subColumn < lines[row].length; subColumn++) {
            if (subColumn == column) {
              newLine += '.';
            } else {
              newLine += lines[row][subColumn];
            }
          }

          lines[row] = newLine;
        } else {
          stdout.write('@');
        }
      }

      stdout.write('\n');
    }

    // step 2
    if (removedNumberOfRolls == 0) {
      break;
    }
  }

  print('moveable stacks: ${numberOFMoveablePaper}');
}