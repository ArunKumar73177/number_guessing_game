import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(NumberGuessApp());
}

class NumberGuessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NumberGuessPage(),
    );
  }
}

class NumberGuessPage extends StatefulWidget {
  @override
  _NumberGuessPageState createState() => _NumberGuessPageState();
}

class _NumberGuessPageState extends State<NumberGuessPage> {
  final TextEditingController _controller = TextEditingController();
  late int _randomNumber;
  String _message = '';
  int _attempts = 0;

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  void _generateRandomNumber() {
    _randomNumber = Random().nextInt(100) + 1; // 1 to 100
  }

  void _checkGuess() {
    final guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _message = 'Please enter a valid number';
      });
      return;
    }

    _attempts++;

    if (guess < _randomNumber) {
      setState(() {
        _message = 'Too Low!';
      });
    } else if (guess > _randomNumber) {
      setState(() {
        _message = 'Too High!';
      });
    } else {
      setState(() {
        _message = 'Correct! You guessed it in $_attempts attempts.';
      });
    }

    _controller.clear();
  }

  void _resetGame() {
    setState(() {
      _attempts = 0;
      _message = '';
      _controller.clear();
      _generateRandomNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Guessing Game')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Guess the number between 1 and 100',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your guess'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkGuess,
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Reset'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
