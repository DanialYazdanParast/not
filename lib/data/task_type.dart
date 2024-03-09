
import 'package:hive/hive.dart';
import 'package:not/data/type_enum.dart';
part 'task_type.g.dart';
@HiveType(typeId: 4)
class TaskType {
  TaskType({required this.image,required this.titel,required this.taskTypeEnum});
  @HiveField(0)
  String image;
  @HiveField(1)
  String titel;
  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}


