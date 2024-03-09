import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../utility/utility.dart';
import '../widget/task_type_item.dart';
import 'add_task_screen.dart';


class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController? controllerTaskTitel;
  TextEditingController? controllerSubTaskTitel;
  final box = Hive.box<Task>('taskBox');
  DateTime? _time;
  int selectedTaskTypeitem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controllerTaskTitel = TextEditingController(text: widget.task.titel);
    controllerSubTaskTitel = TextEditingController(text: widget.task.subTitel);

    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
    selectedTaskTypeitem = index;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1000,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 44, right: 44, top: 30, bottom: 25),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitel,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
                      labelStyle: TextStyle(
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                        fontSize: 20,
                      ),
                      labelText: 'عنوان تسک',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xff18DAA3), width: 3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 44, right: 44, top: 30, bottom: 25),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerSubTaskTitel,
                    maxLines: 2,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
                      labelStyle: TextStyle(
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                        fontSize: 20,
                      ),
                      labelText: 'توضیحات تسک',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xff18DAA3), width: 3)),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: 'زمان تسک را انتخاب کن',
                  negativeButtonText: 'حذف کن',
                  positiveButtonText: 'انتخاب زمان',
                  elevation: 2,
                  titleStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  negativeButtonStyle: TextStyle(
                      color: Color.fromARGB(223, 242, 97, 39),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTaskTypeitem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedItemList: selectedTaskTypeitem,
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String taskTitel = controllerTaskTitel!.text;
                  String taskSubTitel = controllerSubTaskTitel!.text;
                  editTask(taskTitel, taskSubTitel);
                  Navigator.pop(context);
                },
                child: Text(
                  'ویرایش کردن تسک',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 48), primary: Color(0xff18DAA3)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  editTask(String taskTitel, String taskSubTitel) {
    //add task

    widget.task.titel = taskTitel;
    widget.task.subTitel = taskSubTitel;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[selectedTaskTypeitem];
    widget.task.save();
  }
}
