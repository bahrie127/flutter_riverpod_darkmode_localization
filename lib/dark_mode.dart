import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkMode extends StateNotifier<bool> {
  DarkMode() : super(false);
  void on() => state = true;
  void off() => state = false;
}

final darkModeProvider = StateNotifierProvider<DarkMode, bool>((ref) {
  return DarkMode();
});


class DarkModeController extends StateNotifier<bool> {
  DarkModeController(super.state);

}