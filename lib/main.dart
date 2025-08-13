
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/router/routes.dart';
import 'app/theme/theme_builder.dart';
import 'data/models.dart';
import 'data/repos.dart';
import 'data/sticky_vision.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(MoodLogAdapter());
  Hive.registerAdapter(EnergyLogAdapter());
  Hive.registerAdapter(StickyNoteAdapter());
  Hive.registerAdapter(VisionImageAdapter());

  final tasks = await Hive.openBox<Task>('tasks');
  final journal = await Hive.openBox<JournalEntry>('journal');
  final moods = await Hive.openBox<MoodLog>('moods');
  final energy = await Hive.openBox<EnergyLog>('energy');
  final stickies = await Hive.openBox<StickyNote>('stickies');
  final vision = await Hive.openBox<VisionImage>('vision');
  await Hive.openBox('settings');

  final themes = await AppThemes.build();

  runApp(ProviderScope(
    overrides: [
      taskBoxProvider.overrideWithValue(tasks),
      journalBoxProvider.overrideWithValue(journal),
      moodBoxProvider.overrideWithValue(moods),
      energyBoxProvider.overrideWithValue(energy),
      stickyBoxProvider.overrideWithValue(stickies),
      visionBoxProvider.overrideWithValue(vision),
    ],
    child: SeizeTheDayApp(themes: themes),
  ));
}

class SeizeTheDayApp extends StatelessWidget {
  final AppThemes themes;
  const SeizeTheDayApp({super.key, required this.themes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seize the Day',
      theme: themes.light,
      darkTheme: themes.dark,
      themeMode: ThemeMode.system,
      home: const RootShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}
