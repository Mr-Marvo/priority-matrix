# Priority Matrix

A Flutter mobile application for managing tasks using the Eisenhower Priority Matrix principle.

## Features

- **Splash Screen**: Welcome screen with "Priority Matrix" branding
- **2x2 Priority Grid**: Four quadrants based on the Eisenhower Matrix:
  - Do It Now (Urgent & Important)
  - Plan It (Important, Not Urgent)
  - Delegate It (Urgent, Not Important)
  - Drop It (Not Urgent, Not Important)
- **Task Management**:
  - Add tasks with matrix type and task name
  - Mark tasks as complete with checkbox
  - View all tasks with completed tasks shown with strike-through
  - Delete tasks
- **Matrix Detail Views**: View incomplete tasks for each specific matrix quadrant
- **Persistent Storage**: Uses Hive for local database (no login required)

## Architecture

The app follows Clean Architecture principles with three layers:

### Domain Layer
- Entities: Core business objects (Task)
- Repository Interfaces: Abstract definitions of data operations

### Data Layer
- Models: Data transfer objects with Hive annotations (TaskModel)
- Data Sources: Hive local database implementation
- Repository Implementation: Concrete implementation of repository interfaces

### Presentation Layer
- Screens: UI screens (Splash, Home, Matrix Detail)
- Widgets: Reusable UI components
- Providers: Riverpod state management

## Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Local Database**: Hive
- **Architecture**: Clean Architecture

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── matrix_type.dart
│   └── theme/
│       └── app_theme.dart
├── data/
│   ├── datasources/
│   │   └── task_local_datasource.dart
│   ├── models/
│   │   ├── task_model.dart
│   │   └── task_model.g.dart
│   └── repositories/
│       └── task_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── task.dart
│   └── repositories/
│       └── task_repository.dart
├── presentation/
│   ├── providers/
│   │   └── task_providers.dart
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── matrix_detail/
│   │   │   └── matrix_detail_screen.dart
│   │   └── splash/
│   │       └── splash_screen.dart
│   └── widgets/
│       ├── add_task_dialog.dart
│       ├── matrix_card.dart
│       └── task_list_item.dart
└── main.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Usage

1. **Adding a Task**: Tap the floating action button (+) on the home screen
2. **Viewing Matrix Tasks**: Tap on any of the four matrix cards to view tasks in that category
3. **Completing Tasks**: Check the checkbox next to a task to mark it as complete
4. **Deleting Tasks**: Tap the delete icon on any task

## Key Behaviors

- Completed tasks are hidden in individual matrix detail screens
- Completed tasks are shown with strike-through text in the "All Tasks" list on the home screen
- Tasks are sorted by completion status and creation date
- No authentication or signup required

## License

This project is open source and available under the MIT License.
