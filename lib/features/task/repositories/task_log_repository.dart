import 'dart:convert';

import 'package:fisioflex_mobile/features/task/models/task_log_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskLogRepository {
  final String _taskLogKey = 'task_log';

  // Método para guardar un objeto TaskLog en Shared Preferences.
  Future<void> saveTaskLog(TaskLogModel taskLog) async {
    final prefs = await SharedPreferences.getInstance();
    final taskLogJson = prefs.getString(_taskLogKey);

    TaskLogModel existingTaskLog = TaskLogModel(0, []);

    if (taskLogJson != null) {
      // Si ya existe un JSON en SharedPreferences, decodifícalo en un objeto TaskLogModel.
      existingTaskLog = TaskLogModel.fromJson(json.decode(taskLogJson));
    }

    // Agrega el nuevo elemento a la lista de entradas.
    existingTaskLog.entries.add(taskLog.entries[
        0]); // Supongo que solo agregas una entrada a la vez, ajusta según tus necesidades.

    // Convierte el objeto TaskLogModel actualizado en JSON.
    final updatedTaskLogJson = json.encode(existingTaskLog.toJson());

    // Guarda el JSON actualizado en SharedPreferences.
    await prefs.setString(_taskLogKey, updatedTaskLogJson);
  }

  // Método para obtener un objeto TaskLog de Shared Preferences.
  Future<TaskLogModel?> getTaskLog() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final taskLogJson = prefs.getString(_taskLogKey);
      if (taskLogJson != null) {
        final Map<String, dynamic> taskLogMap = json.decode(taskLogJson);
        return TaskLogModel.fromJson(taskLogMap);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Método para borrar el objeto TaskLog de Shared Preferences.
  Future<void> removeTaskLog() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_taskLogKey);
  }

  Future<double?> getAverageExerciseHoursByDate(DateTime date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final taskLogJson = prefs.getString(_taskLogKey);
      if (taskLogJson != null) {
        double totalHours = 0;
        int countEntries = 0; // Llevar un conteo de las entradas encontradas
        final TaskLogModel taskLog =
            TaskLogModel.fromJson(json.decode(taskLogJson));
        // Filtrar por fecha
        taskLog.entries.forEach((element) {
          if (element.start.toLocal().day == date.toLocal().day) {
            totalHours += element.start
                .difference(element.end)
                .inSeconds
                .abs()
                .toDouble();
            countEntries++;
          }
        });
        // Calcular el promedio solo si se encontraron entradas para esa fecha
        if (countEntries > 0) {
          return totalHours / (60 * countEntries);
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
