import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/app_state.dart';

class CustomizeTab extends StatelessWidget {
  const CustomizeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Customize',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Personalize your MindPlan experience',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // Theme selector
                _buildSection(
                  context,
                  'Theme',
                  'Choose your preferred app appearance',
                  Column(
                    children: [
                      _buildThemeOption(context, appState, 'Light', ThemeMode.light, LucideIcons.sun),
                      _buildThemeOption(context, appState, 'Dark', ThemeMode.dark, LucideIcons.moon),
                      _buildThemeOption(context, appState, 'System', ThemeMode.system, LucideIcons.smartphone),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Tone selector
                _buildSection(
                  context,
                  'App Tone',
                  'Set the personality of your app',
                  Column(
                    children: [
                      _buildToneOption(context, appState, 'Motivational', 'motivational', '🚀'),
                      _buildToneOption(context, appState, 'Calm', 'calm', '🧘'),
                      _buildToneOption(context, appState, 'Fun', 'fun', '🎉'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Feature toggles
                _buildSection(
                  context,
                  'Features',
                  'Show or hide app features',
                  Column(
                    children: [
                      _buildToggleOption(context, 'Show sticky notes', true, (value) {}),
                      _buildToggleOption(context, 'Show mood tracking', true, (value) {}),
                      _buildToggleOption(context, 'Show weekly view', true, (value) {}),
                      _buildToggleOption(context, 'Enable notifications', false, (value) {}),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // About section
                _buildSection(
                  context,
                  'About',
                  'App information and support',
                  Column(
                    children: [
                      _buildInfoOption(context, 'Version', '1.0.0', LucideIcons.info),
                      _buildInfoOption(context, 'Support', 'Get help', LucideIcons.helpCircle),
                      _buildInfoOption(context, 'Privacy', 'Privacy policy', LucideIcons.shield),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Bottom padding
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String title, String description, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, AppState appState, String title, ThemeMode mode, IconData icon) {
    final isSelected = appState.themeMode == mode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => appState.setThemeMode(mode),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(8),
            border: isSelected ? Border.all(color: Theme.of(context).primaryColor) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  LucideIcons.check,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToneOption(BuildContext context, AppState appState, String title, String tone, String emoji) {
    final isSelected = appState.appTone == tone;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => appState.setAppTone(tone),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(8),
            border: isSelected ? Border.all(color: Theme.of(context).primaryColor) : null,
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  LucideIcons.check,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption(BuildContext context, String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoOption(BuildContext context, String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title: $subtitle')),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey[600]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}