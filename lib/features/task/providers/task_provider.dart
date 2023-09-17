import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/core/auth/repositories/auth_repository.dart';
import 'package:fisioflex_mobile/core/auth/services/auth_service.dart';
import 'package:fisioflex_mobile/features/task/models/task_detail_model.dart';
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
  final AuthService _authService = AuthService();

  late TaskDetailModel _taskDetailModel;
  TaskDetailModel get taskDetailModel => _taskDetailModel;
  late List<TaskModel> _tasksModel = [];
  List<TaskModel> get tasksModel => _tasksModel;

  Future<List<TaskModel>> getTasks() async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final user = await _authService.getUserByIdentification(token!);
      final tasks =
          await _taskService.getTasks(token!, user.data['data']['id']);
      if (tasks.statusCode == 200) {
        final List<TaskModel> tasksList = [];
        for (final task in tasks.data['data']) {
          tasksList.add(TaskModel.fromJson(task));
          _tasksModel.add(TaskModel.fromJson(task));
        }
        state = tasksList;
        return tasksList;
      }
    }
    return [];
  }

  Future<int> getTotalTaskComplete() async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final user = await _authService.getUserByIdentification(token!);
      final tasks =
          await _taskService.getTasks(token!, user.data['data']['id']);
      if (tasks.statusCode == 200) {
        final List<TaskModel> tasksList = [];
        for (final task in tasks.data['data']) {
          tasksList.add(TaskModel.fromJson(task));
        }
        state = tasksList;
        return tasksList.length;
      }
    }
    return 0;
  }

  Future<List<TaskModel>> getTaskByStatus(bool status) async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final tasks = await _taskService.getTaskByStatus(token!, status);
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

  Future<Response<dynamic>> getTaskById(int idTask) async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final task = await _taskService.getTaskById(idTask, token!);
      if (task.statusCode == 200) {
        _taskDetailModel = TaskDetailModel.fromJson(task.data['data']);
        return Response(
          requestOptions: RequestOptions(path: ''),
          data: TaskDetailModel.fromJson(task.data['data']),
          statusCode: 200,
          statusMessage: 'Tarea obtenida correctamente',
        );
      } else {
        return Response(
          requestOptions: RequestOptions(path: ''),
          data: {'error': 'Error al obtener la tarea'},
          statusCode: 500,
          statusMessage: 'Error al obtener la tarea',
        );
      }
    }
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: {'error': 'Error al obtener la tarea'},
      statusCode: 500,
      statusMessage: 'Error al obtener la tarea',
    );
  }

  Future<Response<dynamic>> updateTask(int idTask) async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      final task = await _taskService.updateTaskStatus(idTask, token!);
      if (task.statusCode == 200) {
        return Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Tarea actualizada correctamente'},
          statusCode: 200,
          statusMessage: 'Tarea actualizada correctamente',
        );
      } else {
        return Response(
          requestOptions: RequestOptions(path: ''),
          data: {'error': 'Hubo un problema al actualizar la tarea'},
          statusCode: 500,
          statusMessage: 'Hubo un problema al actualizar la tarea',
        );
      }
    }
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: {'error': 'Error al actualizar la tarea'},
      statusCode: 500,
      statusMessage: 'Error al actualizar la tarea',
    );
  }
}
