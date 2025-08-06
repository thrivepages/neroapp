import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/task.dart';
import '../../models/note.dart';
import '../../theme/app_theme.dart';
import '../../widgets/sticky_note_widget.dart';
import '../../widgets/task_item_widget.dart';
import '../../widgets/week_view_widget.dart';

class PlannerTab extends StatefulWidget {
  const PlannerTab({super.key});

  @override
  State<PlannerTab> createState() => _PlannerTabState();
}

class _PlannerTabState extends State<PlannerTab> {
  String viewMode = 'daily'; // 'daily', 'weekly', 'monthly'
  bool showMonthCalendar = false;
  DateTime selectedDate = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<StickyNote> notes = [
    StickyNote(
      content: 'Team meeting at 2 PM',
      color: AppTheme.yellowNote,
    ),
    StickyNote(
      content: 'Buy groceries',
      color: AppTheme.blueNote,
    ),
    StickyNote(
      content: 'Finish project proposal',
      color: AppTheme.yellowNote,
    ),
  ];

  List<Task> tasks = [
    Task(
      text: 'Review quarterly reports',
      time: '10:00 AM',
      completed: false,
    ),
    Task(
      text: 'Call client about contract',
      time: '2:00 PM',
      completed: true,
    ),
    Task(
      text: 'Prepare presentation slides',
      time: '4:00 PM',
      completed: false,
    ),
  ];

  void _addNote() {
    final colors = [AppTheme.yellowNote, AppTheme.blueNote];
    setState(() {
      notes.add(
        StickyNote(
          content: 'New note',
          color: colors[notes.length % 2],
        ),
      );
    });
  }

  void _toggleTask(String taskId) {
    setState(() {
      final taskIndex = tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        tasks[taskIndex] = tasks[taskIndex].copyWith(
          completed: !tasks[taskIndex].completed,
        );
      }
    });
  }

  void _deleteNote(String noteId) {
    setState(() {
      notes.removeWhere((note) => note.id == noteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Planner',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ElevatedButton(
                      onPressed: _addNote,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Icon(LucideIcons.plus, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // View mode toggle
                Row(
                  children: [
                    const Icon(LucideIcons.calendar, size: 20, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Today, ${_formatDate(DateTime.now())}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    _buildViewModeButtons(),
                  ],
                ),
                const SizedBox(height: 24),

                // Week view display
                if (viewMode == 'weekly') ...[
                  WeekViewWidget(
                    selectedDate: selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    tasks: tasks,
                    onViewMonth: () {
                      setState(() {
                        showMonthCalendar = true;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                // Quick notes section
                Text(
                  'Quick Notes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return StickyNoteWidget(
                      note: notes[index],
                      onDelete: () => _deleteNote(notes[index].id),
                      onEdit: (content) {
                        setState(() {
                          notes[index] = notes[index].copyWith(content: content);
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Tasks section
                Row(
                  children: [
                    Text(
                      viewMode == 'weekly' ? "This Week's Tasks" : "Today's Tasks",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TaskItemWidget(
                        task: tasks[index],
                        onToggle: () => _toggleTask(tasks[index].id),
                        showWeekLabel: viewMode == 'weekly',
                      ),
                    );
                  },
                ),

                // Weekly goal prompt
                if (viewMode == 'weekly') ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Plan your week efficiently',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue.shade200),
                            foregroundColor: Colors.blue.shade700,
                          ),
                          child: const Text('Add Weekly Goal'),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 100), // Bottom padding for navigation
              ],
            ),
          ),

          // Month calendar overlay
          if (showMonthCalendar) _buildMonthCalendarOverlay(),
        ],
      ),
    );
  }

  Widget _buildViewModeButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildViewButton('Daily', 'daily'),
        const SizedBox(width: 8),
        _buildViewButton('Weekly', 'weekly'),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            setState(() {
              showMonthCalendar = true;
            });
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Monthly'),
        ),
      ],
    );
  }

  Widget _buildViewButton(String label, String mode) {
    final isSelected = viewMode == mode;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          viewMode = mode;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
        elevation: isSelected ? 2 : 0,
        side: isSelected ? null : const BorderSide(color: Colors.grey),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(label),
    );
  }

  Widget _buildMonthCalendarOverlay() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Calendar',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showMonthCalendar = false;
                      });
                    },
                    icon: const Icon(LucideIcons.x),
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
            ),

            // Calendar
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TableCalendar<Task>(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: focusedDay,
                      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          selectedDate = selectedDay;
                          this.focusedDay = focusedDay;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Selected date info
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatFullDate(selectedDate),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isSameDay(selectedDate, DateTime.now())
                                ? 'Today - Tap a task below to schedule it for this day'
                                : 'Tap to plan activities for this date',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    showMonthCalendar = false;
                                    viewMode = 'daily';
                                  });
                                },
                                child: const Text('View Day'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    showMonthCalendar = false;
                                    viewMode = 'weekly';
                                  });
                                },
                                child: const Text('View Week'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Month overview stats
                    Text(
                      'This Month Overview',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        _buildStatCard(
                          '${tasks.where((t) => !t.completed).length}',
                          'Pending Tasks',
                          Colors.blue,
                        ),
                        _buildStatCard(
                          '${tasks.where((t) => t.completed).length}',
                          'Completed',
                          Colors.green,
                        ),
                        _buildStatCard(
                          '${notes.length}',
                          'Quick Notes',
                          Colors.orange,
                        ),
                        _buildStatCard(
                          '${DateTime.now().day}',
                          'Today',
                          Colors.purple,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _formatFullDate(DateTime date) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June',
                   'July', 'August', 'September', 'October', 'November', 'December'];
    
    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    
    return '$weekday, $month ${date.day}, ${date.year}';
  }
}