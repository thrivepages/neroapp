
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Box settings;
  String tone = 'professional';

  @override
  void initState() {
    super.initState();
    settings = Hive.box('settings');
    tone = settings.get('tone', defaultValue: 'professional') as String;
  }

  void _saveTone(String t) {
    setState(()=>tone=t);
    settings.put('tone', t);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tone saved (applies on next launch).')));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          children: [
            const ListTile(title: Text('Tone / Font')),
            RadioListTile<String>(title: const Text('Professional'), value: 'professional', groupValue: tone, onChanged: (v)=>_saveTone(v!)),
            RadioListTile<String>(title: const Text('Charming'), value: 'charming', groupValue: tone, onChanged: (v)=>_saveTone(v!)),
            RadioListTile<String>(title: const Text('Silly'), value: 'silly', groupValue: tone, onChanged: (v)=>_saveTone(v!)),
            RadioListTile<String>(title: const Text('Handwritten'), value: 'handwritten', groupValue: tone, onChanged: (v)=>_saveTone(v!)),
          ],
        ),
      ),
    );
  }
}
