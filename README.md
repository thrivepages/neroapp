# Neroapp

A neurodivergent‑friendly planner and life organizer built with Flutter. The goal is to make planning feel *calming*, *forgiving*, and *structured enough* without becoming brittle.

> Working title(s): **Neroapp**, previously **Seize the Day**.

---

## Table of contents

* [Why this app](#why-this-app)
* [Core features (MVP)](#core-features-mvp)
* [Screens & flows](#screens--flows)
* [Architecture at a glance](#architecture-at-a-glance)
* [Project structure](#project-structure)
* [Getting started](#getting-started)
* [Running & commands](#running--commands)
* [Configuration & environment](#configuration--environment)
* [Assets](#assets)
* [State, storage & sync](#state-storage--sync)
* [Theming & accessibility](#theming--accessibility)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)

---

## Why this app

* ✅ **Low‑friction capture**: quick-add tasks, routines, and notes.
* ✅ **Gentle structure**: daily view with flexible time blocks and priority chips.
* ✅ **Extra supports**: color coding, distraction‑lite UI, large tap targets, friendly copy.
* ✅ **Cross‑platform**: Android, iOS, Web, Desktop via Flutter.

## Core features (MVP)

* **Today** view: tasks, events, focus blocks, energy/mood check‑in.
* **Planner**: week view, recurring routines, snooze/rollover.
* **Lists**: projects, shopping, someday/maybe.
* **Notes**: lightweight, link to tasks.
* **Reminders**: local notifications.

> Nice‑to‑have later: cloud sync, calendar import, Pomodoro/focus timers, widgets.

## Screens & flows

```
Onboarding → Today → (Add Task | Add Note | Start Focus)
                         ↓              ↓
                  Planner/Week     Lists/Projects
```

**Primary screens**

* `TodayScreen` – overview of the day, quick add
* `PlannerScreen` – week grid, routines, drag & drop
* `ListsScreen` – projects and custom lists
* `NoteScreen` – simple markdown/RTF notes
* `SettingsScreen` – theme, reminders, data

## Architecture at a glance

* **Flutter** + **Dart**
* **State management**: Provider (simple), easy to swap for Riverpod later
* **Data**: `sqflite` (SQLite) on device; optional mock in memory for dev
* **Navigation**: `go_router`
* **Local notifications**: `flutter_local_notifications`

> Keep dependencies light for the first pass. We can hard‑stub features and expand.

## Project structure

```
neroapp/
├─ lib/
│  ├─ main.dart
│  ├─ app/
│  │  ├─ app.dart                # MaterialApp, routes, theme
│  │  └─ router.dart             # go_router config
│  ├─ features/
│  │  ├─ today/
│  │  │  ├─ today_screen.dart
│  │  │  └─ widgets/
│  │  ├─ planner/
│  │  ├─ lists/
│  │  ├─ notes/
│  │  └─ settings/
│  ├─ data/
│  │  ├─ db.dart                 # SQLite init
│  │  ├─ models/                 # Task, Routine, Note
│  │  └─ repos/                  # Repositories
│  ├─ shared/
│  │  ├─ widgets/                # Buttons, chips, cards
│  │  ├─ theme/                  # Colors, typography
│  │  └─ utils/
│  └─ services/
│     └─ notifications.dart
├─ assets/
│  ├─ fonts/
│  └─ images/
├─ test/
└─ pubspec.yaml
```

## Getting started

### Prerequisites

* Flutter SDK (stable channel)
* Dart SDK (bundled with Flutter)
* A code editor (VS Code or Android Studio)
* Platform toolchains as needed:

  * **Android**: Android SDK + device/emulator
  * **iOS**: Xcode + iOS Simulator (macOS only)
  * **Web/Desktop**: appropriate Flutter desktop/web setup

### Setup

```bash
# 1) Clone
git clone https://github.com/thrivepages/neroapp.git
cd neroapp

# 2) Fetch dependencies
flutter pub get

# 3) (Optional) enable platforms you want to run
flutter config --enable-web
flutter config --enable-linux-desktop

# 4) Verify environment
flutter doctor -v
```

## Running & commands

```bash
# List devices (emulator, web, desktop)
flutter devices

# Run on a specific device
flutter run -d chrome      # Web
flutter run -d linux       # Linux desktop
flutter run -d emulator-5554  # Android emulator example

# Run tests
flutter test

# Build
flutter build apk          # Android
flutter build appbundle    # Play Store upload
flutter build ios          # iOS (on macOS)
flutter build web          # Web release
```

## Configuration & environment

Create `.env`‑style config later if cloud services are added. For now, app runs fully offline.

* App name: **Neroapp**
* Package name (example): `com.thrivepages.neroapp`
* Versioning: set in `pubspec.yaml` (`version: 0.1.0+1`)

## Assets

Declare fonts and images in `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

## State, storage & sync

* **Local first**: SQLite for tasks, notes, and routines.
* **Repository pattern** to decouple UI from data.
* **Sync**: future milestone (Supabase/Firebase or simple file export/import).

## Theming & accessibility

* Light & dark themes with high‑contrast palettes.
* Large tap targets (min 48x48dp), generous spacing.
* Typography tuned for readability.
* Optional reduced‑motion and focus modes.

## Roadmap

* [ ] Scaffold screens: Today, Planner, Lists, Notes, Settings
* [ ] Implement models: Task, Routine, Note
* [ ] SQLite schema + repos
* [ ] Quick‑add and rollover logic
* [ ] Local notifications
* [ ] Theming + A11y polish
* [ ] MVP test pass and first release

> Stretch goals

* [ ] Focus timer with sound cues
* [ ] Calendar import (ICS/Google)
* [ ] Cloud sync + multi‑device
* [ ] Widgets/shortcuts

## Contributing

PRs welcome. Keep diffs small and descriptive. Use conventional commit messages when possible (e.g., `feat: add Today quick add`). Run `flutter format` and `flutter analyze` before submitting.

## License

GPL‑3.0. See `LICENSE`.
