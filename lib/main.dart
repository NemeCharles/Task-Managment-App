import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_manger_app/controller/task_controller.dart';
import 'package:task_manger_app/screens/home_screen.dart';
import 'package:task_manger_app/ui/theme.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  TaskController taskController = Get.put(TaskController());
  await taskController.getDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightMode,
      darkTheme: Themes.darkMode,
      themeMode: ThemeServices().theme,
      home: const HomeScreen()
    );
  }
}
