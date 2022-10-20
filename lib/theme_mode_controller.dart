import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeController extends StateNotifier<String> {
  ThemeModeController() : super('dark');
  void dark() => state = 'dark';
  void light() => state = 'light';
}

final themeModeProvider = StateNotifierProvider<ThemeModeController, String>((ref) {
  return ThemeModeController();
});
