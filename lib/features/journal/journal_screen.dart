
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repos.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalProvider).reversed.toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Journal')),
        body: ListView.separated(
          itemCount: entries.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final e = entries[i];
            return ListTile(
              title: Text(e.text),
              subtitle: Text(e.createdAt.toLocal().toString()),
              trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {
                ref.read(journalProvider.notifier).remove(e.id);
              }),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final text = await showDialog<String>(context: context, builder: (ctx) => const _NewEntryDialog());
            if (text != null && text.trim().isNotEmpty) {
              await ref.read(journalProvider.notifier).add(text.trim());
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _NewEntryDialog extends StatefulWidget {
  const _NewEntryDialog();
  @override
  State<_NewEntryDialog> createState() => _NewEntryDialogState();
}
class _NewEntryDialogState extends State<_NewEntryDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Journal Entry'),
      content: TextField(
        controller: controller,
        minLines: 3,
        maxLines: 8,
        decoration: const InputDecoration(hintText: 'Write your thoughts...'),
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: ()=>Navigator.pop(context, controller.text), child: const Text('Save')),
      ],
    );
  }
}
