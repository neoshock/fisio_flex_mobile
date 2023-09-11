// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TaskDetailModel welcomeFromJson(String str) =>
    TaskDetailModel.fromJson(json.decode(str));

String welcomeToJson(TaskDetailModel data) => json.encode(data.toJson());

class TaskDetailModel {
  int assignmentId;
  int taskId;
  String title;
  String description;
  int estimatedTime;
  bool isCompleted;
  String createdAt;
  DateTime dueDate;
  List<FileElement> files;

  TaskDetailModel({
    required this.assignmentId,
    required this.taskId,
    required this.title,
    required this.description,
    required this.estimatedTime,
    required this.isCompleted,
    required this.createdAt,
    required this.dueDate,
    required this.files,
  });

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) =>
      TaskDetailModel(
        assignmentId: json["assignmentId"],
        taskId: json["taskId"],
        title: json["title"],
        description: json["description"],
        estimatedTime: json["estimatedTime"],
        isCompleted: json["isCompleted"],
        createdAt: json["createdAt"],
        dueDate: DateTime.parse(json["dueDate"]),
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assignmentId": assignmentId,
        "taskId": taskId,
        "title": title,
        "description": description,
        "estimatedTime": estimatedTime,
        "isCompleted": isCompleted,
        "createdAt": createdAt,
        "dueDate":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

class FileElement {
  int id;
  String url;
  String title;
  String type;

  FileElement({
    required this.id,
    required this.url,
    required this.title,
    required this.type,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        url: json["url"],
        title: json["title"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "title": title,
        "type": type,
      };
}
