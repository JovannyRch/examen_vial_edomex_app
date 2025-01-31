import 'package:flutter/material.dart';
import '../models/question.dart'; // Importa el modelo de pregunta

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function() onAnswerSelected;

  const QuestionWidget({
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mostrar la pregunta
        Text(
          question.text,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Mostrar las opciones de respuesta
        ...question.shuffledOptions.map((option) {
          return GestureDetector(
            onTap: () {
              // Notificar la selección
            },
            child: Card(
              color: /* onAnswerSelected == option
                  ? (option == question.correctAnswer
                      ? Colors.green[100] // Respuesta correcta
                      : Colors.red[100]) // Respuesta incorrecta
                  : */
                  Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  option.replaceAll('[br]', '\n'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
