import 'package:hive/hive.dart';

part 'task.g.dart'; // to generate HiveAdapter

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  DateTime startTime;

  @HiveField(3)
  DateTime endTime;

  @HiveField(4)
  String description;

  @HiveField(5)
  String category;

  Task({
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.category,
  });
}
