import 'dart:async';

import '../../domain/entities/task_model.dart';
import '../../domain/repositories/i_task_repository.dart';

class TaskRepository implements ITaskRepository {
  @override
  Future<List<TaskModel>> getTasks() async {
    await Future.delayed(const Duration(seconds: 1)); // simula carregamento
    return [
      TaskModel(
        id: '1',
        title: 'Estudar Flutter',
        description: 'Revisar Clean Architecture',
        isDone: false,
        createdAt: DateTime.now(),
      ),
      TaskModel(
        id: '2',
        title: 'Implementar TaskModel',
        isDone: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}
