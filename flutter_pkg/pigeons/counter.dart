import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class Counter {
  void onTimerStartOrChange(String state, int duration);
}

@FlutterApi()
abstract class CounterInteractor {
  void onTimerStartOrChange();
}