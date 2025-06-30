import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tasky_pro/features/tasks/domain/entities/task_model.dart';
import 'package:tasky_pro/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:tasky_pro/features/tasks/presentation/cubit/tasks_state.dart';
import 'package:tasky_pro/features/tasks/presentation/pages/tasks_page.dart';

class MockTasksCubit extends Mock implements TasksCubit {}

void main() {
  testWidgets('deve exibir lista de tarefas carregadas', (tester) async {
    final mockCubit = MockTasksCubit();
    final mockTasks = [
      TaskModel(
        id: '1',
        title: 'Verificar Widget',
        isDone: false,
        createdAt: DateTime.now(),
      ),
    ];

    when(() => mockCubit.state).thenReturn(TasksState.loaded(mockTasks));
    whenListen(
      mockCubit,
      Stream.fromIterable([TasksState.loaded(mockTasks)]),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TasksCubit>.value(
          value: mockCubit,
          child: const TasksPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Verificar Widget'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
