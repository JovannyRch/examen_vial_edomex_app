class UserStats {
  final Map<String, bool> answeredQuestions; // Respuestas correctas/incorrectas
  final Map<String, int> viewedQuestions; // Preguntas vistas (id: veces vista)
  final int totalCorrect;
  final int totalIncorrect;

  UserStats({
    required this.answeredQuestions,
    required this.viewedQuestions,
    required this.totalCorrect,
    required this.totalIncorrect,
  });

  // Método para marcar una pregunta como vista
  UserStats markQuestionAsViewed(int questionId) {
    viewedQuestions[questionId.toString()] =
        (viewedQuestions[questionId] ?? 0) + 1;
    return UserStats(
      answeredQuestions: answeredQuestions,
      viewedQuestions: viewedQuestions,
      totalCorrect: totalCorrect,
      totalIncorrect: totalIncorrect,
    );
  }
}
