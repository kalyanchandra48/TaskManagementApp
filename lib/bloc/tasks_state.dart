abstract class TasksState {}

class TasksCreatingState extends TasksState {}

class TasksLoadingState extends TasksState {}

class TasksLoadedState extends TasksState {
  final List<dynamic> tasks;
  TasksLoadedState(this.tasks);
}
