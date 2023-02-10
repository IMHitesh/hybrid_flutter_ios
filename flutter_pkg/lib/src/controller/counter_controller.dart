import 'dart:async';
import '../actions/app_actions.dart';
import 'app_controller.dart';

enum CounterStatus { notStarted, running, pause, completed }

class CounterController {
  late Timer? timer;
  int second = 60;
  CounterStatus _counterStatus = CounterStatus.notStarted;
  CounterController() {
    AppController.triggerNativeMethod(AppActions.countDownInit, {"seconds": second, "state": _counterStatus.name});
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
    AppController.triggerNativeMethod(AppActions.timerPauseOrChangeOrPause,
        {"seconds": second, "state": _counterStatus.name});
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
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => onTimerValueChange());
    }
    passDataToNative();
  }
}
