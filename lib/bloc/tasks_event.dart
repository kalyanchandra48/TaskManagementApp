import 'package:task_app/models/task.dart';

abstract class TasksEvent {}

class AddTask extends TasksEvent {
  final Task task;
  AddTask(this.task);
}

class LoadTasks extends TasksEvent {}
