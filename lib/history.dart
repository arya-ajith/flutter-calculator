import 'package:flutter/material.dart';

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
            bottom: 53,
            child: ListView(
              shrinkWrap: true,
              children: const [
                HistoryEntry(expression: '12 x 12', result: '144'),
              ],
            ),
          ),

          // Clear button
          Positioned(
            bottom: 10,
            child: Container(
              width: 140,
              height: 44,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Center(child: Text('Clear')),
            ),
          ),
        ],
      ),
    );
  }
}
