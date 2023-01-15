import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/state.dart';
import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/services/todo.dart';

class ReadMenu extends State {
  late int id;

  ReadMenu({required State previous, required InterfaceServiceTodo service}) {
    super.previous = previous;
    super.service = service;
    isReady = true;
  }

  @override
  void handler({required Cli context}) {
    id = _askID();

    Todo? todo = service.get(id: id);

    if (todo != null) {
      print("\n\t ${todo.toString()} \n");
    } else {
      print("\n\t TODO $id not found!\n");
    }

    if (previous != null) {
      context.state = previous!;
    }
  }

  int _askID() {
    print("Write TODO id:");
    String? readID = stdin.readLineSync();

    try {
      if (readID == null || readID.isEmpty) {
        throw "Number expected!";
      }

      return int.parse(readID);
    } catch (e) {
      return -1;
    }
  }
}
