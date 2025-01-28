import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  static final LocalDB _instance = LocalDB._internal();
  factory LocalDB() => _instance;
  static Database? _database;

  LocalDB._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'examen_vial_edomex.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_stats(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id TEXT,
        is_correct INTEGER,
        view_count INTEGER DEFAULT 0
      )
    ''');
  }

  // Guardar una respuesta del usuario
  Future<void> saveAnswer(String questionId, bool isCorrect) async {
    final db = await database;
    await db.insert(
      'user_stats',
      {
        'question_id': questionId,
        'is_correct': isCorrect ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtener todas las respuestas del usuario
  Future<Map<String, bool>> getAnswers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user_stats');

    final Map<String, bool> answers = {};
    for (var map in maps) {
      answers[map['question_id']] = map['is_correct'] == 1;
    }
    return answers;
  }

  //Get viewed questions
  Future<List<String>> getViewedQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user_stats');

    final List<String> viewedQuestions = [];
    for (var map in maps) {
      viewedQuestions.add(map['question_id']);
    }
    return viewedQuestions;
  }

  // Marcar una pregunta como vista
  Future<void> markQuestionAsViewed(int questionId) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE user_stats
      SET view_count = view_count + 1
      WHERE question_id = ?
    ''', [questionId]);
  }
}
