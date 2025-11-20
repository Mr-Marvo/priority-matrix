import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_matrix/domain/entities/task.dart';
import 'package:priority_matrix/presentation/providers/task_providers.dart';

class TaskListItem extends ConsumerWidget {
  final Task task;
  final bool showCheckbox;

  const TaskListItem({
    super.key,
    required this.task,
    this.showCheckbox = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: showCheckbox
          ? Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                ref.read(taskNotifierProvider.notifier).toggleTaskCompletion(task);
              },
            )
          : null,
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color: task.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: Text(
        task.matrixType.displayName,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Task'),
              content: const Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(taskNotifierProvider.notifier).deleteTask(task.id);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
