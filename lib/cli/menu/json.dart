import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/state.dart';
import 'package:todo/todo/enums.dart';
import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/services/todo.dart';

class JsonLoad extends State {
  late int id;

  JsonLoad({required State previous, required InterfaceServiceTodo service}) {
    super.previous = previous;
    super.service = service;
    isReady = true;
  }

  @override
  void handler({required Cli context}) async {
    try {
      String jsonPath = _askPath();
      List<dynamic> data = readJsonFile(path: jsonPath);
      for (var element in data) {
        saveJson(data: HashMap.from(element));
      }
      print("\n\tData stored!\n");
    } catch (e) {
      print("Could not save data!");
    }

    if (previous != null) {
      context.state = previous!;
    }
  }

  List<dynamic> readJsonFile({required String path}) {
    try {
      var path2 = "./data/template.json";
      var input = File(path2).readAsStringSync();
      return jsonDecode(input);
    } catch (e) {
      rethrow;
    }
  }

  String _askPath() {
    print("Write json path:");
    String? readPath = stdin.readLineSync();

    if (readPath == null || readPath.isEmpty) {
      throw "Path expected!";
    }

    return readPath;
  }

  void saveJson({required HashMap data}) {
    Todo todo = Todo(
        description: data['description'],
        priority: Priority.values[data['priority']],
        type: Type.values[data['type']]);
    service.create(todo: todo);
  }
}
