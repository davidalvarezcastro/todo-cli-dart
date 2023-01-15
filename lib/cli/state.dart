import 'package:todo/cli/menu/cli.dart';
import 'package:todo/todo/services/todo.dart';

abstract class State {
  late State? previous;
  late InterfaceServiceTodo service;
  bool isReady = false;

  /// Executes state actions
  void handler({required Cli context});
}

abstract class Menu extends State {
  /// Checks if [option] is between [min] and [max], and return it as integer
  int checkOption({required String? option, int min = 0, required int max}) {
    if (option == null || option.isEmpty) return -1;

    try {
      int optionI = int.parse(option);

      if (optionI >= min && optionI <= max) {
        return optionI;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  /// Shows menu to user
  void showMenu();
}
