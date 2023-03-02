
class Tasks {
  int? id;
  String? title;
  String? note;
  String? date;
  int? isCompleted;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;


  Tasks({
    this.id,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
    this.color,
    this.isCompleted
});

  Tasks.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
    color = json['color'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['color'] = color;
    data['isCompleted'] = isCompleted;

    return data;
  }
}
