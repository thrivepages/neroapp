
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repos.dart';

class PlannerScreen extends ConsumerWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Planner')),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, i) {
            final t = tasks[i];
            return Dismissible(
              key: ValueKey(t.id),
              background: Container(color: Colors.redAccent),
              onDismissed: (_) => ref.read(tasksProvider.notifier).remove(t.id),
              child: CheckboxListTile(
                value: t.done,
                onChanged: (_) => ref.read(tasksProvider.notifier).toggle(t.id),
                title: Text(t.title),
                subtitle: t.notes != null ? Text(t.notes!) : null,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final title = await showDialog<String>(context: context, builder: (ctx) => const _NewTaskDialog());
            if (title != null && title.trim().isNotEmpty) {
              await ref.read(tasksProvider.notifier).add(title.trim());
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _NewTaskDialog extends StatefulWidget {
  const _NewTaskDialog();
  @override
  State<_NewTaskDialog> createState() => _NewTaskDialogState();
}
class _NewTaskDialogState extends State<_NewTaskDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Title')),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: ()=>Navigator.pop(context, controller.text), child: const Text('Add')),
      ],
    );
  }
}
