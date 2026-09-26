import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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

  void _updateCalculator(VoidCallback action) {
    setState(action);
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
      home: Scaffold(
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
                    icon: Image.asset('assets/min.png', width: 16, height: 16),
                  ),
                  IconButton(
                    onPressed: windowManager.close,
                    icon: Image.asset('assets/max.png', width: 16, height: 16),
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
                      style: const TextStyle(fontSize: 24, color: Colors.black),
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
                                  onPressed: () =>
                                      _updateCalculator(calculator.equals),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (historyOpen) const HistoryMenu(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
