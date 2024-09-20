import 'package:hive/hive.dart';
import 'package:task_app/models/task.dart';

class HiveStorage {
  static saveTask(Task task) async {
    final box = Hive.box('task_lists');
    box.add(task);
  }

  static Future<List<dynamic>> getTasks() async {
    final box = Hive.box('task_lists');
    return box.values.toList();
  }
}
