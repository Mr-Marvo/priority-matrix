import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasksByMatrix(MatrixType matrixType);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Stream<List<Task>> watchAllTasks();
  Stream<List<Task>> watchTasksByMatrix(MatrixType matrixType);
}
