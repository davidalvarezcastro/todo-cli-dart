import 'package:todo/cli/state.dart';

class Cli {
  State state;
  static final _cache = <String, Cli>{};

  Cli._create({required this.state}) {
    _next();
  }

  factory Cli({required State state}) =>
      _cache.putIfAbsent(state.toString(), () => Cli._create(state: state));

  void _next() {
    state.handler(context: this);
    if (state.isReady) _next();
  }
}
