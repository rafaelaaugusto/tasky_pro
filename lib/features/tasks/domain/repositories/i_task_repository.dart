import '../entities/task_model.dart';

abstract class ITaskRepository {
  Future<List<TaskModel>> getTasks();
}
