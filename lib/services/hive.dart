import 'package:hive_flutter/hive_flutter.dart';

class HiveInstance {
  static late Box _taskLists;

  static initialiseHive() async {
    _taskLists = await Hive.openBox('task_lists');
  }

  static Box get taskListss {
    return _taskLists;
  }

  static deleteTask(int index) {
    HiveInstance._taskLists.deleteAt(index);
  }

  static clearHive() {
    HiveInstance.taskListss.clear();
  }
}
