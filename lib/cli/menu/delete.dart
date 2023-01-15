import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/state.dart';
import 'package:todo/todo/models/todo.dart';
import 'package:todo/todo/services/todo.dart';

class DeleteMenu extends State {
  late int id;

  DeleteMenu({required State previous, required InterfaceServiceTodo service}) {
    super.service = service;
    super.previous = previous;
    isReady = true;
  }

  @override
  void handler({required Cli context}) {
    id = _askID();

    Todo? todo = service.get(id: id);

    if (todo != null) {
      try {
        service.delete(todo: todo);
        print("\n\t TODO $id removed!\n");
      } catch (e) {
        print("\n\t Failed to remove TODO $id!\n");
      }
    }

    if (previous != null) {
      context.state = previous!;
    }
  }

  int _askID() {
    print("Write TODO id to be deleted:");
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
