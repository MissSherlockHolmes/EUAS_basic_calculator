import 'package:math_expressions/math_expressions.dart';

class BasicFunctionality {
  String display = '';

  void input(String value) {
    display += value;
  }

  void clear() {
    display = '';
  }

  void calculate() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(display);
      double result = expression.evaluate(EvaluationType.REAL, ContextModel());
      display = result.toString();
    } catch (e) {
      display = 'Error';
    }
  }
}