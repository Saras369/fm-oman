part of 'helper.dart';

class KDebounce {
  Duration delay;
  Timer? _timer;

  KDebounce(this.delay);

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class KExponentialDebounce {
  Duration delay;
  Duration maxDelay;
  int count = 0;
  Timer? _timer;

  KExponentialDebounce(
    this.delay, {
    this.maxDelay = const Duration(milliseconds: 1500),
  });

  void call(void Function() callback) {
    _timer?.cancel();
    count++;

    var newDelay = delay + Duration(milliseconds: 4 * (count - 1) * 100);

    if (newDelay >= maxDelay) {
      newDelay = maxDelay;
    }

    _timer = Timer(delay, () {
      callback();
      count = 0;
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
