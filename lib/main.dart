import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
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

class CalculatorButton extends StatelessWidget {
  final String? text;
  final String? image;

  const CalculatorButton({super.key, this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 57,
      height: 57,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: image != null
            ? Image.asset(image!)
            : Text(text!, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool historyOpen = false;

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

            Container(
              height: 145,
              color: const Color(0xFFFFFFFF),
              child: Stack(
                children: [
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

                  Positioned(
                    right: 6,
                    top: 36,
                    child: Text(
                      '12 x 12',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),

                  Positioned(
                    right: 6,
                    top: 87,
                    child: Text(
                      '144',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF858585),
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
                                CalculatorButton(text: 'C'),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/delete.png'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '%'),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/divide.png'),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 63,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                CalculatorButton(text: '7'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '8'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '9'),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/multiply.png'),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 63,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                CalculatorButton(text: '4'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '5'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '6'),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/minus.png'),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 63,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                CalculatorButton(text: '1'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '2'),
                                const SizedBox(width: 34),
                                CalculatorButton(text: '3'),
                                const SizedBox(width: 34),
                                CalculatorButton(image: 'assets/add.png'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 61,
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Container(
                                  width: 158,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.25,
                                        ),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  width: 76,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.25,
                                        ),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/dot.png',
                                      width: 4,
                                      height: 4,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  width: 76,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF827F7F),
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.25,
                                        ),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/equal.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
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
