class Question {
  final int id; // Identificador único de la pregunta
  final String text; // Texto de la pregunta
  final List<String> options; // Lista de opciones de respuesta
  final int correctAnswerIndex; // Respuesta correcta

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });

  String get formattedText => text.replaceAll('[br]', '\n');
  String get formattedAnswer =>
      options[correctAnswerIndex].replaceAll('[br]', '\n');
}
