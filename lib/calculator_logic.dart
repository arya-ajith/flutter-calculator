class CalculatorLogic {
  String display = '0';

  void inputNumber(String number) {
    if (display == '0') {
      display = number;
    } else {
      display += number;
    }
  }

  void clear() {
    display = '0';
  }

  void delete() {
    if (display.length > 1) {
      display = display.substring(0, display.length - 1);
    } else {
      display = '0';
    }
  }

  void inputDecimal() {
    if (!display.contains('.')) {
      display += '.';
    }
  }
}
