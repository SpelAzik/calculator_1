import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";
  bool _newCalculation = false;

  String _calculateOutput() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString().replaceAll(RegExp(r'\.0$'), ''); // Butun sonlarni yaxlitlash
    } catch (e) {
      return "Error";
    }
  }

  Widget _buildButton(String label, {Color? backgroundColor, Color? textColor}) {
    return ElevatedButton(
      onPressed: () => (label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(0xFFE0E0E0), // Tugmalar uchun kulrang fon
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16), // Tugma ichidagi matnni kattalashtirish
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.08, // Ekran kengligining 8% ini o'zgaruvchi font o'lchami sifatida ishlatish
            color: textColor ?? const Color(0xFF424250),  // To'q kulrang matn
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FC),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Kiritish oynasi (output)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30), // To‘liq dumaloq
              ),
              height: 100, // Satrni kengaytirish
              width: MediaQuery.of(context).size.width * 0.9, // Satrni kengroq qilish
              margin: const EdgeInsets.only(top: 20), // Yuqoridan bo'shliq qoldirish
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  _output,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.12, // Ekran o'lchamiga moslashtirilgan matn o'lchami
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tugmalar
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 5 : 4,
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      _buildButton("%", backgroundColor: const Color(0xFFF6F6FA), textColor: const Color(0xFF424242)),
                      _buildButton("√", backgroundColor: const Color(0xFFF6F6FA), textColor: const Color(0xFF424242)),
                      _buildButton("CE", backgroundColor: const Color(0xFFF6F6FA), textColor: const Color(0xFF424242)),
                      _buildButton("C", backgroundColor: const Color(0xFF1E2C51), textColor: Colors.white),
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("-", backgroundColor: Colors.red, textColor: Colors.white),
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("÷", backgroundColor: Colors.blue, textColor: Colors.white),
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("×", backgroundColor: Colors.orange, textColor: Colors.white),
                      _buildButton("."),
                      _buildButton("0"),
                      _buildButton("=", backgroundColor: const Color(0xFFF1F1F5), textColor: const Color(0xFF424242)),
                      _buildButton("+", backgroundColor: Colors.green, textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
