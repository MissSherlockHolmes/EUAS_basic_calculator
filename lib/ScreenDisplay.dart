import 'package:flutter/material.dart';
import 'BasicFunctionality.dart';
import 'CalculatorButtons.dart';

class ScreenDisplay extends StatefulWidget {
  const ScreenDisplay({super.key});

  @override
  State<ScreenDisplay> createState() => _ScreenDisplayState();
}

class _ScreenDisplayState extends State<ScreenDisplay> {
  final BasicFunctionality calc = BasicFunctionality();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                calc.display,
                style: const TextStyle(color: Colors.white, fontSize: 36),
              ),
            ),
          ),
          CalculatorButtons(
            onPressed: (String value) {
              setState(() {
                if (value == 'C') {
                  calc.clear();
                } else if (value == '=') {
                  calc.calculate();
                } else {
                  calc.input(value);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}