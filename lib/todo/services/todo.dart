import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/repository/dal/todo.dart';

abstract class InterfaceServiceTodo {
  /// Saves info from [todo] in a persistent store
  void create({required Todo todo});

  /// Remove [todo] info from persistent store
  void delete({required Todo todo});

  /// Get info from todo with id [id]
  Todo? get({required int id});
}

class ServiceTodoPersistent implements InterfaceServiceTodo {
  InterfaceDalTodo dal;

  ServiceTodoPersistent({required this.dal});

  @override
  void create({required Todo todo}) {
    dal.create(todo: todo);
  }

  @override
  void delete({required Todo todo}) {
    dal.delete(todo: todo);
  }

  @override
  Todo? get({required int id}) {
    return dal.get(id: id);
  }
}
