import 'dart:io';

main() {
  print("Nhập số n: ");
  String? str = stdin.readLineSync();

  try {
    int number = int.parse(str!);
    print(number);
    if (number > 10000) {
      print("Số quá lớn, vui lòng chọn lại");
      return;
    }
    int fibo = calculate(number);
    print("Số Fibonaci thứ n là: $fibo");
  } on FormatException {
    print("Vui lòng nhập số nguyên");
  } on Exception {
    print("Có lỗi xảy ra, vui lòng thử lại");
  }
}

int calculate(int n) {
  if (n < 0) {
    return -1;
  } else if (n == 0 || n == 1) {
    return n;
  } else {
    int a = 0;
    int b = 1;
    int c = 1;
    for (int i = 2; i < n; i++) {
      a = b;
      b = c;
      c = a + b;
    }

    return c;
  }
}
