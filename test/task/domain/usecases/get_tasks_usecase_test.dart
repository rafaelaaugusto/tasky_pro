import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tasky_pro/features/tasks/data/repositories/task_repository.dart';
import 'package:tasky_pro/features/tasks/domain/entities/task_model.dart';
import 'package:tasky_pro/features/tasks/domain/usecases/get_tasks_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTasksUseCase usecase;
  late MockTaskRepository repository;

  setUp(() {
    repository = MockTaskRepository();
    usecase = GetTasksUseCase(repository);
  });

  test('deve retornar lista de tarefas ao chamar o usecase', () async {
    final mockTasks = [
      TaskModel(
        id: '1',
        title: 'Tarefa Teste',
        isDone: false,
        createdAt: DateTime.now(),
      ),
    ];

    when(() => repository.getTasks()).thenAnswer((_) async => mockTasks);

    final result = await usecase();

    expect(result, equals(mockTasks));
    verify(() => repository.getTasks()).called(1);
  });
}
