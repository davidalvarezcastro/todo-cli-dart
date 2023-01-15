import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/state.dart';

class ReadMenu extends State {
  late int id;

  ReadMenu({required State previous}) {
    super.previous = previous;
    isReady = true;
  }

  @override
  void handler({required Cli context}) {
    id = _askID();

    print(id);

    if (previous != null) {
      context.state = previous!;
    }

    // find tod
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
