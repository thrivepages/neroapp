
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'models.dart';

const _uuid = Uuid();

final taskBoxProvider = Provider<Box<Task>>((ref) => throw UnimplementedError());
final journalBoxProvider = Provider<Box<JournalEntry>>((ref) => throw UnimplementedError());
final moodBoxProvider = Provider<Box<MoodLog>>((ref) => throw UnimplementedError());
final energyBoxProvider = Provider<Box<EnergyLog>>((ref) => throw UnimplementedError());

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final box = ref.watch(taskBoxProvider);
  return TasksNotifier(box);
});
class TasksNotifier extends StateNotifier<List<Task>> {
  final Box<Task> box;
  TasksNotifier(this.box): super(box.values.toList());
  Future<void> add(String title, {String? notes}) async {
    final t = Task(id: _uuid.v4(), title: title, notes: notes);
    await box.put(t.id, t);
    state = box.values.toList();
  }
  Future<void> toggle(String id) async { final t = box.get(id); if (t!=null) { t.done=!t.done; await t.save(); state = box.values.toList(); } }
  Future<void> remove(String id) async { await box.delete(id); state = box.values.toList(); }
}

final journalProvider = StateNotifierProvider<JournalNotifier, List<JournalEntry>>((ref) {
  final box = ref.watch(journalBoxProvider);
  return JournalNotifier(box);
});
class JournalNotifier extends StateNotifier<List<JournalEntry>> {
  final Box<JournalEntry> box;
  JournalNotifier(this.box): super(box.values.toList());
  Future<void> add(String text) async {
    final j = JournalEntry(id: _uuid.v4(), createdAt: DateTime.now(), text: text, tags: []);
    await box.put(j.id, j); state = box.values.toList();
  }
  Future<void> remove(String id) async { await box.delete(id); state = box.values.toList(); }
}

final moodProvider = StateNotifierProvider<MoodNotifier, List<MoodLog>>((ref) {
  final box = ref.watch(moodBoxProvider);
  return MoodNotifier(box);
});
class MoodNotifier extends StateNotifier<List<MoodLog>> {
  final Box<MoodLog> box;
  MoodNotifier(this.box): super(box.values.toList());
  Future<void> add(String mood) async {
    final m = MoodLog(id: _uuid.v4(), at: DateTime.now(), mood: mood);
    await box.put(m.id, m); state = box.values.toList();
  }
}

final energyProvider = StateNotifierProvider<EnergyNotifier, List<EnergyLog>>((ref) {
  final box = ref.watch(energyBoxProvider);
  return EnergyNotifier(box);
});
class EnergyNotifier extends StateNotifier<List<EnergyLog>> {
  final Box<EnergyLog> box;
  EnergyNotifier(this.box): super(box.values.toList());
  Future<void> add(int spoons) async {
    final e = EnergyLog(id: _uuid.v4(), at: DateTime.now(), spoons: spoons);
    await box.put(e.id, e); state = box.values.toList();
  }
}
