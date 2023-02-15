import 'dart:async';
import '../actions/app_actions.dart';
import '../models/counter.dart';

enum CounterStatus { notStarted, running, pause, completed }

class CounterController {
  final counter = Counter();

  late Timer? timer;
  int second = 60;
  CounterStatus _counterStatus = CounterStatus.notStarted;
  CounterController() {
    counter.onTimerStartOrChange(_counterStatus.name, second);
  }

  onTimerStartClick(AppActions action) {
    onPauseOrStart();
  }

  onTimerValueChange() {
    second -= 1;
    if (second == 0) {
      timer?.cancel();
      _counterStatus = CounterStatus.completed;
    }
    passDataToNative();
  }

  passDataToNative() {
    counter.onTimerStartOrChange(_counterStatus.name, second);    
  }

  onPauseOrStart() {
    if (_counterStatus == CounterStatus.running) {
      timer?.cancel();
      _counterStatus = CounterStatus.pause;
    } else {
      if (_counterStatus == CounterStatus.running) {
        second = 60;
      }
      _counterStatus = CounterStatus.running;
      timer = Timer.periodic(
          const Duration(seconds: 1), (Timer t) => onTimerValueChange());
    }
    passDataToNative();
  }
}
