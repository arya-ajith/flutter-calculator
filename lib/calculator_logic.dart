import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';

class CalculatorLogic {
  String display = '0';
  String expression = '';

  bool percentPending = false;
  bool justCalculated = false;

  void inputNumber(String number) {
    if (justCalculated) {
      display = number;
      expression = number;
      justCalculated = false;
      percentPending = false;
      return;
    }

    String currentNumber = display
        .split(' ')
        .last
        .replaceAll('%', '')
        .replaceAll(',', '');

    int digitCount = currentNumber.replaceAll('.', '').length;

    if (digitCount >= 15) {
      return;
    }

    if (display == '0') {
      display = '';
      expression = expression.isEmpty ? '' : expression;
    }

    display += number;
    expression += number;
  }

  void inputDecimal() {
    if (justCalculated) {
      display = '0.';
      expression = '0.';
      justCalculated = false;
      percentPending = false;
      return;
    }

    String currentNumber = display.split(' ').last.replaceAll('%', '');

    if (currentNumber.contains('.')) {
      return;
    }

    display += '.';
    expression += '.';
  }

  void inputOperator(String displayOperator, String calculationOperator) {
    display = display.trimRight();
    expression = expression.trimRight();

    if (justCalculated) {
      justCalculated = false;
      percentPending = false;
    }

    if (percentPending) {
      percentPending = false;
    }

    if (_endsWithOperator(expression)) {
      _replaceLastOperator(displayOperator, calculationOperator);
      return;
    }

    display += ' $displayOperator ';
    expression += ' $calculationOperator ';
  }

  void inputPercentage() {
    if (percentPending) {
      return;
    }

    if (expression.isEmpty ||
        expression.endsWith(' ') ||
        _endsWithOperator(expression)) {
      return;
    }

    display += '%';
    expression += ' %';

    percentPending = true;
    justCalculated = false;
  }

  void equals() {
    if (expression.isEmpty) {
      return;
    }

    try {
      String result = _evaluateExpression(expression);

      display = _formatNumber(result);
      expression = result;

      percentPending = false;
      justCalculated = true;
    } catch (e) {
      display = 'Error';
      expression = '';
      percentPending = false;
      justCalculated = true;
    }
  }

  void clear() {
    display = '0';
    expression = '';
    percentPending = false;
    justCalculated = false;
  }

  void delete() {
    if (display == '0' || display.isEmpty) {
      return;
    }

    if (justCalculated) {
      display = '0';
      expression = '';
      justCalculated = false;
      percentPending = false;
      return;
    }

    if (display.endsWith('%')) {
      display = display.substring(0, display.length - 1);

      expression = expression.trimRight();

      if (expression.endsWith('%')) {
        expression = expression.substring(0, expression.length - 1);
      }

      percentPending = false;
      return;
    }

    if (display.endsWith(' ')) {
      display = display.trimRight();

      if (display.isNotEmpty) {
        display = display.substring(0, display.length - 1);
      }

      display = display.trimRight();

      expression = expression.trimRight();

      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }

      expression = expression.trimRight();

      return;
    }

