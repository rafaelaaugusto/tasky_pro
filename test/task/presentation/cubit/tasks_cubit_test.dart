import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tasky_pro/features/tasks/domain/entities/task_model.dart';
import 'package:tasky_pro/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:tasky_pro/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:tasky_pro/features/tasks/presentation/cubit/tasks_state.dart';

class MockGetTasksUseCase extends Mock implements GetTasksUseCase {}

void main() {
  late TasksCubit cubit;
  late MockGetTasksUseCase usecase;

  final tasks = [
    TaskModel(
      id: '1',
      title: 'Testar Cubit',
      isDone: false,
      createdAt: DateTime.now(),
    ),
  ];

  setUp(() {
    usecase = MockGetTasksUseCase();
    cubit = TasksCubit(usecase);
  });

  blocTest<TasksCubit, TasksState>(
    'deve emitir [loading, loaded] ao chamar loadTasks',
    build: () {
      when(() => usecase()).thenAnswer((_) async => tasks);
      return cubit;
    },
    act: (c) => c.loadTasks(),
    expect: () => [
      const TasksState.loading(),
      TasksState.loaded(tasks),
    ],
    verify: (_) => verify(() => usecase()).called(1),
  );
}
