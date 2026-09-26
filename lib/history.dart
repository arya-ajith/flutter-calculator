import 'package:flutter/material.dart';

import 'calculator_button.dart';

class HistoryItem {
  final String expression;
  final String result;

  HistoryItem({required this.expression, required this.result});
}

class HistoryManager extends ChangeNotifier {
  final List<HistoryItem> items = [];

  void add(String expression, String result) {
    items.add(HistoryItem(expression: expression, result: result));

    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }

  HistoryItem? get(int index) {
    if (index < 0 || index >= items.length) {
      return null;
    }

    return items[index];
  }
}

class HistoryEntry extends StatelessWidget {
  final String expression;
  final String result;
  final VoidCallback onTap;

  const HistoryEntry({
    super.key,
    required this.expression,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              expression,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              result,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryMenu extends StatelessWidget {
  final HistoryManager history;
  final Function(HistoryItem) onHistorySelected;

  const HistoryMenu({
    super.key,
    required this.history,
    required this.onHistorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      color: const Color(0xFFF0F0F0),
      child: AnimatedBuilder(
        animation: history,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 53,
                child: SingleChildScrollView(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (int i = 0; i < history.items.length; i++)
                        HistoryEntry(
                          expression: history.items[i].expression,
                          result: history.items[i].result,
                          onTap: () {
                            onHistorySelected(history.items[i]);
                          },
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 61,
                bottom: 10,
                child: CalculatorButton(
                  text: 'Clear',
                  width: 140,
                  height: 44,
                  onPressed: history.clear,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