    if (display.length > 1) {
      display = display.substring(0, display.length - 1);
    } else {
      display = '0';
    }

    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
    }
  }

  String _evaluateExpression(String input) {
    List<String> tokens = input.trim().split(RegExp(r'\s+'));

    if (tokens.isEmpty) {
      throw Exception('Invalid expression');
    }

    List<String> processedTokens = [];

    for (int i = 0; i < tokens.length; i++) {
      String token = tokens[i];

      if (token == '%') {
        if (processedTokens.isEmpty) {
          throw Exception('Invalid percentage');
        }

        Decimal percentageValue = Decimal.parse(processedTokens.removeLast());

        if (i + 1 < tokens.length &&
            (tokens[i + 1] == '*' || tokens[i + 1] == '/')) {
          Decimal percentage = _divide(percentageValue, Decimal.fromInt(100));

          processedTokens.add(percentage.toString());
        } else {
          if (processedTokens.length < 2) {
            Decimal percentage = _divide(percentageValue, Decimal.fromInt(100));

            processedTokens.add(percentage.toString());

            continue;
          }

          String previousOperator = processedTokens.removeLast();

          Decimal baseValue = Decimal.parse(processedTokens.removeLast());

          Decimal percentage = _divide(
            baseValue * percentageValue,
            Decimal.fromInt(100),
          );

          Decimal contextualResult;

          if (previousOperator == '+') {
            contextualResult = baseValue + percentage;
          } else if (previousOperator == '-') {
            contextualResult = baseValue - percentage;
          } else {
            processedTokens.add(baseValue.toString());

            processedTokens.add(previousOperator);

            processedTokens.add(
              _divide(percentageValue, Decimal.fromInt(100)).toString(),
            );

            continue;
          }

          processedTokens.add(contextualResult.toString());
        }
      } else {
        processedTokens.add(token);
      }
    }

    return _calculateTokens(processedTokens);
  }

  String _calculateTokens(List<String> tokens) {
    if (tokens.isEmpty) {
      throw Exception('Invalid expression');
    }

    List<String> values = List.from(tokens);

    int i = 0;

    while (i < values.length) {
      if (values[i] == '*' || values[i] == '/') {
        Decimal a = Decimal.parse(values[i - 1]);
        Decimal b = Decimal.parse(values[i + 1]);

        if (values[i] == '/' && b == Decimal.zero) {
          throw Exception('Division by zero');
        }

        Decimal result;

        if (values[i] == '*') {
          result = a * b;
        } else {
          result = _divide(a, b);
        }

        values.replaceRange(i - 1, i + 2, [result.toString()]);

        i--;
      } else {
        i++;
      }
    }

    Decimal result = Decimal.parse(values[0]);

    i = 1;

    while (i < values.length) {
      String operator = values[i];

      Decimal number = Decimal.parse(values[i + 1]);

      if (operator == '+') {
        result = result + number;
      } else if (operator == '-') {
        result = result - number;
      }

      i += 2;
    }

    return result.toString();
  }

  Decimal _divide(Decimal a, Decimal b) {
    if (b == Decimal.zero) {
      throw Exception('Division by zero');
    }

    Rational result = a / b;

    return result.toDecimal(scaleOnInfinitePrecision: 30);
  }

  String _formatNumber(String value) {
    if (value.contains('.')) {
      value = value.replaceFirst(RegExp(r'0+$'), '');

      if (value.endsWith('.')) {
        value = value.substring(0, value.length - 1);
      }
    }

    bool negative = value.startsWith('-');
    String cleanValue = negative ? value.substring(1) : value;

    String integerPart = cleanValue.split('.').first;

    if (integerPart.length > 15) {
      return _toScientificNotation(value);
    }

    return _addCommas(value);
  }

  String _toScientificNotation(String value) {
    bool negative = value.startsWith('-');

    if (negative) {
      value = value.substring(1);
    }

    String digits = value.replaceAll('.', '');

    digits = digits.replaceFirst(RegExp(r'^0+'), '');

    if (digits.isEmpty) {
      return '0';
    }

    String integerPart = value.split('.').first;

    int exponent = integerPart.length - 1;

    if (digits.length > 10) {
      String firstTen = digits.substring(0, 10);
      String nextDigit = digits[10];

      int rounded = int.parse(firstTen);

      if (int.parse(nextDigit) >= 5) {
        rounded++;
      }

      String roundedDigits = rounded.toString();

      if (roundedDigits.length > 10) {
        exponent++;
        roundedDigits = roundedDigits.substring(0, 10);
      }

      digits = roundedDigits;
    }

    String mantissa;

    if (digits.length == 1) {
      mantissa = digits;
    } else {
      mantissa = '${digits[0]}.${digits.substring(1)}';
    }

    if (mantissa.contains('.')) {
      mantissa = mantissa.replaceFirst(RegExp(r'0+$'), '');

      if (mantissa.endsWith('.')) {
        mantissa = mantissa.substring(0, mantissa.length - 1);
      }
    }

    return '${negative ? '-' : ''}$mantissa'
        'E+$exponent';
  }

  String _addCommas(String value) {
    bool negative = value.startsWith('-');

    if (negative) {
      value = value.substring(1);
    }

    List<String> parts = value.split('.');

    String integerPart = parts[0];

    String decimalPart = parts.length > 1 ? parts[1] : '';

    StringBuffer formattedInteger = StringBuffer();

    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger.write(',');
      }

      formattedInteger.write(integerPart[i]);
    }

    String result = formattedInteger.toString();

    if (decimalPart.isNotEmpty) {
      result += '.$decimalPart';
    }

    if (negative) {
      result = '-$result';
    }

    return result;
  }

  bool _endsWithOperator(String value) {
    String trimmed = value.trimRight();

    if (trimmed.isEmpty) {
      return false;
    }

    String lastCharacter = trimmed[trimmed.length - 1];

    return lastCharacter == '+' ||
        lastCharacter == '-' ||
        lastCharacter == '*' ||
        lastCharacter == '/';
  }

  void _replaceLastOperator(
    String displayOperator,
    String calculationOperator,
  ) {
    display = display.trimRight();
    expression = expression.trimRight();

    display = display.substring(0, display.length - 1);

    expression = expression.substring(0, expression.length - 1);

    display += displayOperator;
    expression += calculationOperator;

    display += ' ';
    expression += ' ';
  }
}
