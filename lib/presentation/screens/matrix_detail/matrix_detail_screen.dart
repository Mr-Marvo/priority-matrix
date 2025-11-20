import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/core/theme/app_theme.dart';
import 'package:priority_matrix/presentation/providers/task_providers.dart';
import 'package:priority_matrix/presentation/widgets/add_task_dialog.dart';
import 'package:priority_matrix/presentation/widgets/task_list_item.dart';

class MatrixDetailScreen extends ConsumerWidget {
  final MatrixType matrixType;

  const MatrixDetailScreen({
    super.key,
    required this.matrixType,
  });

  Color _getMatrixColor() {
    switch (matrixType) {
      case MatrixType.doItNow:
        return AppTheme.doItNowColor;
      case MatrixType.planIt:
        return AppTheme.planItColor;
      case MatrixType.delegateIt:
        return AppTheme.delegateItColor;
      case MatrixType.dropIt:
        return AppTheme.dropItColor;
    }
  }

  IconData _getMatrixIcon() {
    switch (matrixType) {
      case MatrixType.doItNow:
        return Icons.flash_on;
      case MatrixType.planIt:
        return Icons.event_note;
      case MatrixType.delegateIt:
        return Icons.people;
      case MatrixType.dropIt:
        return Icons.delete_outline;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksByMatrixProvider(matrixType));

    return Scaffold(
      appBar: AppBar(
        title: Text(matrixType.displayName),
        backgroundColor: _getMatrixColor(),
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: _getMatrixColor(),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Icon(
                  _getMatrixIcon(),
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  matrixType.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Task List
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                // Filter out completed tasks
                final incompleteTasks =
                    tasks.where((task) => !task.isCompleted).toList();

                if (incompleteTasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No active tasks',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the + button to add a task',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Sort by creation date (newest first)
                incompleteTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                return ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: incompleteTasks.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final task = incompleteTasks[index];
                    return Card(
                      child: TaskListItem(task: task),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error loading tasks: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(initialMatrixType: matrixType),
          );
        },
        backgroundColor: _getMatrixColor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
