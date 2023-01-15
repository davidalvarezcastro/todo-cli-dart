import 'package:todo/todo/enums.dart';

class Todo {
  int id = -1;
  String? description;
  Priority priority = Priority.low;
  Type type = Type.home;

  Todo.simple({required this.description});
  Todo({required this.description, required this.priority, required this.type});
  Todo.full(
      {required this.description,
      required this.priority,
      required this.type,
      required this.id});
}
