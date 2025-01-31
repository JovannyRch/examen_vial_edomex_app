import 'package:flutter/material.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/const/colors.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/data/questions.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/models/question.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/widgets/question_widget.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/widgets/timer_widget.dart';

//create status for the test
// 1 Introduction
// 2 Test
// 3 Results

enum TestStatus {
  introduction,
  test,
  results,
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentQuestionIndex = 0;
  List<Question> _questions = [];

  @override
  void initState() {
    _randomizeQuestions(20);
    super.initState();
  }

  void _randomizeQuestions(int totalQuestions) {
    final randomizedQuestions = questions.toList()..shuffle();
    setState(() {
      _questions = randomizedQuestions.take(totalQuestions).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen de Prueba'),
      ),
      body: _questionCard(),
      backgroundColor: kMainColor.withOpacity(0.75),
    );
  }

  Widget _questionCard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex) / _questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color?>(kSecondaryColor),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            'Pregunta ${currentQuestionIndex + 1}/${_questions.length}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Center(
                            child: CustomTimer(
                              initialTimeInSeconds: 1200, // 20 minutos
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: kMainColor,
                              ),
                              onTimeUp: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('¡Tiempo agotado!')),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: kMainColor,
                    ),
                    const SizedBox(height: 12),
                    QuestionWidget(
                      question: _questions[currentQuestionIndex],
                      onAnswerSelected: () => {},
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (currentQuestionIndex < _questions.length - 1) {
                          setState(() {
                            currentQuestionIndex++;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('¡Examen finalizado!'),
                            ),
                          );
                        }
                      },
                      child: const Text('Siguiente'),
                    ),
                  ],
                ),
              ),
            ),
            //Next button
          ],
        ),
      ),
    );
  }
}
