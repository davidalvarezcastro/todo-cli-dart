import 'package:sqlite3/sqlite3.dart';
import 'package:todo/todo/enums.dart';
import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/repository/dal/todo.dart';
import 'package:todo/todo/repository/database.dart';

const sqlQueryCreate =
    'INSERT INTO todo (description, priority, type) VALUES (?, ?, ?)';
const sqlQueryGet =
    'SELECT id, description, priority, type FROM todo WHERE id = ? LIMIT 1';
const sqlQueryDelete = 'DELETE FROM todo WHERE id = ?';

class DalTodoDatabase implements InterfaceDalTodo {
  ClientSQLite client;
  late Database _db;

  DalTodoDatabase({required this.client}) {
    _db = client.db;
  }

  @override
  void create({required Todo todo}) {
    final stmt = _db.prepare(sqlQueryCreate);
    stmt.execute([todo.description, todo.priority.index, todo.type.index]);
    stmt.dispose();
  }

  @override
  void delete({required Todo todo}) {
    _db.select(sqlQueryDelete, [todo.id]);
  }

  @override
  Todo? get({required int id}) {
    final ResultSet resultSet = _db.select(sqlQueryGet, [id]);

    try {
      var aux = resultSet.rows[0];
      return Todo.full(
          id: aux[0] as int,
          description: aux[1] as String,
          priority: Priority.values[aux[2] as int],
          type: Type.values[aux[3] as int]);
    } catch (e) {
      return null;
    }
  }
}
