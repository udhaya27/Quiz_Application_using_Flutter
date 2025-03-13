import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/main.dart';

class Simple_quiz extends StatefulWidget {
  final String username;
  const Simple_quiz({required this.username, Key? key}) : super(key: key);

  @override
  State<Simple_quiz> createState() => _Simple_quizState();
}

class _Simple_quizState extends State<Simple_quiz> {
  String? _selectedOption;
  List<Map<String, dynamic>> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(239, 239, 11, 80),
        title: Text(
          'Hello ${widget.username}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _selectedOption == null
          ? _buildSelectionScreen()
          : _buildQuizScreen(),
    );
  }

  Widget _buildSelectionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select Quiz Type',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedOption = 'Marvel';
              });
            },
            child: Text('Marvel Quiz'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedOption = 'DC';
              });
            },
            child: Text('DC Quiz'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizScreen() {
    // Based on the selected option, load questions
    List<Map<String, dynamic>> questions = [];
    if (_selectedOption == 'Marvel') {
      questions = _getMarvelQuestions();
    } else if (_selectedOption == 'DC') {
      questions = _getDCQuestions();
    }

    return questions.isNotEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  questions[0]['question'],
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ...(questions[0]['options'] as List<String>)
                    .map((option) => Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _checkAnswer(option);
                                },
                                child: Text(option)),
                            const SizedBox(height: 05),
                          ],
                        ))
                    .toList(),
              ],
            ),
          )
        : Center(
            child: Text(
              'No questions available for $_selectedOption',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
  }

  List<Map<String, dynamic>> _getMarvelQuestions() {
    return [
      {
        'question': '1. What is 2 + 2?',
        'options': ['3', '4', '5', '6'],
        'correctAnswer': '4',
      },
      {
        'question': '2.What is the capital of France?',
        'options': ['Paris', 'London', 'Berlin', 'Rome'],
        'correctAnswer': 'Paris',
      },
    ];

    // Return Marvel quiz questions
  }

  List<Map<String, dynamic>> _getDCQuestions() {
    // Return DC quiz questions
    return [
      {
        '_questions': '1. What is 2 + 2?',
        'options': ['3', '4', '5', '6'],
        'correctAnswer': '4',
      },
      {
        'question': '2.What is the capital of France?',
        'options': ['Paris', 'London', 'Berlin', 'Rome'],
        'correctAnswer': 'Paris',
      },
    ];
  }

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer = _questions[_currentQuestionIndex]['correctAnswer'];

    setState(() {
      if (selectedAnswer == correctAnswer) {
        _score++;
      }
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex == _questions.length) {
      _showResultDialog();
    }
  }

  Widget _buildQuizScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _questions[_currentQuestionIndex]['question'],
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ...(_questions[_currentQuestionIndex]['options'] as List<String>)
              .map((option) => Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _checkAnswer(option);
                          },
                          child: Text(option)),
                      const SizedBox(height: 05),
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }

  void _showResultDialog() {
    String msg;
    if (_score >= 5) {
      msg = 'congrats dude !! your score is $_score/${_questions.length}';
    } else {
      msg = 'Well tried !! Your score is $_score/${_questions.length}';
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You are Done'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Reset quiz state
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                  _selectedOption = null;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
