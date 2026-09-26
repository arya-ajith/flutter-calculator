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
  CalculatorLogic calculator = CalculatorLogic();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // ---------------- TITLE BAR ----------------

            Container(
              height: 40,
              color: const Color(0xFFE1E1E1),

              child: Row(
                children: [
                  const SizedBox(width: 16),

                  const Text('Calculator', style: TextStyle(fontSize: 16)),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      windowManager.minimize();
                    },
                    icon: Image.asset('assets/min.png', width: 16, height: 16),
                  ),

                  IconButton(
                    onPressed: () {
                      windowManager.close();
                    },
                    icon: Image.asset('assets/max.png', width: 16, height: 16),
                  ),
                ],
              ),
            ),

            // ---------------- DISPLAY ----------------
            Container(
              height: 145,
              color: Colors.white,

              child: Stack(
                children: [
                  // History button
                  Positioned(
                    left: 10,
                    bottom: 7,

                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          historyOpen = !historyOpen;
                        });
                      },

                      child: Image.asset(
                        'assets/history.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),

                  // Expression
                  Positioned(
                    right: 6,
                    top: 36,

                    child: Text(
                      calculator.display,
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),

                  // Result
                  Positioned(
                    right: 6,
                    top: 87,

                    child: const Text(
                      '144',
                      style: TextStyle(fontSize: 14, color: Color(0xFF858585)),
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- KEYPAD ----------------
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: const Color(0xFFF0F0F0),

                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),

                      child: Column(
                        children: [
                          // -------- ROW 1 --------

                          SizedBox(
                            height: 63,

                            child: Row(
                              children: [
                                const SizedBox(width: 10),

                                CalculatorButton(
                                  text: 'C',
                                  onPressed: () {
                                    setState(() {
                                      calculator.clear();
                                    });
                                  },
                                ),

                                const SizedBox(width: 34),

                                CalculatorButton(
                                  image: 'assets/delete.png',
                                  onPressed: () {
                                    setState(() {
                                      calculator.delete();
                                    });
                                  },
                                ),

                                const SizedBox(width: 34),

                                CalculatorButton(text: '%'),

                                const SizedBox(width: 34),

                                CalculatorButton(image: 'assets/divide.png'),
                              ],
                            ),
                          ),

                          // -------- ROW 2 --------
                          SizedBox(
                            height: 63,

                            child: Row(
                              children: [
                                const SizedBox(width: 10),

                                CalculatorButton(
                                  text: '7',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('7');
                                    });
                                  },
                                ),

                                const SizedBox(width: 34),

                                CalculatorButton(
                                  text: '8',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('8');
                                    });
                                  },
                                ),

                                const SizedBox(width: 34),

                                CalculatorButton(
                                  text: '9',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('9');
                                    });
                                  },
                                ),

                                const SizedBox(width: 34),

                                CalculatorButton(image: 'assets/multiply.png'),
                              ],
                            ),
                          ),

                          // -------- ROW 3 --------
                          SizedBox(
                            height: 63,

                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                CalculatorButton(
                                  text: '4',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('4');
                                    });
                                  },
                                ),
                                const SizedBox(width: 34),
                                CalculatorButton(
                                  text: '5',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('5');
                                    });
                                  },
                                ),
                                const SizedBox(width: 34),
                                CalculatorButton(
                                  text: '6',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('6');
                                    });
                                  },
                                ),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/minus.png'),
                              ],
                            ),
                          ),

                          // -------- ROW 4 --------
                          SizedBox(
                            height: 63,

                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                CalculatorButton(
                                  text: '1',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('1');
                                    });
                                  },
                                ),
                                const SizedBox(width: 34),
                                CalculatorButton(
                                  text: '2',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('2');
                                    });
                                  },
                                ),
                                const SizedBox(width: 34),
                                CalculatorButton(
                                  text: '3',
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('3');
                                    });
                                  },
                                ),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/add.png'),
                              ],
                            ),
                          ),

                          // -------- ROW 5 --------
                          SizedBox(
                            height: 61,

                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                CalculatorButton(
                                  text: '0',
                                  width: 158,
                                  height: 44,
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputNumber('0');
                                    });
                                  },
                                ),
                                const SizedBox(width: 15),
                                CalculatorButton(
                                  image: 'assets/dot.png',
                                  width: 76,
                                  height: 44,
                                  onPressed: () {
                                    setState(() {
                                      calculator.inputDecimal();
                                    });
                                  },
                                ),
                                const SizedBox(width: 15),
                                CalculatorButton(
                                  image: 'assets/equal.png',
                                  width: 76,
                                  height: 44,

                                  backgroundColor: const Color(0xFF827F7F),
                                  hoverColor: const Color(0xFF6B6B6B),
                                  pressedColor: const Color(0xFF464646),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ---------------- HISTORY PANEL ----------------
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
