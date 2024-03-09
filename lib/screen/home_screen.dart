import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:not/widget/task_widget.dart';

import '../data/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
            backgroundColor: Color(0xff18DAA3),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddTaskScreen();
              }));
            },
            child: Image.asset('images/icon_add.png')),
      ),
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notif) {
                  setState(() {
                    if (notif.direction == ScrollDirection.forward) {
                      isFabVisible = true;
                    }
                    if (notif.direction == ScrollDirection.reverse) {
                      isFabVisible = false;
                    }
                  });

                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    return getListItem(task);
                  },
                ),
              );
            }),
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          task.delete();
        },
        child: TaskWidget(task: task));
  }
}
