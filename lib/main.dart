import 'package:flutter/material.dart';

void main() => runApp(SimpleCalculator());

class SimpleCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Container()), // This pushes the keypad to the bottom
            CalculatorButtons(),
          ],
        ),
      ),
    );
  }
}

class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color; // Dynamic color for button text/icon
  final bool isZero; // Special flag for the '0' button to adjust its width

  NeonButton({
    required this.label,
    required this.onPressed,
    this.color = Colors.lightGreen, // Default color for text/icons
    this.isZero = false, // Default flag is false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isZero ? (MediaQuery.of(context).size.width - (16 * 5)) / 4 * 2 + 8 : null,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 15,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 6),
          borderRadius: BorderRadius.zero,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: EdgeInsets.zero,
            side: BorderSide(color: Colors.transparent, width: 10),
          ),
          child: Text(label, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class CalculatorButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {'label': 'C', 'color': Colors.orangeAccent},
      {'label': '+/-', 'color': Colors.orange},
      {'label': '%', 'color': Colors.orangeAccent},
      {'label': '/', 'color': Colors.orange},
      {'label': '7'},
      {'label': '8'},
      {'label': '9'},
      {'label': 'x', 'color': Colors.orangeAccent},
      {'label': '4'},
      {'label': '5'},
      {'label': '6'},
      {'label': '-', 'color': Colors.orangeAccent},
      {'label': '1'},
      {'label': '2'},
      {'label': '3'},
      {'label': '+', 'color': Colors.orangeAccent},
      {'label': '0', 'isZero': true},
      {'label': '.'},
      {'label': '=', 'color': Colors.blue},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: buttons.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> button = buttons[index];
          return NeonButton(
            label: button['label'],
            onPressed: () => print('Pressed ${button['label']}'),
            color: button['color'] ?? Colors.lightGreen.shade400

            ,
            isZero: button.containsKey('isZero') && button['isZero'],
          );
        },
      ),
    );
  }
}
