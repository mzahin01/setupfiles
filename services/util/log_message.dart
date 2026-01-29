import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Logs a message with an optional title for debugging purposes.
/// Only logs in debug mode.
void logMessage({String? title, dynamic message}) {
  if (kDebugMode) {
    final String logTitle = title ?? 'Log';
    final String logMessage = message?.toString() ?? 'null';
    developer.log('[$logTitle]: $logMessage');
  }
}
