import 'package:hive/hive.dart';
import 'package:priority_matrix/core/constants/matrix_type.dart';
import 'package:priority_matrix/domain/entities/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int matrixTypeIndex;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.matrixTypeIndex,
    required this.isCompleted,
    required this.createdAt,
  });

  // Convert to domain entity
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      matrixType: MatrixTypeExtension.fromIndex(matrixTypeIndex),
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
  }

  // Create from domain entity
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      matrixTypeIndex: task.matrixType.index,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
    );
  }
}
