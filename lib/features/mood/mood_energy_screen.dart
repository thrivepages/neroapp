
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repos.dart';

class MoodEnergyScreen extends ConsumerWidget {
  const MoodEnergyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moods = ref.watch(moodProvider);
    final energy = ref.watch(energyProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Mood & Energy')),
        body: Column(
          children: [
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['😀','🙂','😐','😕','😢','😡','🥱','🤒'].map((m)=>ElevatedButton(
                onPressed: ()=>ref.read(moodProvider.notifier).add(m),
                child: Text(m, style: const TextStyle(fontSize: 18)),
              )).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Spoons:'),
                const SizedBox(width: 8),
                for (var i=1;i<=10;i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: OutlinedButton(
                      onPressed: ()=>ref.read(energyProvider.notifier).add(i),
                      child: Text('$i'),
                    ),
                  )
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  const ListTile(title: Text('Recent moods')),
                  ...moods.reversed.take(20).map((m)=>ListTile(
                    leading: Text(m.mood, style: const TextStyle(fontSize: 20)),
                    title: Text(m.at.toLocal().toString()),
                  )),
                  const Divider(),
                  const ListTile(title: Text('Recent energy logs')),
                  ...energy.reversed.take(20).map((e)=>ListTile(
                    leading: const Icon(Icons.bolt),
                    title: Text('${e.spoons} spoons'),
                    subtitle: Text(e.at.toLocal().toString()),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
