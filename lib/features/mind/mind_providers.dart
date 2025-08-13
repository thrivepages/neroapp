import 'package:flutter_riverpod/flutter_riverpod.dart';

// Basic StickyNote model
class StickyNote {
  final String id;
  final String text;
  final double x;
  final double y;

  StickyNote({
    required this.id,
    required this.text,
    this.x = 0,
    this.y = 0,
  });
}

// Dummy VisionBoard image model
class VisionImage {
  final String id;
  final String path;

  VisionImage({required this.id, required this.path});
}

// Placeholder Sticky Notes provider
final stickyProvider = StateNotifierProvider<StickyNotifier, List<StickyNote>>(
  (ref) => StickyNotifier(),
);

class StickyNotifier extends StateNotifier<List<StickyNote>> {
  StickyNotifier() : super([]);

  void add(String text) {
    state = [
      ...state,
      StickyNote(id: DateTime.now().toString(), text: text),
    ];
  }

  void remove(String id) {
    state = state.where((note) => note.id != id).toList();
  }

  void updatePos(String id, double x, double y) {
    state = [
      for (final note in state)
        if (note.id == id)
          StickyNote(id: note.id, text: note.text, x: x, y: y)
        else
          note
    ];
  }
}

// Placeholder Vision Board provider
final visionProvider =
    StateNotifierProvider<VisionNotifier, List<VisionImage>>(
  (ref) => VisionNotifier(),
);

class VisionNotifier extends StateNotifier<List<VisionImage>> {
  VisionNotifier() : super([]);

  void add(String path) {
    state = [
      ...state,
      VisionImage(id: DateTime.now().toString(), path: path),
    ];
  }

  void remove(String id) {
    state = state.where((img) => img.id != id).toList();
  }
}
