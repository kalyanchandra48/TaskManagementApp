import 'package:hive/hive.dart';
import 'package:task_app/services/hive.dart';

class Global {
  static final Map<BOXNAME, Box> boxes = {
    BOXNAME.TASKSLISTSBOX: HiveInstance.taskListss,
  };
}

enum BOXNAME {
  TASKSLISTSBOX,
}
