import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/task_model.dart';

part 'tasks_state.freezed.dart';

@freezed
class TasksState with _$TasksState {
  const factory TasksState.initial() = _Initial;
  const factory TasksState.loading() = _Loading;
  const factory TasksState.loaded(List<TaskModel> tasks) = _Loaded;
  const factory TasksState.error(String message) = _Error;
}
