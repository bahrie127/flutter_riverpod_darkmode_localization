import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Clock extends StateNotifier<DateTime> {
  Clock() : super(DateTime.now()) {
    Timer.periodic(const Duration(seconds: 1), (_) {
      state = DateTime.now();
    });
  }
}

final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});