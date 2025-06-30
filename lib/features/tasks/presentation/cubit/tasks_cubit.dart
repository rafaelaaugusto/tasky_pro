import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/services/firebase_service.dart';
import '../../domain/entities/task_model.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GetTasksUseCase getTasksUseCase;
  final _searchController = BehaviorSubject<
      String>(); //Stream que sempre guarda o último valor emitido

  List<TaskModel> _allTasks = [];

  StreamSubscription? _subscription;

  TasksCubit(this.getTasksUseCase) : super(const TasksState.initial()) {
    _subscription = _searchController
        .debounceTime(const Duration(
            milliseconds: 400)) //Espera um tempo de pausa antes de emitir
        .distinct() // 	Só emite valor se for diferente do anterior
        .listen(_filterTasks);
  }

  void loadTasks() async {
    emit(const TasksState.loading());
    try {
      _allTasks = await getTasksUseCase();
      emit(TasksState.loaded(_allTasks));
    } catch (e) {
      emit(const TasksState.error("Erro ao carregar tarefas"));
    }
  }

  void onSearchChanged(String query) {
    _searchController.add(query);
  }

  void _filterTasks(String query) {
    FirebaseService.logEvent(
        name: 'busca_realizada', parameters: {'query': query});

    if (query.isEmpty) {
      emit(TasksState.loaded(_allTasks));
    } else {
      final filtered = _allTasks
          .where((t) => t.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(TasksState.loaded(filtered));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _searchController.close();
    return super.close();
  }
}
