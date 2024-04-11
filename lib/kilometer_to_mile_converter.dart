import 'package:flutter/material.dart';

class KilometerToMileConverter extends StatefulWidget {
  @override
  _KilometerToMileConverterState createState() => _KilometerToMileConverterState();
}

class _KilometerToMileConverterState extends State<KilometerToMileConverter> {
  final _controller = TextEditingController();
  double _miles = 0;

  void _convert() {
    final double kilometers = double.tryParse(_controller.text) ?? 0;
    setState(() {
      _miles = kilometers * 0.621371;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Km to Miles Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter kilometers',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text('Miles: $_miles'),
          ],
        ),
      ),
    );
  }
}
