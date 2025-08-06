import 'package:flutter/material.dart';

class MoodMindTab extends StatefulWidget {
  const MoodMindTab({super.key});

  @override
  State<MoodMindTab> createState() => _MoodMindTabState();
}

class _MoodMindTabState extends State<MoodMindTab> {
  String selectedMood = '😊';
  final TextEditingController notesController = TextEditingController();
  
  final List<String> moods = ['😊', '😄', '😐', '😔', '😟', '😡', '😴', '🤔'];
  
  final List<Map<String, dynamic>> moodHistory = [
    {'date': 'Today', 'mood': '😊', 'note': 'Had a great day!'},
    {'date': 'Yesterday', 'mood': '😐', 'note': 'Average day, nothing special'},
    {'date': '2 days ago', 'mood': '😄', 'note': 'Went out with friends'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _getMoodGradientColors(),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Mood & Mind',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 32),

              // Mood selector
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Select Your Mood',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: moods.map((mood) => _buildMoodButton(mood)).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Notes section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mental Check-in',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'How are you feeling? What\'s on your mind?',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveEntry,
                      child: const Text('Save Entry'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Mood history
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Moods',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: moodHistory.length,
                      itemBuilder: (context, index) {
                        final entry = moodHistory[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    entry['mood'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry['date'],
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      entry['note'],
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(String mood) {
    final isSelected = selectedMood == mood;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = mood;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
        ),
        child: Center(
          child: Text(
            mood,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }

  List<Color> _getMoodGradientColors() {
    switch (selectedMood) {
      case '😊':
      case '😄':
        return [Colors.orange.shade300, Colors.yellow.shade400];
      case '😐':
        return [Colors.blue.shade300, Colors.indigo.shade400];
      case '😔':
      case '😟':
        return [Colors.grey.shade400, Colors.blueGrey.shade500];
      case '😡':
        return [Colors.red.shade300, Colors.orange.shade400];
      default:
        return [Colors.blue.shade300, Colors.indigo.shade400];
    }
  }

  void _saveEntry() {
    if (notesController.text.isNotEmpty) {
      setState(() {
        moodHistory.insert(0, {
          'date': 'Just now',
          'mood': selectedMood,
          'note': notesController.text,
        });
      });
      notesController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood entry saved!')),
      );
    }
  }
}