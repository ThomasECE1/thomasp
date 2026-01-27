void main() {
  int? a;
  
  int b = a ?? 5;
  print(b);

  a = 10;

  int c = a;
  print(c);

  if (a % 2 != 0) {
    a = 3;
  }

  print(a.isEven);
}