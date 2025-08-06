# MindPlan Flutter App

A Flutter conversion of the React MindPlan productivity and wellness app. This mobile app helps users manage tasks, journal thoughts, track moods, and customize their experience.

## Features

### 📱 Core Functionality
- **Four Main Tabs**: Planner, Journal, Mood & Mind, Customize
- **Bottom Navigation**: Smooth tab switching with icons and labels
- **Material Design 3**: Modern, clean UI with custom theming

### 📅 Planner Tab
- **Interactive Sticky Notes**: Create, edit, and delete colored notes
- **Task Management**: Complete, toggle, and track daily tasks
- **Multiple Views**: Daily, Weekly, and Monthly calendar views
- **Week Display**: Interactive weekly calendar with task indicators
- **Monthly Calendar**: Full-screen calendar with date selection and statistics
- **Smart Navigation**: Quick access between different time periods

### 📔 Journal Tab
- **Legal Pad Design**: Authentic yellow notepad background
- **Entry Management**: Create, edit, and delete journal entries
- **Mood Integration**: Emoji mood selection for each entry
- **Search Functionality**: Find entries with search bar
- **Timestamp Display**: Relative time formatting (e.g., "2 hours ago")

### 🧠 Mood & Mind Tab
- **Daily Mood Tracking**: Select from 8 different mood emojis
- **Gradient Backgrounds**: Dynamic colors based on selected mood
- **Mental Check-ins**: Notes field for thoughts and feelings
- **Mood History**: Track mood patterns over time
- **Visual Design**: Beautiful gradient interface with glassmorphism effects

### ⚙️ Customize Tab
- **Theme Selection**: Light, Dark, and System themes
- **App Tone**: Choose between Motivational, Calm, or Fun personalities
- **Feature Toggles**: Show/hide app features
- **App Information**: Version, support, and privacy links

## Technical Architecture

### State Management
- **Provider Pattern**: Clean, scalable state management
- **AppState**: Centralized app configuration and navigation
- **Local State**: Component-specific state for UI interactions

### Models
- **Task**: Task management with completion, time, and priority
- **StickyNote**: Note management with colors and timestamps
- **JournalEntry**: Journal entries with mood and content

### UI Components
- **Custom Widgets**: Reusable components for notes, tasks, and calendar
- **Theme System**: Comprehensive theming with Material Design 3
- **Responsive Design**: Optimized for various screen sizes

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd flutter_export
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Project Structure
```
lib/
├── main.dart                     # App entry point
├── models/                       # Data models
│   ├── task.dart
│   ├── note.dart
│   └── journal_entry.dart
├── providers/                    # State management
│   └── app_state.dart
├── screens/                      # Main screens
│   ├── home_screen.dart
│   └── tabs/
│       ├── planner_tab.dart
│       ├── journal_tab.dart
│       ├── mood_mind_tab.dart
│       └── customize_tab.dart
├── theme/                        # App theming
│   └── app_theme.dart
└── widgets/                      # Reusable components
    ├── sticky_note_widget.dart
    ├── task_item_widget.dart
    └── week_view_widget.dart
```

## Dependencies

### Core
- `flutter`: SDK
- `provider`: State management
- `cupertino_icons`: iOS-style icons

### UI & Navigation
- `lucide_icons`: Beautiful icon set
- `table_calendar`: Calendar functionality

### Utilities
- `shared_preferences`: Local storage
- `uuid`: Unique ID generation

## Key Features Implementation

### Calendar Integration
- Uses `table_calendar` package for month view
- Custom week view widget with interactive day selection
- Date formatting and navigation utilities

### Theming System
- Material Design 3 with custom color schemes
- Dynamic theme switching (Light/Dark/System)
- Consistent typography and spacing

### State Persistence
- Models designed for JSON serialization
- Ready for SharedPreferences or database integration
- Proper state management patterns

## Customization

### Adding New Features
1. **Models**: Create data models in `/models`
2. **State**: Add to `AppState` provider if global
3. **UI**: Create widgets in `/widgets` or screens in `/screens`
4. **Navigation**: Update bottom navigation if needed

### Theming
- Modify `AppTheme` class for color schemes
- Update `AppState` for new theme options
- Add new gradient colors for mood states

### Data Persistence
- Implement `toJson()` and `fromJson()` methods in models
- Add SharedPreferences or database integration
- Update providers to load/save data

## Build & Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Testing
```bash
flutter test
```

## Performance Considerations

- **Lazy Loading**: ListView.builder for efficient scrolling
- **State Optimization**: Minimal rebuilds with Provider
- **Memory Management**: Proper disposal of controllers
- **Image Optimization**: Efficient asset loading

## Future Enhancements

### Data & Sync
- Cloud synchronization with Firebase/Supabase
- Local database integration (Hive/Sqflite)
- Data export/import functionality

### Features
- Push notifications for reminders
- Widget support for quick access
- Advanced mood analytics and insights
- Task categories and priorities
- Habit tracking integration

### UI/UX
- Animations and transitions
- Custom icon themes
- Accessibility improvements
- Tablet optimization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please create an issue in the repository or contact the development team.

---

**MindPlan Flutter** - Your personal productivity & wellness companion, now on mobile!