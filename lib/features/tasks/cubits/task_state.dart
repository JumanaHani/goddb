import 'package:equatable/equatable.dart';
import 'package:goddb_task/features/tasks/cubits/task_cubit.dart';
import '../models/task.dart'; // or wherever your Task model is

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final TaskFilter filter;

  TaskLoaded(this.tasks, this.filter);
 // const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks, filter];
}
