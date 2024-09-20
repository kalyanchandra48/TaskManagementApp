import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_app/bloc/tasks_bloc.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/pages/task_creation_page.dart';
import 'package:task_app/services/hive.dart';
import 'package:task_app/styles/styles.dart';

ValueNotifier<String> selectedEmployee = ValueNotifier<String>('');

class TaskListingScreen extends StatelessWidget {
  const TaskListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffbba581), Color(0xffe9e4d9)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Makes the sheet full-screen
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffe1e0d5), Color(0xfff5e7c6)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: BlocProvider(
                      create: (context) => TasksBloc(),
                      child: BottomSheetWidget()),
                );
              },
            );
          },
          child: const Icon(Icons.task),
        ),
        appBar: AppBar(
            elevation: 4,
            title: const Text('Tasks', style: AppTextStyles.heading2)),
        body: ValueListenableBuilder(
          valueListenable: HiveInstance.taskListss.listenable(),
          builder: (context, tasks, child) {
            return tasks.length == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: Image.asset(
                              'assets/no_data.png',
                              width: 300,
                              height: 300,
                            ),
                          ),
                          const Text(
                            'No Tasks Available',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subheading,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Click the task button to add a new task',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.caption
                                .copyWith(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final Task task = tasks.getAt(index) as Task;

                      DateTime date =
                          DateTime.parse(task.taskCreatedDate.toString());
                      // Format to get the full name of the day (e.g., "Tuesday")
                      String dayOfWeek = DateFormat('EEEE').format(date);

                      // Format the time in 12-hour format with AM/PM
                      String time = DateFormat('h:mm a').format(date);
                      String asssignedTo = task.assignedTo.toString();
                      return Card(
                          margin: const EdgeInsets.all(16),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(task.taskName,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: CircleAvatar(
                                        radius: 26,
                                        child: Text(
                                            task.assignedTo![0].toUpperCase(),
                                            style:
                                                const TextStyle(fontSize: 26)),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '$dayOfWeek, $time',
                                  style: AppTextStyles.caption,
                                ),
                                const Divider(),
                                const SizedBox(height: 8),
                                const Text('Description:',
                                    style: AppTextStyles.caption),
                                Text(
                                  task.taskDescription.toString(),
                                  style: AppTextStyles.subheading.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            'Assigned to: ', // First part of the text
                                        style: AppTextStyles.caption,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: asssignedTo, // Bold text
                                            style: AppTextStyles.subheading
                                                .copyWith(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        HiveInstance.deleteTask(index);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  );
          },
        ),
      ),
    );
  }
}
