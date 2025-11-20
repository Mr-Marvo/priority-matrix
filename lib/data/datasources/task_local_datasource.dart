import 'package:hive_flutter/hive_flutter.dart';
import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/data/models/task_model.dart';

class TaskLocalDataSource {
  static const String _boxName = 'tasks';
  late Box<TaskModel> _taskBox;

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    _taskBox = await Hive.openBox<TaskModel>(_boxName);
  }

  Future<List<TaskModel>> getAllTasks() async {
    return _taskBox.values.toList();
  }

  Future<List<TaskModel>> getTasksByMatrix(MatrixType matrixType) async {
    return _taskBox.values
        .where((task) => task.matrixTypeIndex == matrixType.index)
        .toList();
  }

  Future<void> addTask(TaskModel task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }

  Stream<List<TaskModel>> watchAllTasks() {
    return _taskBox.watch().map((_) => _taskBox.values.toList());
  }

  Stream<List<TaskModel>> watchTasksByMatrix(MatrixType matrixType) {
    return _taskBox.watch().map((_) => _taskBox.values
        .where((task) => task.matrixTypeIndex == matrixType.index)
        .toList());
  }
}
