import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger_app/screens/add_task_screen.dart';
import 'package:intl/intl.dart';
import 'package:task_manger_app/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key,
    required this.title, required this.hintText,
    this.controller, this.widget}) : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 6,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              )
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller,
                      readOnly: widget == null ? false : true,
                      cursorColor: Colors.grey,
                      cursorHeight: 17,
                      decoration: InputDecoration(
                        hintText: hintText,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                      ),
                    )
                ),
                widget == null ? Container() : Container(child: widget!)
              ],
            ),
          ),
        ],
      )
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    Key? key, this.color, this.onTap, required this.label,
  }) : super(key: key);

  final String label;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 7),
        height: 45,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? Colors.transparent,
            border: color == null ? Border.all(color: Get.isDarkMode ? Colors.white : Colors.black, width: 1) : null
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.tileColor, required this.isCompleted,
    required this.title, required this.note,
    required this.endTime, required this.startTime,
    this.onTap
  }) : super(key: key);

  final int tileColor;
  final int isCompleted;
  final String title;
  final String startTime;
  final String endTime;
  final String note;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: tileColor == 0 ? primaryColor :
          tileColor == 1 ? pinkColor : blueColor,
          borderRadius: BorderRadius.circular(18)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                        Icons.watch_later_outlined, color: Colors.white,
                        size: 20
                    ),
                    Text(
                      '  $startTime - $endTime',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
                Text(
                  note,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
                )
              ],
            ),
          ),
          Container(height: 80, width: 1, color: Colors.white.withOpacity(0.5)),
          GestureDetector(
            onTap: onTap,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                isCompleted == 1 ? 'COMPLETED' : 'TODO',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(
                    fontSize: 20,
                    color: textColor
                ),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Today',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.to(()=> const AddTaskScreen());
            },
            child: TextButton(
              onPressed: null,
              child: const Text(
                '+ Add Task',
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
    );
  }
}
