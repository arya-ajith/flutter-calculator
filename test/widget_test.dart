import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/calculator_logic.dart';

void main() {
  group('CalculatorLogic', () {
    test(
      'starts at zero and accepts digits without changing the initial output',
      () {
        final calculator = CalculatorLogic();

        expect(calculator.display, '0');
        expect(calculator.expression, isEmpty);

        calculator.inputNumber('1');
        expect(calculator.display, '1');
        expect(calculator.expression, '1');

        calculator.inputNumber('2');
        expect(calculator.display, '12');
        expect(calculator.expression, '12');
      },
    );

    test('evaluates a simple addition exactly as the app displays it', () {
      final calculator = CalculatorLogic();

      calculator.inputNumber('2');
      calculator.inputOperator('+', '+');
      calculator.inputNumber('3');
      calculator.equals();

      expect(calculator.display, '5');
      expect(calculator.expression, '5');
    });
  });
}
