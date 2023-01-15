import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/menu/init.dart';
import 'package:todo/todo/repository/dal/todo.dart';
import 'package:todo/todo/repository/dal/todo_sqlite.dart';
import 'package:todo/todo/repository/database.dart';
import 'package:todo/todo/services/todo.dart';

void main(List<String> arguments) {
  ClientSQLite db = ClientSQLite(null);
  db.init();

  InterfaceDalTodo dal = DalTodoDatabase(client: db);
  InterfaceServiceTodo service = ServiceTodoPersistent(dal: dal);

  Cli(state: InitMenu(service: service));
}
