import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/bloc/tasks_event.dart';
import 'package:task_app/bloc/tasks_state.dart';
import 'package:task_app/services/hive_storage.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksLoadingState()) {
    on<AddTask>((event, emit) {
      emit(TasksLoadingState());
      HiveStorage.saveTask(event.task);
    });
    on<LoadTasks>((event, emit) async {
      emit(TasksLoadingState());
      final tasks = await HiveStorage.getTasks();
      emit(TasksLoadedState(tasks));
    });
  }
}
