import 'package:euas/button_values.dart';
import 'package:flutter/material.dart';

import 'kilometer_to_mile_converter.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // . 0-9
  String operand = ""; // + - * /
  String number2 = ""; // . 0-9

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$number1$operand$number2".isEmpty
                        ? "0"
                        : "$number1$operand$number2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => NeonButton(
                  label: value,
                  onPressed: () => onBtnTap(value),
                  isZero: value == Btn.n0,
                ),
              )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  // ########
  void onBtnTap(String value) {

    if (value == Btn.kmToMile) {
      // Navigate to the Km/Mile conversion screen
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => KilometerToMileConverter(),
      ));
      return;
    }

    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  // ##############
  // calculates the result
  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }

    setState(() {
      number1 = result.toStringAsPrecision(3);

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }

      operand = "";
      number2 = "";
    });
  }

  // ##############
  // converts output to %
  void convertToPercentage() {
    // ex: 434+324
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // calculate before conversion
      calculate();
    }

    if (operand.isNotEmpty) {
      // cannot be converted
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  // ##############
  // clears all output
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  // ##############
  // delete one from the end
  void delete() {
    if (number2.isNotEmpty) {
      // 12323 => 1232
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  // #############
  // appends value to the end
  void appendValue(String value) {
    // number1 operand number2
    // 234       +      5343

    // Check if the input value is an operation and not a dot
    if (value != Btn.dot && int.tryParse(value) == null) {
      // If an operand is already set and there is a second number, calculate the current operation
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // Complete the current operation before moving on to the new one
        calculate(); // This ensures continuity in operations
      }
      // Set the new operand to the current input value
      operand = value;
    }

    // assign value to number1 variable
    else if (number1.isEmpty || operand.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        // ex: number1 = "" | "0"
        value = "0.";
      }
      number1 += value;
    }
    // assign value to number2 variable
    else if (number2.isEmpty || operand.isNotEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        // number1 = "" | "0"
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }
}

class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final bool isZero; // This can now be removed if you decide not to use it elsewhere

  const NeonButton({super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.lightGreen,
    this.isZero = false,
  });

  @override
  Widget build(BuildContext context) {
    // The width is uniform for all buttons, including '0'
    double buttonWidth = MediaQuery.of(context).size.width / 4 - 12;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: buttonWidth,
        height: MediaQuery.of(context).size.width / 4 - 12,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 15,
            ),
          ],
          border: Border.all(color: Colors.green, width: 6),
          borderRadius: BorderRadius.zero,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: color,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: EdgeInsets.zero,
            side: const BorderSide(color: Colors.transparent, width: 10),
          ),
          child: Text(label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
