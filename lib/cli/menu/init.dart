import 'dart:io';

import 'package:todo/cli/menu/cli.dart';
import 'package:todo/cli/menu/create.dart';
import 'package:todo/cli/menu/options.dart';
import 'package:todo/cli/state.dart';
import 'package:todo/todo/services/todo.dart';

const int maxRetries = 3;

enum Option { undefined, create, read, delete, load, exit }

class InitMenu extends Menu {
  Option option = Option.undefined;

  int _errorCount = 0;

  final List<OptionsMenu> options = [
    OptionsMenu<Option>(option: Option.create, text: "Add a TODO to app."),
    OptionsMenu<Option>(
        option: Option.read, text: "Get information from a TODO."),
    OptionsMenu<Option>(option: Option.delete, text: "Delete a TODO."),
    OptionsMenu<Option>(
        option: Option.load, text: "Load data from JSON (beta)"),
    OptionsMenu<Option>(option: Option.exit, text: "Exit."),
  ];

  InitMenu({required InterfaceServiceTodo service}) {
    super.service = service;
    isReady = true;
  }

  @override
  void handler({required Cli context}) {
    showMenu();

    if (!_handleOption() || option == Option.exit) {
      exit(-1);
    } else {
      switch (option) {
        case Option.create:
          context.state = CreateMenu(previous: this, service: service);
          break;
        // case Option.delete:
        //   context.state = DeleteMenu(previous: this);
        //   break;
        // case Option.read:
        //   context.state = ReadMenu(previous: this);
        //   break;
        // TODO: load from JSON file
        // case Option.load:
        // context.state = ;
        // break;
        default:
          context.state = this;
          break;
      }
    }
  }

  @override
  void showMenu() {
    print("TODO App");
    for (var entry in options) {
      print("\t${entry.option.index}. ${entry.text}");
    }
  }

  // Gets [option] as Option type
  Option _getCastOption(int option) {
    try {
      return Option.values[option];
    } catch (err) {
      return Option.undefined;
    }
  }

  /// Returns true if the user selected a correct answer and handles wrong options
  bool _handleOption() {
    print("Select an option:");
    option = _getCastOption(checkOption(
        option: stdin.readLineSync(),
        min: Option.create.index,
        max: Option.exit.index));

    if (option == Option.undefined && _errorCount < maxRetries) {
      _errorCount++;
      print("Please select a correct number from the list of options!");
      return _handleOption();
    }

    return true;
  }
}
