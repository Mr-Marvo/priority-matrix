import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/domain/entities/task.dart';
import 'package:priority_matrix/presentation/providers/task_providers.dart';

class AddTaskDialog extends ConsumerStatefulWidget {
  final MatrixType? initialMatrixType;

  const AddTaskDialog({
    super.key,
    this.initialMatrixType,
  });

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  late MatrixType _selectedMatrixType;

  @override
  void initState() {
    super.initState();
    _selectedMatrixType = widget.initialMatrixType ?? MatrixType.doItNow;
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _taskNameController.text.trim(),
        matrixType: _selectedMatrixType,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      await ref.read(taskNotifierProvider.notifier).addTask(task);

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<MatrixType>(
              value: _selectedMatrixType,
              decoration: const InputDecoration(
                labelText: 'Matrix Type',
                border: OutlineInputBorder(),
              ),
              items: MatrixType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedMatrixType = value;
                  });
                }
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a matrix type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a task name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveTask,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
