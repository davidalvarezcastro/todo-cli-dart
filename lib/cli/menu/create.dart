import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/state.dart';
import 'package:todo/todo/enums.dart';
import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/services/todo.dart';

const int maxRetries = 3;

class CreateMenu extends State {
  int _errorCount = 0;

  late String description;
  late Priority priority;
  late Type type;

  CreateMenu({required State previous, required InterfaceServiceTodo service}) {
    super.service = service;
    super.previous = previous;
    isReady = true;
  }

  @override
  void handler({required Cli context}) {
    description = _checkRetries(_askDescription(), _askDescription);

    if (description.isNotEmpty) {
      priority = Priority.values[_askPriority()];
      type = Type.values[_askType()];

      if (_askConfirmation()) {
        try {
          saveTodo();
          print("\n\t TODO saved!\n");
        } catch (e) {
          print("\n\t Failed to save TODO!\n");
        }
      }
    }

    context.state = previous!;
  }

  String _checkRetries(String result, Function cb) {
    if (result.isEmpty) {
      if (_errorCount < maxRetries) {
        _errorCount++;
        return _checkRetries(cb(), cb);
      }

      exit(-1);
    }

    return result;
  }

  String _askDescription() {
    print("Write info:");
    String? readDescription = stdin.readLineSync();

    if (readDescription == null || readDescription.isEmpty) {
      return "";
    }

    return readDescription;
  }

  int _askPriority() {
    print("Priority:");
    for (var p in Priority.values) {
      print("\t ${p.index}.- ${p.name}");
    }
    print(
        "Select a priority from the list (${Priority.values[0].name} by default)");
    String? readPriority = stdin.readLineSync();
    int priorityFormatted = 0;

    try {
      if (readPriority == null) {
        throw "priority null";
      }

      priorityFormatted = int.parse(readPriority);
      if (priorityFormatted < 0 &&
          priorityFormatted >= Priority.values.length) {
        throw "index error";
      }
    } catch (e) {
      // priority value by default in case of error
      priorityFormatted = 0;
    }

    return priorityFormatted;
  }

  int _askType() {
    print("Type:");
    for (var t in Type.values) {
      print("\t ${t.index}.- ${t.name}");
    }
    print("Select a type from the list (${Type.values[0].name} by default)");
    String? readType = stdin.readLineSync();
    int typeFormatted = 0;

    try {
      if (readType == null) {
        throw "priority null";
      }

      typeFormatted = int.parse(readType);
      if (typeFormatted < 0 && typeFormatted >= Type.values.length) {
        throw "index error";
      }
    } catch (e) {
      // type value by default in case of error
      typeFormatted = 0;
    }

    return typeFormatted;
  }

  bool _askConfirmation() {
    print("\nTODO info:");
    print("\tDescription: \n\t\t $description");
    print("\tType: \n\t\t ${type.name}");
    print("\tPriority: \n\t\t ${priority.name}");

    print("Save item? [Y/n]:");
    String? readConfirmation = stdin.readLineSync();

    return readConfirmation == null || readConfirmation != 'n';
  }

  void saveTodo() {
    Todo todo = Todo(description: description, priority: priority, type: type);
    service.create(todo: todo);
  }
}
