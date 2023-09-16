class TaskLogModel {
  final int taskId;
  final List<TimeEntryModel> entries;

  TaskLogModel(this.taskId, this.entries);

  factory TaskLogModel.fromJson(Map<String, dynamic> json) {
    final taskId = json['taskId'] as int;
    final List<dynamic> entriesJson = json['entries'] as List<dynamic>;
    final entries = entriesJson.map((entryJson) {
      return TimeEntryModel.fromJson(entryJson);
    }).toList();
    return TaskLogModel(taskId, entries);
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
  }
}

class TimeEntryModel {
  final DateTime start;
  final DateTime end;

  TimeEntryModel(this.start, this.end);

  factory TimeEntryModel.fromJson(Map<String, dynamic> json) {
    final start = DateTime.parse(json['start'] as String);
    final end = DateTime.parse(json['end'] as String);
    return TimeEntryModel(start, end);
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }
}
