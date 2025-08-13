import 'mind_providers.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models.dart';
import '../../data/repos.dart';

class MindScreen extends ConsumerStatefulWidget {
  const MindScreen({super.key});
  @override
  ConsumerState<MindScreen> createState() => _MindScreenState();
}

class _MindScreenState extends ConsumerState<MindScreen> {
  Future<void> _addNote() async {
    final txt = await showDialog<String>(context: context, builder: (_) => const _NewNoteDialog());
    if (txt!=null && txt.trim().isNotEmpty) {
      await ref.read(stickyProvider.notifier).add(txt.trim());
    }
  }

  Future<void> _addImage() async {
    final picker = ImagePicker();
ref.read(stickyProvider.notifier).add(txt.trim());
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${DateTime.now().millisecondsSinceEpoch}_${picked.name}');
    await file.writeAsBytes(await picked.readAsBytes());
ref.read(visionProvider.notifier).add(file.path);
    await ref.read(visionProvider.notifier).add(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(stickyProvider);
    final images = ref.watch(visionProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mind'),
          actions: [
            IconButton(onPressed: _addNote, icon: const Icon(Icons.note_add_outlined)),
            IconButton(onPressed: _addImage, icon: const Icon(Icons.add_photo_alternate_outlined)),
          ],
        ),
        body: Stack(
          children: [
            for (final n in notes) _DraggableNote(note: n),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 220,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 6),
                  itemCount: images.length,
                  itemBuilder: (_, i) {
                    final v = images[i];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(File(v.path), fit: BoxFit.cover),
                        Positioned(
                          right: 4, top: 4,
                          child: InkWell(
                            onTap: ()=>ref.read(visionProvider.notifier).remove(v.id),
                            child: Container(color: Colors.black54, child: const Icon(Icons.close, color: Colors.white)),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DraggableNote extends ConsumerWidget {
  final StickyNote note;
  const _DraggableNote({required this.note});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: note.x, top: note.y,
      child: Draggable(
        feedback: _NoteCard(text: note.text),
        childWhenDragging: const SizedBox.shrink(),
        onDragEnd: (details) {
          final offset = details.offset;
          ref.read(stickyProvider.notifier).updatePos(note.id, offset.dx, offset.dy);
        },
        child: _NoteCard(text: note.text, onDelete: ()=>ref.read(stickyProvider.notifier).remove(note.id)),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final String text;
  final VoidCallback? onDelete;
  const _NoteCard({required this.text, this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            if (onDelete!=null) ...[
              const SizedBox(width: 8),
              InkWell(onTap: onDelete, child: const Icon(Icons.delete_outline, size: 18))
            ]
          ],
        ),
      ),
    );
  }
}

class _NewNoteDialog extends StatefulWidget {
  const _NewNoteDialog();
  @override
  State<_NewNoteDialog> createState() => _NewNoteDialogState();
}
class _NewNoteDialogState extends State<_NewNoteDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Note'),
      content: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Text')),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: ()=>Navigator.pop(context, controller.text), child: const Text('Add')),
      ],
    );
  }
}
