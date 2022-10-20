import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_intro/dark_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_intro/multi_lang.dart';
import 'clock.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final language = ref.watch(languageProvider);
    return MaterialApp(
      title: 'FLutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
          ),
        ),
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: language,
      supportedLocales: const [
        Locale('en', ''),
        Locale('id', ''),
      ],
      home: const MyHome(),
    );
  }
}

class MyHome extends ConsumerWidget {
  const MyHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(clockProvider);

    final timeFormatted = DateFormat.Hms().format(currentTime);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).header),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              timeFormatted,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(darkModeProvider.notifier).on();
                    },
                    child: Text(AppLocalizations.of(context).dark)),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      ref.read(darkModeProvider.notifier).off();
                    },
                    child: Text(AppLocalizations.of(context).light)),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(AppLocalizations.of(context).lang),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(languageProvider.notifier).en();
                  },
                  child: const Text('EN'),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(languageProvider.notifier).id();
                  },
                  child: const Text('ID'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
  void decrement() => state--;
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});
