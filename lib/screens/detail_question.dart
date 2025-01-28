import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/data/questions.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/models/question.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/services/local_db.dart';

class QuestionDetailScreen extends StatefulWidget {
  final Question question;
  final int initialIndex;

  const QuestionDetailScreen({
    required this.question,
    required this.initialIndex,
  });

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    // Marcar la pregunta como vista al abrirla
    LocalDB().markQuestionAsViewed(widget.question.id);
  }

  void goToRandomQuestion() {
    final random = Random();
    setState(() {
      currentIndex = random.nextInt(questions.length);
    });
    // Actualizar la base de datos
    LocalDB().markQuestionAsViewed(questions[currentIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta ${currentIndex + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              question.formattedText,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question.formattedAnswer,
                  style: const TextStyle(fontSize: 18),
                  softWrap: true,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex > 0) {
                      setState(() => currentIndex--);
                      LocalDB()
                          .markQuestionAsViewed(questions[currentIndex].id);
                    }
                  },
                  child: const Text('Anterior'),
                ),
                //Rounded icon button
                ElevatedButton(
                  onPressed: goToRandomQuestion,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.shuffle),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex < questions.length - 1) {
                      setState(() => currentIndex++);
                      LocalDB()
                          .markQuestionAsViewed(questions[currentIndex].id);
                    }
                  },
                  child: const Text('Siguiente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
