import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/repository/dal/todo.dart';
import 'package:todo/todo/repository/database.dart';

class DalTodoDatabase implements InterfaceDalTodo {
  ClientSQLite client;

  DalTodoDatabase({required this.client});

  @override
  void create({required Todo todo}) {
    var db = client.db;

    final stmt = db.prepare(
        'INSERT INTO todo (description, priority, type) VALUES (?, ?, ?)');
    stmt.execute([todo.description, todo.priority.index, todo.type.index]);
    stmt.dispose();
  }

  @override
  void delete({required Todo todo}) {}

  @override
  Todo get({required int id}) {
    return Todo.simple(description: "");
  }
}
