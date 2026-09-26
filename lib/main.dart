import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/services.dart';

import 'history.dart';
import 'calculator_button.dart';
import 'calculator_logic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  const WindowOptions windowOptions = WindowOptions(
    size: Size(350, 500),
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool historyOpen = false;
  final CalculatorLogic calculator = CalculatorLogic();
  final HistoryManager history = HistoryManager();

  void _updateCalculator(VoidCallback action) {
    setState(action);
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    final key = event.logicalKey;
    final character = event.character;

    switch (key) {
      case LogicalKeyboardKey.numpad0:
      case LogicalKeyboardKey.digit0:
        _updateCalculator(() => calculator.inputNumber('0'));
        return;
      case LogicalKeyboardKey.numpad1:
      case LogicalKeyboardKey.digit1:
        _updateCalculator(() => calculator.inputNumber('1'));
        return;
      case LogicalKeyboardKey.numpad2:
      case LogicalKeyboardKey.digit2:
        _updateCalculator(() => calculator.inputNumber('2'));
        return;
      case LogicalKeyboardKey.numpad3:
      case LogicalKeyboardKey.digit3:
        _updateCalculator(() => calculator.inputNumber('3'));
        return;
      case LogicalKeyboardKey.numpad4:
      case LogicalKeyboardKey.digit4:
        _updateCalculator(() => calculator.inputNumber('4'));
        return;
      case LogicalKeyboardKey.numpad5:
      case LogicalKeyboardKey.digit5:
        _updateCalculator(() => calculator.inputNumber('5'));
        return;
      case LogicalKeyboardKey.numpad6:
      case LogicalKeyboardKey.digit6:
        _updateCalculator(() => calculator.inputNumber('6'));
        return;
      case LogicalKeyboardKey.numpad7:
      case LogicalKeyboardKey.digit7:
        _updateCalculator(() => calculator.inputNumber('7'));
        return;
      case LogicalKeyboardKey.numpad8:
      case LogicalKeyboardKey.digit8:
        _updateCalculator(() => calculator.inputNumber('8'));
        return;
      case LogicalKeyboardKey.numpad9:
      case LogicalKeyboardKey.digit9:
        _updateCalculator(() => calculator.inputNumber('9'));
        return;
      case LogicalKeyboardKey.period:
      case LogicalKeyboardKey.numpadDecimal:
        _updateCalculator(calculator.inputDecimal);
        return;
      case LogicalKeyboardKey.add:
      case LogicalKeyboardKey.numpadAdd:
        _updateCalculator(() => calculator.inputOperator('+', '+'));
        return;
      case LogicalKeyboardKey.minus:
      case LogicalKeyboardKey.numpadSubtract:
        _updateCalculator(() => calculator.inputOperator('-', '-'));
        return;
      case LogicalKeyboardKey.slash:
      case LogicalKeyboardKey.numpadDivide:
        _updateCalculator(() => calculator.inputOperator('÷', '/'));
        return;
      case LogicalKeyboardKey.enter:
      case LogicalKeyboardKey.numpadEnter:
      case LogicalKeyboardKey.equal:
        _updateCalculator(() {
          final expression = calculator.display;
          calculator.equals();

          if (calculator.display != 'Error') {
            history.add(expression, calculator.display);
          }
        });
        return;
      case LogicalKeyboardKey.backspace:
        _updateCalculator(calculator.delete);
        return;
      case LogicalKeyboardKey.escape:
        _updateCalculator(calculator.clear);
        return;
      default:
        break;
    }

    switch (character) {
      case '%':
        _updateCalculator(calculator.inputPercentage);
        return;
      case '*':
        _updateCalculator(() => calculator.inputOperator('x', '*'));
        return;
      default:
        break;
    }

    if (key == LogicalKeyboardKey.numpadMultiply) {
      _updateCalculator(() => calculator.inputOperator('x', '*'));
    }
  }

  Widget _buildButton({
    String? text,
    String? image,
    double width = 57,
    double height = 57,
    Color backgroundColor = Colors.white,
    Color hoverColor = const Color(0xFFBCBCBC),
    Color pressedColor = const Color(0xFFA7A7A7),
    required VoidCallback onPressed,
  }) {
    return CalculatorButton(
      text: text,
      image: image,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      hoverColor: hoverColor,
      pressedColor: pressedColor,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          _handleKey(event);
          return KeyEventResult.handled;
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 40,
                color: const Color(0xFFE1E1E1),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Text('Calculator', style: TextStyle(fontSize: 16)),
                    const Spacer(),
                    IconButton(
                      onPressed: windowManager.minimize,
                      icon: Image.asset(
                        'assets/min.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: windowManager.close,
                      icon: Image.asset(
                        'assets/max.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 145,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      bottom: 7,
                      child: GestureDetector(
                        onTap: () => setState(() => historyOpen = !historyOpen),
                        child: Image.asset(
                          'assets/history.png',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      top: 58,
                      child: Text(
                        calculator.display,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: const Color(0xFFF0F0F0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 63,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  _buildButton(
                                    text: 'C',
                                    onPressed: () =>
                                        _updateCalculator(calculator.clear),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    image: 'assets/delete.png',
                                    onPressed: () =>
                                        _updateCalculator(calculator.delete),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '%',
                                    onPressed: () => _updateCalculator(
                                      calculator.inputPercentage,
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    image: 'assets/divide.png',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputOperator('÷', '/'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 63,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  _buildButton(
                                    text: '7',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('7'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '8',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('8'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '9',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('9'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    image: 'assets/multiply.png',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputOperator('x', '*'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 63,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  _buildButton(
                                    text: '4',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('4'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '5',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('5'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '6',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('6'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    image: 'assets/minus.png',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputOperator('-', '-'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 63,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  _buildButton(
                                    text: '1',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('1'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '2',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('2'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    text: '3',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('3'),
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  _buildButton(
                                    image: 'assets/add.png',
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputOperator('+', '+'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 61,
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  _buildButton(
                                    text: '0',
                                    width: 158,
                                    height: 44,
                                    onPressed: () => _updateCalculator(
                                      () => calculator.inputNumber('0'),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  _buildButton(
                                    image: 'assets/dot.png',
                                    width: 76,
                                    height: 44,
                                    onPressed: () => _updateCalculator(
                                      calculator.inputDecimal,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  _buildButton(
                                    image: 'assets/equal.png',
                                    width: 76,
                                    height: 44,
                                    backgroundColor: const Color(0xFF827F7F),
                                    hoverColor: const Color(0xFF6B6B6B),
                                    pressedColor: const Color(0xFF464646),
                                    onPressed: () => _updateCalculator(() {
                                      String expression = calculator.display;

                                      calculator.equals();

                                      if (calculator.display != 'Error') {
                                        history.add(
                                          expression,
                                          calculator.display,
                                        );
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (historyOpen)
                      HistoryMenu(
                        history: history,
                        onHistorySelected: (item) {
                          setState(() {
                            calculator.display = item.expression;

                            calculator.expression = item.expression
                                .replaceAll('x', '*')
                                .replaceAll('÷', '/');

                            calculator.justCalculated = false;
                            calculator.percentPending = false;

                            historyOpen = false;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
