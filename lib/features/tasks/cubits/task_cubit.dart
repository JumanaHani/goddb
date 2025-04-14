import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../globals.dart';
import '../../home/models/project.dart';
import '../models/task.dart';
import 'task_state.dart'; // make sure you import your custom state

enum TaskFilter { myTask, inProgress, completed }

class TaskCubit extends Cubit<TaskState> {
  final Box<Task> taskBox;
  TaskFilter _filter = TaskFilter.myTask;

  TaskCubit(this.taskBox) : super(TaskInitial());

  // void _loadTasks() {
  //   final tasks = selectedProject?.tasks?.toList() ?? [];
  //   emit(TaskLoaded(tasks));
  //   // final tasks = taskBox.values.toList();
  //   // emit(TaskLoaded(tasks));
  // }

  void loadTasks() {
    final tasks = selectedProject?.tasks?.toList() ?? [];

    // Filter tasks based on the selected filter
    List<Task> filteredTasks = [];

    // Apply the filter logic based on the selected filter
    switch (_filter) {
      case TaskFilter.myTask:
        filteredTasks = tasks;
        break;
      case TaskFilter.inProgress:
        filteredTasks = tasks.where((task) {
          final now = DateTime.now();
        bool isprog=  task.startTime.isBefore(now) && task.endTime.isAfter(now);
          return isprog;
        }).toList();
        break;
      case TaskFilter.completed:
        filteredTasks = tasks.where((task) {
          final now = DateTime.now();
          return task.endTime.isBefore(now);
        }).toList();
        break;
    }

    emit(TaskLoaded(filteredTasks,_filter));
  }

  // Method to set the current filter
  void setFilter(TaskFilter filter) {
    _filter = filter;
    loadTasks(); // Reload tasks with the new filter
  }

  // Project? get selectedProject => _selectedProject;
  //
  void selectProject(Project project) {
    selectedProject = project;
    loadTasks(); // Automatically load tasks when project changes
  }

  Future<void> saveTask(Task task) async {
    // Add task to the Hive box
    taskBox.add(task);

    // Initialize tasks list if it's null
    selectedProject!.tasks ??= HiveList(taskBox);

    // Add the new task to the project
    selectedProject!.tasks!.add(task);

    // Save the updated project
    await selectedProject!.save();

    // Emit updated task list
    emit(TaskLoaded(selectedProject!.tasks!.toList(),_filter));
  }
}
