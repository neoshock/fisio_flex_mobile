import 'package:fisioflex_mobile/core/auth/repositories/auth_repository.dart';
import 'package:fisioflex_mobile/features/task/models/task_model.dart';
import 'package:fisioflex_mobile/features/task/services/task_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<TaskModel>>(
  (_) => TaskNotifier(),
);

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier() : super([]);

  final TaskService _taskService = TaskService();
  final AuthRepository authRepository = AuthRepository();

  int status = 0;

  Future<List<TaskModel>> getTasks() async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final tasks = await _taskService.getTasks(token!);
      if (tasks.statusCode == 200) {
        final List<TaskModel> tasksList = [];
        for (final task in tasks.data['data']) {
          tasksList.add(TaskModel.fromJson(task));
        }
        state = tasksList;
        return tasksList;
      }
    }
    return [];
  }

  setStatus(int index) {
    debugPrint(index.toString());
    status = index;
    state = state;
  }

  Future<List<TaskModel>> getTaskByStatus() async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final tasks = await _taskService.getTaskByStatus(token!, status == 1);
      if (tasks.statusCode == 200) {
        final List<TaskModel> tasksList = [];
        for (final task in tasks.data['data']) {
          tasksList.add(TaskModel.fromJson(task));
        }
        state = tasksList;
        return tasksList;
      }
    }
    return [];
  }
}
