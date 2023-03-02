import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manger_app/model/task_model.dart';

class TaskController extends GetxController {
  Database? _db;
  final int _version = 3;
  String tableName = 'tasks';
  List<Tasks> taskList = <Tasks>[].obs;
  List<Tasks> filteredList = <Tasks>[].obs;
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  Future<void> getDb() async {
    if(_db != null) {
      return ;
    }
    try{
      print('creating Database');
      String path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
          path,
          version: _version,
          onCreate: (Database db, int version) async {
            return await db.execute(
                "CREATE TABLE $tableName("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "title TEXT, note TEXT, date TEXT,"
                    "startTime TEXT, endTime TEXT,"
                    "remind INTEGER, repeat TEXT,"
                    "color INTEGER,"
                    "isCompleted INTEGER"")"

            );
          });
      print('Database successfully created');
    }catch(e) {
      print(e);
    }
  }

  Future<void> addTasks({Tasks? tasks}) async {
     await insertTask(tasks: tasks);
  }

  void updateDate(DateTime newDate) {
    _selectedDate.value = newDate;
    loadTasks();
  }

  Future<void>  deleteTask(int id) async {
    await _db?.delete(tableName, where: 'id = ?', whereArgs: [id]);
    loadTasks();
  }

  Future<void> updateTaskState(int id, int isCompleted) async {
    if(isCompleted == 0) {
      await _db?.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
      ''', [1, id]);
    } else {
      await _db?.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
      ''', [0, id]);
    }
    loadTasks();
  }


  Future<int> insertTask({Tasks? tasks}) async {
    var test = await _db?.insert(tableName, tasks!.toJSON()) ?? 1;
    loadTasks();
    return test;
  }

  void loadTasks() async {
    final tasks = await _db?.query(tableName);
    taskList.assignAll((tasks!.map((data) => Tasks.fromJSON(data)).toList()));
    filteredList.assignAll((taskList.where((task) =>
    task.date == DateFormat.yMd().format(_selectedDate.value)).toList()));
    print('length is ${taskList.length} and filter list length is ${filteredList.length}');
  }

}