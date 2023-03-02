import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manger_app/controller/task_controller.dart';
import 'package:task_manger_app/model/task_model.dart';
import 'package:task_manger_app/ui/components.dart';
import 'package:task_manger_app/ui/theme.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime date = DateTime.now();
  String startTime = DateFormat.Hm().format(DateTime.now());
  String endTime = DateFormat.Hm().format(DateTime.now());
  List<int> reminderList = [
    5,
    10,
    15,
    20
  ];
  int selectedReminder = 5;
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly'
  ];
  String selectedRepeater = 'None';
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_sharp,
            size: 25,
            color: primaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 13,),
                const Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 23,),
                InputField(hintText: 'Enter your title', title: 'Title', controller: titleController,),
                InputField(title: 'Note', hintText: 'Enter your note', controller: noteController,),
                InputField(
                  title: 'Date', hintText: DateFormat.yMd().format(date),
                  widget: IconButton(
                    onPressed: () {
                      _getCalendar();
                    },
                    icon: const Icon(Icons.calendar_today, color: Colors.grey,),
                  )
                ),
                Row(
                  children: [
                    Expanded(child: InputField(
                        title: 'Start Time', hintText: startTime,
                      widget: IconButton(
                        onPressed: (){
                          _getUserStartTime(isStartTime: true);
                        },
                        icon: const Icon(Icons.watch_later_outlined, color: Colors.grey,),
                      ),
                    )),
                    const SizedBox(width: 7,),
                    Expanded(child: InputField(
                        title: 'End Time', hintText: endTime,
                      widget: IconButton(
                        onPressed: (){
                          _getUserStartTime(isStartTime: false);
                        },
                        icon: const Icon(Icons.watch_later_outlined, color: Colors.grey,),
                      ),
                    ))
                  ],
                ),
                InputField(
                  title: 'Remind', hintText: '$selectedReminder minutes early',
                  widget: DropdownButton(
                    onChanged: (String? value) {
                      setState(() {
                        selectedReminder = int.parse(value!);
                      });
                    },
                    underline: const SizedBox(height: 0),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                    items: reminderList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                          style: TextStyle(color: textColor),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                InputField(
                  title: 'Repeat', hintText: selectedRepeater,
                  widget: DropdownButton(
                    onChanged: (String? value) {
                      setState(() {
                        selectedRepeater = value!;
                      });
                    },
                    underline: const SizedBox(height: 0,),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                    items: repeatList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: textColor),
                        )
                      );
                    }).toList(),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Color',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Wrap(
                            children: List<Widget>.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = index;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 13,
                                    child: selectedColor == index ?
                                        const Icon(Icons.done, color: Colors.white,) :
                                        const SizedBox(),
                                    backgroundColor: index == 0 ? primaryColor : index == 1 ? pinkColor : blueColor,
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _validateText();
                        },
                        child: TextButton(
                          onPressed: null,
                          child: const Text(
                            'Create Task',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                              minimumSize: MaterialStateProperty.all<Size>(const Size(120, 45)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)
                              ))
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
  _validateText() {
    if(titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      _addTask();
      Get.back();
    }else if(titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        'Required', 'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 20,
        backgroundColor: context.theme.backgroundColor,
        colorText: pinkColor
      );
    }
  }
  _addTask() async {
    await _taskController.addTasks(
      tasks: Tasks(
        title: titleController.text,
        note: noteController.text,
        date: DateFormat.yMd().format(date),
        startTime: startTime,
        endTime: endTime,
        color: selectedColor,
        remind: selectedReminder,
        repeat: selectedRepeater,
        isCompleted: 0
      )
    );
  }
  _getCalendar() async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if(_datePicker != null) {
      setState(() {
        date = _datePicker;
      });
    }
  }
  _getUserStartTime({required bool isStartTime}) async {
      var _pickedTime = await showTimePicker(
          initialEntryMode: TimePickerEntryMode.dial,
          context: context,
          initialTime: TimeOfDay.now()
      );

      if(_pickedTime !=null) {
        if(isStartTime == true) {
          setState(() {
            String newStartTime = _pickedTime.format(context);
            startTime = newStartTime;
          });
        } else if(isStartTime == false) {
          setState(() {
            String newEndTime = _pickedTime.format(context);
            endTime = newEndTime;
          });
        }
      }
  }
}