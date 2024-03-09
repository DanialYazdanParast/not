import 'package:hive_flutter/hive_flutter.dart';
import 'package:not/data/task_type.dart';


part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  Task(
      {required this.titel,
      required this.subTitel,
      this.isDone = false,
      required this.time ,required this.taskType});
  @HiveField(0)
  String titel;
  @HiveField(1)
  String subTitel;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  TaskType taskType;
}
