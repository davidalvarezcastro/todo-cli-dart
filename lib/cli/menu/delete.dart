import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/state.dart';

class DeleteMenu extends State {
  late int id;

  DeleteMenu({required State previous}) {
    super.previous = previous;
    isReady = true;
  }

  @override
  void handler({required Cli context}) {
    id = _askID();

    // find todo
    // remove todo

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
