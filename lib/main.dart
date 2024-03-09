import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:not/data/type_enum.dart';

import 'data/task.dart';
import 'data/task_type.dart';
import 'screen/add_task_screen.dart';
import 'screen/home_screen.dart';

void main() async {
  await Hive.initFlutter();
 
 Hive.registerAdapter(TaskTypeAdapter());

    Hive.registerAdapter(TaskTypeEnumAdapter());

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');


  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        fontFamily: 'SM',
      ),
      home: HomeScreen(),
    );
  }
}
