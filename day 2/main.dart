import 'dart:io';

void main() {
  print('starting...');
  
  File('input').readAsStringSync().trim().replaceAll('\n', '').split(',').forEach((line) {
  // File('test').readAsStringSync().trim().replaceAll('\n', '').split(',').forEach((line) {
    print('scanning: "${line}"');
    Product product = Product.fromString(line);
    product.checkRange();
  });

  // print(Id.invalidIds);
  // print(Id.validIds);
  int total = 0;

  Id.invalidIds.forEach((element) => total += int.parse(element));

  print('total: ${total}');
  print('done');
}

class Id {
  static List<String> invalidIds = [];
  static List<String> validIds = [];

  String id;

  Id(this.id);

  bool isValid() {
    int halfWayLength = this.id.length ~/ 2;

    // #region part 1

    // if (this.id.substring(0, halfWayLength) == this.id.substring(halfWayLength)) {
    //   return false;
    // }

    // #endregion part 1

    // #region part 2

    for (var i = 0; i <= halfWayLength; i++) {
      String subString = this.id.substring(0, i);

      if (this.id.replaceAll(subString, '').length == 0) {
        print('flagged: ${this.id}');
        return false;
      } 
    }

    // #endregion part 2

    return true;
  }

  void check() {
    bool isValidId = this.isValid();

    if (isValidId) {
      Id.validIds.add(this.id);
    } else {
      Id.invalidIds.add(this.id);
    }
  }
}

class Product {
  final int start;
  final int end;

  
  Product(this.start, this.end);
  
  Product.fromString(String id): start = int.parse(id.split('-').first), end = int.parse(id.split('-').last);

  void checkRange() {
    for (var i = this.start; i <= this.end; i++) {
      Id id = Id(i.toString());
      id.check();
    }
  }
}