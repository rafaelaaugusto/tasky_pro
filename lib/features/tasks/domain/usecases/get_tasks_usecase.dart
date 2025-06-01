import '../entities/task_model.dart';
import '../repositories/i_task_repository.dart';

class GetTasksUseCase {
  final ITaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<TaskModel>> call() async {
    return await repository.getTasks();
  }
}
