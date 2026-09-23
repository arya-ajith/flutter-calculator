import 'package:flutter/material.dart';

import 'calculator_button.dart';

class HistoryEntry extends StatelessWidget {
  final String expression;
  final String result;

  const HistoryEntry({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(expression, style: const TextStyle(fontSize: 14)),
        Text(
          result,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class HistoryMenu extends StatelessWidget {
  const HistoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      color: const Color(0xFFF0F0F0),

      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 53,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                HistoryEntry(expression: '12 x 12', result: '144'),
              ],
            ),
          ),

          // Clear button
          Positioned(
            left: 61,
            bottom: 10,
            child: CalculatorButton(text: 'Clear', width: 140, height: 44),
          ),
        ],
      ),
    );
  }
}
