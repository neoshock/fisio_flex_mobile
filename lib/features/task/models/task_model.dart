import 'dart:convert';

TaskModel welcomeFromJson(String str) => TaskModel.fromJson(json.decode(str));

String welcomeToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int id;
  String createdAt;
  DateTime dueDate;
  bool isCompleted;
  Task task;

  TaskModel({
    required this.id,
    required this.createdAt,
    required this.dueDate,
    required this.isCompleted,
    required this.task,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        createdAt: json["createdAt"],
        dueDate: DateTime.parse(json["dueDate"]),
        isCompleted: json["isCompleted"],
        task: Task.fromJson(json["task"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "dueDate":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "isCompleted": isCompleted,
        "task": task.toJson(),
      };
}

class Task {
  int id;
  String title;
  String description;
  int estimatedTime;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        estimatedTime: json["estimatedTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "estimatedTime": estimatedTime,
      };
}
