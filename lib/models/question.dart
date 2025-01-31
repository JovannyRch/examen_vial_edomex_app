import 'dart:math';

class Question {
  final int id; // Identificador único de la pregunta
  final String text; // Texto de la pregunta
  final List<String> options; // Lista de opciones de respuesta
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });

  String get formattedText => text.replaceAll('[br]', '\n');
  String get formattedAnswer =>
      options[correctAnswerIndex].replaceAll('[br]', '\n');
  String get correctAnswer =>
      options[correctAnswerIndex].replaceAll('[br]', '\n');

  List<String> get shuffledOptions {
    final random = Random();
    final shuffled = List<String>.from(options);
    shuffled.shuffle(random);
    return shuffled;
  }
}
