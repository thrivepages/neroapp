
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'models.dart';

const _uuid = Uuid();

final stickyBoxProvider = Provider<Box<StickyNote>>((ref) => throw UnimplementedError());
final visionBoxProvider = Provider<Box<VisionImage>>((ref) => throw UnimplementedError());

final stickyProvider = StateNotifierProvider<StickyNotifier, List<StickyNote>>((ref) {
  final box = ref.watch(stickyBoxProvider);
  return StickyNotifier(box);
});
class StickyNotifier extends StateNotifier<List<StickyNote>> {
  final Box<StickyNote> box;
  StickyNotifier(this.box): super(box.values.toList());
  Future<void> add(String text, {double x=40, double y=40}) async {
    final s = StickyNote(id: _uuid.v4(), text: text, x: x, y: y);
    await box.put(s.id, s); state = box.values.toList();
  }
  Future<void> updatePos(String id, double x, double y) async {
    final s = box.get(id); if (s!=null) { s.x=x; s.y=y; await s.save(); state = box.values.toList(); }
  }
  Future<void> remove(String id) async { await box.delete(id); state = box.values.toList(); }
}

final visionProvider = StateNotifierProvider<VisionNotifier, List<VisionImage>>((ref) {
  final box = ref.watch(visionBoxProvider);
  return VisionNotifier(box);
});
class VisionNotifier extends StateNotifier<List<VisionImage>> {
  final Box<VisionImage> box;
  VisionNotifier(this.box): super(box.values.toList());
  Future<void> add(String path, {String? caption}) async {
    final v = VisionImage(id: _uuid.v4(), path: path, caption: caption);
    await box.put(v.id, v); state = box.values.toList();
  }
  Future<void> remove(String id) async { await box.delete(id); state = box.values.toList(); }
}

@HiveType(typeId: 5)
class StickyNote extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String text;
  @HiveField(2) double x;
  @HiveField(3) double y;
  StickyNote({required this.id, required this.text, required this.x, required this.y});
}

class StickyNoteAdapter extends TypeAdapter<StickyNote> {
  @override final typeId = 5;
  @override StickyNote read(BinaryReader r) => StickyNote(id: r.readString(), text: r.readString(), x: r.readDouble(), y: r.readDouble());
  @override void write(BinaryWriter w, StickyNote o) { w.writeString(o.id); w.writeString(o.text); w.writeDouble(o.x); w.writeDouble(o.y); }
}

@HiveType(typeId: 6)
class VisionImage extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String path;
  @HiveField(2) String? caption;
  VisionImage({required this.id, required this.path, this.caption});
}

class VisionImageAdapter extends TypeAdapter<VisionImage> {
  @override final typeId = 6;
  @override VisionImage read(BinaryReader r) => VisionImage(id: r.readString(), path: r.readString(), caption: r.readBool()? r.readString(): null);
  @override void write(BinaryWriter w, VisionImage o) {
    w.writeString(o.id); w.writeString(o.path);
    if (o.caption!=null) { w.writeBool(true); w.writeString(o.caption!); } else { w.writeBool(false); }
  }
}
