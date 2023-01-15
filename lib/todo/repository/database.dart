import 'package:sqlite3/sqlite3.dart';

class ClientSQLite {
  late Database db;
  late String file;
  static final _cache = <String, ClientSQLite>{};

  ClientSQLite._create({String? file}) {
    db = sqlite3.open(file ?? "todo.db");
  }

  factory ClientSQLite(String? file) => _cache.putIfAbsent(
      file.toString(), () => ClientSQLite._create(file: file));

  void init() {
    // Create a table and insert some data
    db.execute('''
      CREATE TABLE IF NOT EXISTS todo (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        priority INTEGER NOT NULL,
        type INTEGER NOT NULL
      );
    ''');
  }
}
