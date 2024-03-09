
import 'package:not/data/task_type.dart';
import 'package:not/data/type_enum.dart';

List<TaskType>getTaskTypeList(){
  var list =[
    TaskType(image:'images/meditate.png', titel:'تمرکز', taskTypeEnum: TaskTypeEnum.foucs),
    TaskType(image:'images/social_frends.png', titel:'میتینگ', taskTypeEnum: TaskTypeEnum.date),
    TaskType(image:'images/hard_working.png', titel:'کار ', taskTypeEnum: TaskTypeEnum.working),
  ];
  
  return list;
}