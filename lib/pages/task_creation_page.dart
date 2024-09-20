import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/bloc/tasks_bloc.dart';
import 'package:task_app/bloc/tasks_event.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/pages/tasks_list_page.dart';
import 'package:task_app/styles/styles.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({super.key});
  final _formKey = GlobalKey<FormState>();
  String? _selectedEmployee;
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final ValueNotifier<bool> isFormValid = ValueNotifier<bool>(false);

  void _updateButtonColor() {
    // Check if all fields are filled
    bool isValid = _taskNameController.text.isNotEmpty &&
        _taskDescriptionController.text.isNotEmpty &&
        selectedEmployee.value.isNotEmpty;

    // Notify listeners (button color will change)
    isFormValid.value = isValid;
  }

  @override
  Widget build(BuildContext context) {
    _taskNameController.addListener(_updateButtonColor);
    _taskDescriptionController.addListener(_updateButtonColor);
    selectedEmployee.addListener(_updateButtonColor);
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: 50,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(0xff252022),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text('Task Assignment',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                onChanged: (value) {
                  _taskNameController.text = value;
                },
                controller: _taskNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  hintText: 'Enter task name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                onChanged: (value) {
                  _taskDescriptionController.text = value;
                },
                controller: _taskDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Task Description',
                  hintText: 'Enter task description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedEmployee,
                  builder: (context, value, child) {
                    return DropdownButton<String>(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 40),
                      value: value.isEmpty ? _selectedEmployee : value,
                      hint: const Text(
                          'Select Employee                                    '),
                      items: ['Kalyan', 'Sai', 'Srinivas']
                          .map((employee) => DropdownMenuItem<String>(
                                value: employee,
                                child: Text(employee,
                                    style: AppTextStyles.subheading),
                              ))
                          .toList(),
                      onChanged: (value) {
                        selectedEmployee.value = value.toString();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: isFormValid,
                builder: (context, isValid, child) {
                  return InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Trigger the task creation event using BLoC or any other logic.
                        BlocProvider.of<TasksBloc>(context).add(
                          AddTask(Task(
                            id: Random().nextInt(1000),
                            taskName: _taskNameController.text,
                            taskDescription: _taskDescriptionController.text,
                            taskCreatedDate: DateTime.now().toString(),
                            assignedTo: selectedEmployee.value,
                          )),
                        );

                        // Show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Task Created Successfully')),
                        );

                        // Clear the form
                        _taskNameController.clear();
                        _taskDescriptionController.clear();
                        selectedEmployee.value = '';
                        Navigator.pop(context);
                      }
                    },
                    // Disable onTap if form is invalid
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isValid
                            ? Colors.blue
                            : Colors
                                .grey, // Change color based on form validity
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Create Task',
                          style: AppTextStyles.subheading.copyWith(
                              color: isValid ? Colors.white : Colors.black54),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
