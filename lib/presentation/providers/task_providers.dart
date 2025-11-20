import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/data/datasources/task_local_datasource.dart';
import 'package:priority_matrix/data/repositories/task_repository_impl.dart';
import 'package:priority_matrix/domain/entities/task.dart';
import 'package:priority_matrix/domain/repositories/task_repository.dart';

// Data Source Provider
final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  return TaskLocalDataSource();
});

// Repository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataSource = ref.watch(taskLocalDataSourceProvider);
  return TaskRepositoryImpl(dataSource);
});

// Watch all tasks
final allTasksProvider = StreamProvider<List<Task>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchAllTasks();
});

// Watch tasks by matrix type
final tasksByMatrixProvider =
    StreamProvider.family<List<Task>, MatrixType>((ref, matrixType) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchTasksByMatrix(matrixType);
});

// Task notifier for managing task operations
class TaskNotifier extends StateNotifier<AsyncValue<void>> {
  final TaskRepository repository;

  TaskNotifier(this.repository) : super(const AsyncValue.data(null));

  Future<void> addTask(Task task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.addTask(task);
    });
  }

  Future<void> updateTask(Task task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.updateTask(task);
    });
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updatedTask);
  }

  Future<void> deleteTask(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.deleteTask(id);
    });
  }
}

final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
