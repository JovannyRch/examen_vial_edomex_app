import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/models/question_stat.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/screens/detail_question.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/services/local_db.dart';
import '../models/question.dart'; // Importa el modelo de pregunta
import '../data/questions.dart'; // Importa la lista de preguntas

class StudyMode extends StatefulWidget {
  const StudyMode({super.key});

  @override
  _StudyModeState createState() => _StudyModeState();
}

class _StudyModeState extends State<StudyMode> {
  int currentQuestionIndex = 0; // Índice de la pregunta actual
  bool showFeedback = false; // Mostrar retroalimentación (correcta/incorrecta)
  List<QuestionStat> viewedQuestions = []; // Lista de preguntas vistas

  @override
  void initState() {
    super.initState();
    loadViewedQuestions();
  }

  void loadViewedQuestions() async {
    final viewedQuestions = await LocalDB().getViewedQuestions();

    setState(() {
      this.viewedQuestions = viewedQuestions;
    });
  }

  // Función para ir a una pregunta random
  void goToRandomQuestion() {
    final random = Random();
    final index = random.nextInt(questions.length);
    Question question = questions[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDetailScreen(
          question: question,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía de Estudio'), // Título de la pantalla
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: goToRandomQuestion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _questionsGrid(),
      ),
    );
  }

  Widget _questionsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columnas
        childAspectRatio: 1.5, // Relación de aspecto de cada tarjeta
      ),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final viewCount = viewedQuestions
            .firstWhere((element) => element.id == question.id, orElse: () {
          return QuestionStat(id: question.id, viewCount: 0);
        }).viewCount;

        return GestureDetector(
          onTap: () {
            // Navegar a la pantalla de detalle de la pregunta
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionDetailScreen(
                  question: question,
                  initialIndex: index,
                ),
              ),
            ).then((_) {
              loadViewedQuestions();
            });
          },
          child: Card(
            color: viewCount == 0
                ? Colors.grey[200]
                : viewCount == 1
                    ? Colors.yellow[100]
                    : Colors.green[100],
            child: Center(
              child: Text(
                'Pregunta ${index + 1}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
