import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int defaultMilliseconds;
  Timer? _timer;

  Debouncer({required this.defaultMilliseconds});

  void run(VoidCallback action, {int? milliseconds, VoidCallback? onCancel}) {
    if (_timer?.isActive ?? false) {
      onCancel?.call();
    }

    _timer?.cancel(); // Cancel any existing timer
    final duration = Duration(milliseconds: milliseconds ?? defaultMilliseconds);
    _timer = Timer(duration, action); // Start a new timer with the specified duration
  }

  void dispose() {
    _timer?.cancel();
  }
}
