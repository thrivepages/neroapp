import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/note.dart';

class StickyNoteWidget extends StatefulWidget {
  final StickyNote note;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const StickyNoteWidget({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<StickyNoteWidget> createState() => _StickyNoteWidgetState();
}

class _StickyNoteWidgetState extends State<StickyNoteWidget> {
  bool isEditing = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void _saveEdit() {
    widget.onEdit(controller.text);
    setState(() {
      isEditing = false;
    });
  }

  void _cancelEdit() {
    controller.text = widget.note.content;
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.note.color,
        borderRadius: BorderRadius.circular(8),
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
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isEditing) ...[
                GestureDetector(
                  onTap: _startEditing,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(LucideIcons.edit2, size: 12),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(LucideIcons.trash2, size: 12, color: Colors.red),
                  ),
                ),
              ] else ...[
                GestureDetector(
                  onTap: _saveEdit,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(LucideIcons.check, size: 12, color: Colors.green),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: _cancelEdit,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(LucideIcons.x, size: 12, color: Colors.red),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          
          // Content
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 14),
                    textAlignVertical: TextAlignVertical.top,
                  )
                : GestureDetector(
                    onTap: _startEditing,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.note.content,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}