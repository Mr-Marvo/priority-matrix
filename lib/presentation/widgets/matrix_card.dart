import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/core/theme/app_theme.dart';
import 'package:priority_matrix/presentation/providers/task_providers.dart';
import 'package:priority_matrix/presentation/screens/matrix_detail/matrix_detail_screen.dart';

class MatrixCard extends ConsumerWidget {
  final MatrixType matrixType;

  const MatrixCard({
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

    return tasksAsync.when(
      data: (tasks) {
        // Filter out completed tasks for the count
        final incompleteTasks = tasks.where((task) => !task.isCompleted).toList();

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MatrixDetailScreen(matrixType: matrixType),
              ),
            );
          },
          child: Card(
            color: _getMatrixColor(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getMatrixIcon(),
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    matrixType.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    matrixType.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${incompleteTasks.length} ${incompleteTasks.length == 1 ? 'task' : 'tasks'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Card(
        color: _getMatrixColor(),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
      error: (error, stack) => Card(
        color: _getMatrixColor(),
        child: const Center(
          child: Icon(Icons.error, color: Colors.white),
        ),
      ),
    );
  }
}
