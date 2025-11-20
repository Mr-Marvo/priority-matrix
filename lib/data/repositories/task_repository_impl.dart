import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/data/datasources/task_local_datasource.dart';
import 'package:priority_matrix/data/models/task_model.dart';
import 'package:priority_matrix/domain/entities/task.dart';
import 'package:priority_matrix/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> getAllTasks() async {
    final taskModels = await dataSource.getAllTasks();
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Task>> getTasksByMatrix(MatrixType matrixType) async {
    final taskModels = await dataSource.getTasksByMatrix(matrixType);
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await dataSource.addTask(taskModel);
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await dataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    await dataSource.deleteTask(id);
  }

  @override
  Stream<List<Task>> watchAllTasks() {
    return dataSource.watchAllTasks().map(
          (taskModels) => taskModels.map((model) => model.toEntity()).toList(),
        );
  }

  @override
  Stream<List<Task>> watchTasksByMatrix(MatrixType matrixType) {
    return dataSource.watchTasksByMatrix(matrixType).map(
          (taskModels) => taskModels.map((model) => model.toEntity()).toList(),
        );
  }
}
