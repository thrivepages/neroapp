import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/app_state.dart';
import '../screens/tabs/planner_tab.dart';
import '../screens/tabs/journal_tab.dart';
import '../screens/tabs/mood_mind_tab.dart';
import '../screens/tabs/customize_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: appState.currentTabIndex,
              children: const [
                PlannerTab(),
                JournalTab(),
                MoodMindTab(),
                CustomizeTab(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: BottomNavigationBar(
                currentIndex: appState.currentTabIndex,
                onTap: appState.setCurrentTab,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).cardColor,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey[600],
                elevation: 0,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.calendar, size: 22),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.calendar, size: 22),
                    ),
                    label: 'Planner',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.bookOpen, size: 22),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.bookOpen, size: 22),
                    ),
                    label: 'Journal',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.brain, size: 22),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.brain, size: 22),
                    ),
                    label: 'Mood & Mind',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.settings, size: 22),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(LucideIcons.settings, size: 22),
                    ),
                    label: 'Customize',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}