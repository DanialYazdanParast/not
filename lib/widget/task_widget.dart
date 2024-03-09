import 'package:flutter/material.dart';



import '../data/task.dart';
import '../screen/edit_task_screen.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getMainTitel();
  }

  Widget getMainTitel() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          value: isBoxChecked, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                            ),
                          checkColor: Colors.white,
                          activeColor: Color(0xff18DAA3),
                          onChanged: (isCheched) {}),
                      ),
                      
                      Text(
                        widget.task.titel,
                       overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                    Text(widget.task.subTitel, overflow: TextOverflow.ellipsis),
                    Spacer(),
                    getTimeAndEdit(),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset(widget.task.taskType.image),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeAndEdit() {
    return Row(
      children: [
        Container(
          width: 95,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  '${widget.task.time.hour}:${getMin(widget.task.time)}',
                  style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return EditTaskScreen(
                task: widget.task,
              );
            }));
          },
          child: Container(
            width: 95,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      color: Color(0xff18DAA3),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset('images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
   String getMin(DateTime time) {
    
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
