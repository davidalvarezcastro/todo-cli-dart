import 'package:todo/todo/models/todo.dart';

abstract class InterfaceDalTodo {
  /// Saves info from [todo]
  void create({required Todo todo});

  /// Remove [todo] info
  void delete({required Todo todo});

  /// Get info from todo with id [id]
  Todo? get({required int id});
}
