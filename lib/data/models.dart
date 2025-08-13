
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String title;
  @HiveField(2) String? notes;
  @HiveField(3) DateTime? dueAt;
  @HiveField(4) bool done;
  Task({required this.id, required this.title, this.notes, this.dueAt, this.done=false});
}

class TaskAdapter extends TypeAdapter<Task> {
  @override final typeId = 1;
  @override Task read(BinaryReader r) {
    return Task(
      id: r.readString(),
      title: r.readString(),
      notes: r.readBool()? r.readString(): null,
      dueAt: r.readBool()? DateTime.fromMillisecondsSinceEpoch(r.readInt()): null,
      done: r.readBool(),
    );
  }
  @override void write(BinaryWriter w, Task o) {
    w.writeString(o.id);
    w.writeString(o.title);
    if (o.notes!=null) { w.writeBool(true); w.writeString(o.notes!); } else { w.writeBool(false); }
    if (o.dueAt!=null) { w.writeBool(true); w.writeInt(o.dueAt!.millisecondsSinceEpoch); } else { w.writeBool(false); }
    w.writeBool(o.done);
  }
}

@HiveType(typeId: 2)
class JournalEntry extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) DateTime createdAt;
  @HiveField(2) String text;
  @HiveField(3) List<String> tags;
  JournalEntry({required this.id, required this.createdAt, required this.text, this.tags=const []});
}

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override final typeId = 2;
  @override JournalEntry read(BinaryReader r) {
    return JournalEntry(
      id: r.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(r.readInt()),
      text: r.readString(),
      tags: (r.read() as List).cast<String>(),
    );
  }
  @override void write(BinaryWriter w, JournalEntry o) {
    w.writeString(o.id);
    w.writeInt(o.createdAt.millisecondsSinceEpoch);
    w.writeString(o.text);
    w.write(o.tags);
  }
}

@HiveType(typeId: 3)
class MoodLog extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) DateTime at;
  @HiveField(2) String mood;
  @HiveField(3) String? notes;
  MoodLog({required this.id, required this.at, required this.mood, this.notes});
}

class MoodLogAdapter extends TypeAdapter<MoodLog> {
  @override final typeId = 3;
  @override MoodLog read(BinaryReader r) {
    return MoodLog(
      id: r.readString(),
      at: DateTime.fromMillisecondsSinceEpoch(r.readInt()),
      mood: r.readString(),
      notes: r.readBool()? r.readString(): null,
    );
  }
  @override void write(BinaryWriter w, MoodLog o) {
    w.writeString(o.id);
    w.writeInt(o.at.millisecondsSinceEpoch);
    w.writeString(o.mood);
    if (o.notes!=null) { w.writeBool(true); w.writeString(o.notes!); } else { w.writeBool(false); }
  }
}

@HiveType(typeId: 4)
class EnergyLog extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) DateTime at;
  @HiveField(2) int spoons;
  EnergyLog({required this.id, required this.at, required this.spoons});
}

class EnergyLogAdapter extends TypeAdapter<EnergyLog> {
  @override final typeId = 4;
  @override EnergyLog read(BinaryReader r) {
    return EnergyLog(
      id: r.readString(),
      at: DateTime.fromMillisecondsSinceEpoch(r.readInt()),
      spoons: r.readInt(),
    );
  }
  @override void write(BinaryWriter w, EnergyLog o) {
    w.writeString(o.id);
    w.writeInt(o.at.millisecondsSinceEpoch);
    w.writeInt(o.spoons);
  }
}
