import 'package:flutter/material.dart';
import 'package:task_manger_app/controller/task_controller.dart';
import 'package:task_manger_app/ui/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';
import '../ui/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskController.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              ThemeServices().toggleTheme();
            });
          },
          child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 25,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          const AddTaskBar(),
          const SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryColor,
              selectedTextColor: Colors.white,
              height: 100,
              width: 69,
              dateTextStyle: dateTextStyle,
              dayTextStyle: dayTextStyle,
              monthTextStyle: dayTextStyle,
              onDateChange: (newDate) {
                setState(() {
                  _taskController.updateDate(newDate);
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          _showTaskList()
        ],
      ),
    );
  }
  _showTaskList() {
    return Obx(() {
      if(_taskController.filteredList.isNotEmpty){
        return Expanded(
          child: ListView.builder(itemBuilder: (_, index) {
            final title = _taskController.filteredList[index].title!;
            final note = _taskController.filteredList[index].note!;
            final startTime = _taskController.filteredList[index].startTime!;
            final endTime = _taskController.filteredList[index].endTime!;
            final tileColor = _taskController.filteredList[index].color!;
            final isCompleted = _taskController.filteredList[index].isCompleted!;
            final id = _taskController.filteredList[index].id!;
            return GestureDetector(
                onLongPress: () async {
                  _bottomSheet(isCompleted: isCompleted, id: id);
                },
                child: TaskTile(
                  tileColor: tileColor, isCompleted: isCompleted,
                  title: title, note: note,
                  endTime: endTime, startTime: startTime,
                  onTap: () async => _taskController.updateTaskState(id, isCompleted),
                ),
              );
          },
          physics: const BouncingScrollPhysics(),
          itemCount: _taskController.filteredList.length,
          ),
        );
      }
      else {
        return const SizedBox(
          child: Text('No task today'),
        );
      }
    });
  }

  _bottomSheet({required int isCompleted, required int id}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        color: context.theme.backgroundColor,
        height: isCompleted == 0 ? MediaQuery.of(context).size.height * 0.3 :
        MediaQuery.of(context).size.height * 0.23,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              height: 3.5, width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.7)
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Column(
                children: [
                  isCompleted == 0 ?
                  BottomSheetButton(
                    color: primaryColor,
                    label: 'Task Completed',
                    onTap: () async {
                      await _taskController.updateTaskState(id, isCompleted);
                      Get.back();
                    },
                  ) :
                  const SizedBox(),
                  BottomSheetButton(
                    color: pinkColor,
                    label: 'Delete Task',
                    onTap: () async {
                      await _taskController.deleteTask(id);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            BottomSheetButton(
              label: 'Close',
              onTap: Get.back,
            )
          ],
        ),
      ),
    );
  }
}
