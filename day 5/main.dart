import 'dart:io';

bool debug = false;

void main() { 
  List<List<int>> validRanges = [];
  int numberOfFreshIds = 0;
  
  int pointer = 0;

  // List<String> lines = File('test').readAsLinesSync();
  List<String> lines = File('input').readAsLinesSync();

  while(pointer < lines.length) {
    String line = lines[pointer];
    
    if (line.isEmpty) {
      break;
    }
    
    int start = int.parse(line.split('-').first);
    int end = int.parse(line.split('-').last);

    validRanges.add([start, end]);

    pointer++;
  }

  // #region part 1

  // pointer++;

  // while(pointer < lines.length) {
  //   String line = lines[pointer];
    
  //   int id = int.parse(line.trim());

  //   for (List<int> range in validRanges) {
  //     if (range.first <= id && id <= range.last) {
  //       numberOfFreshIds++; 

  //       break;
  //     }
  //   }

  //   pointer++;
  // }

  // print(numberOfFreshIds);

  // #endregion part 1 


  // #region part 2

  validRanges.sort((a, b) => a.first.compareTo(b.first));
  List<List<int>> newRanges = [validRanges.first];

  for (List<int> range in validRanges) {
    logMessage('range: ${range}');
    
    logMessage('ranges :');
    logMessage(newRanges);
    
    int i = range.first - 1;
    while (i < range.last) {
      i++;
      logMessage('i: ${i}');
      
      bool inRangeAlready = false;
      
      for (List<int> subRange in newRanges) {
        if (subRange.first <= i && i <= subRange.last) {
          inRangeAlready = true;
          i = subRange.last;
          print('moved i to ${i}');
          break;
        }
      }

      if (inRangeAlready) {
        // logMessage('already in range');
        continue;
      }

      bool rangeMovedLeft = false;
      int pointer = 0;

      while (pointer < newRanges.length) {
        List<int> subRange = newRanges.elementAt(pointer);

        if (i == subRange.first - 1) {
          subRange.first--;

          if (pointer > 0) {
            if (newRanges.elementAt(pointer - 1).last == subRange.first) {
              newRanges.elementAt(pointer - 1).last = subRange.last;
              newRanges.removeAt(pointer);
              rangeMovedLeft = true;

              break;
            }
          }
        }

        pointer++;
      }

      if (rangeMovedLeft) {
        logMessage('range moved left');
        continue;
      }

      bool rangeMovedRight = false;
      pointer = 0;

      while (pointer < newRanges.length) {
        List<int> subRange = newRanges.elementAt(pointer);

        if (i == subRange.last + 1) {
          subRange.last++;

          if (pointer > 0) {
            if (newRanges.elementAt(pointer - 1).last == subRange.last) {
              newRanges.elementAt(pointer - 1).last = subRange.last;
              newRanges.removeAt(pointer);
              rangeMovedRight = true;

              break;
            }
          }
        }

        pointer++;
      }

      if (rangeMovedRight) {
        logMessage('range moved right');
        continue;
      }

      logMessage('new range added');
      newRanges.add([i, range.last]);
    }
  }

  pointer = 0;

  while (pointer < newRanges.length - 1) {
    if (newRanges.elementAt(pointer).last >= newRanges.elementAt(pointer + 1).first) {
      newRanges.elementAt(pointer).last = newRanges.elementAt(pointer + 1).last;
      newRanges.removeAt(pointer + 1);

      continue;
    }

    pointer++;
  }
  
  int total = 0;

  for (var range in newRanges) {
    total += (range.last + 1) - range.first;
  }

  print('total: ${total}');
  print('ranges :');
  print(newRanges);

  // #endregion part 2
}

void logMessage(Object object) {
  if (debug) {
    print(object);
  }
}