import 'package:hive/hive.dart';
import '../../tasks/models/task.dart';

part 'project.g.dart';

@HiveType(typeId: 1)
class Project extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  HiveList<Task>? tasks;

  Project({
    required this.name,
    required this.description,
    required this.date,
    this.tasks,
  });
}
