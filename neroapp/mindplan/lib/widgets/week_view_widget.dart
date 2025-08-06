import 'package:flutter/material.dart';
import '../models/task.dart';

class WeekViewWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final List<Task> tasks;
  final VoidCallback onViewMonth;

  const WeekViewWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.tasks,
    required this.onViewMonth,
  });

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays(selectedDate);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'This Week',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${_formatDate(weekDays.first)} - ${_formatDate(weekDays.last)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Week grid
          Row(
            children: weekDays.map((day) => Expanded(child: _buildDayCell(context, day))).toList(),
          ),
          
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tasks.where((t) => !t.completed).length} tasks pending this week',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextButton(
                onPressed: onViewMonth,
                child: const Text('View Month'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(BuildContext context, DateTime day) {
    final isToday = _isSameDay(day, DateTime.now());
    final isSelected = _isSameDay(day, selectedDate);

    return GestureDetector(
      onTap: () => onDateSelected(day),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isToday 
              ? Colors.blue.shade100 
              : (isSelected ? Colors.grey.shade100 : Colors.transparent),
          borderRadius: BorderRadius.circular(8),
          border: isToday 
              ? Border.all(color: Colors.blue.shade200, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
        ),
        child: Column(
          children: [
            Text(
              _getDayName(day),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? Colors.blue.shade700 : Colors.black,
              ),
            ),
            if (isToday) ...[
              const SizedBox(height: 4),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  shape: BoxShape.circle,
                ),
              ),
            ],
            const SizedBox(height: 4),
            // Task indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isToday) ...[
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _getWeekDays(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}