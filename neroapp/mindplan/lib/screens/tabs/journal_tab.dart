import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/journal_entry.dart';

class JournalTab extends StatefulWidget {
  const JournalTab({super.key});

  @override
  State<JournalTab> createState() => _JournalTabState();
}

class _JournalTabState extends State<JournalTab> {
  List<JournalEntry> entries = [
    JournalEntry(
      title: "Great day at work",
      content: "Had an amazing presentation today. Everything went smoothly and the team loved the new ideas.",
      mood: "😊",
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    JournalEntry(
      title: "Weekend plans",
      content: "Looking forward to the hiking trip this weekend. Need to pack some extra water and snacks.",
      mood: "😄",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    JournalEntry(
      title: "Reflection time",
      content: "Been thinking about my goals for this year. Want to focus more on personal growth and health.",
      mood: "🤔",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  final String selectedMood = '😊';
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFEFCE8), // Legal pad yellow
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Journal',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ElevatedButton(
                    onPressed: _addEntry,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(LucideIcons.plus, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Search and mood filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search entries...',
                          prefixIcon: Icon(LucideIcons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text('😊', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Entries list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildEntryCard(entry),
                  );
                },
              ),

              const SizedBox(height: 100), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEntryCard(JournalEntry entry) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  entry.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                entry.mood,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.content,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDateTime(entry.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _editEntry(entry),
                    icon: const Icon(LucideIcons.edit2, size: 16),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _deleteEntry(entry.id),
                    icon: const Icon(LucideIcons.trash2, size: 16, color: Colors.red),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addEntry() {
    // TODO: Navigate to add entry screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add entry functionality coming soon!')),
    );
  }

  void _editEntry(JournalEntry entry) {
    // TODO: Navigate to edit entry screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit "${entry.title}" coming soon!')),
    );
  }

  void _deleteEntry(String entryId) {
    setState(() {
      entries.removeWhere((entry) => entry.id == entryId);
    });
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}