import 'package:fisioflex_mobile/config/const.dart';
import 'package:fisioflex_mobile/interceptors/http_interceptor_service.dart';
import 'package:dio/dio.dart';

class TaskService {
  final String _baseUrl = APP_API_URL;
  final HttpInterceptor _httpInterceptor = HttpInterceptor();

  Future<Response> getTasks(String token, int idUser) async {
    try {
      _httpInterceptor.addHeaders(
        {'Authorization': "Bearer $token"},
      );
      final dio = _httpInterceptor.dio;
      final response = await dio.get(
        '${_baseUrl}patients/$idUser/tasks',
      );
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': 'Error al obtener las tareas'},
        statusCode: 500,
        statusMessage: 'Error al obtener las tareas',
      );
    }
  }

  //get task by status   'https://fyc.uteq.edu.ec:4001/logged/tasks?status=true'
  Future<Response> getTaskByStatus(String token, bool status) async {
    try {
      _httpInterceptor.addHeaders(
        {'Authorization': "Bearer $token"},
      );
      final dio = _httpInterceptor.dio;
      final response = await dio.get(
        '${_baseUrl}patients/8/tasks?isCompleted=$status',
      );
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': 'Error al obtener las tareas'},
        statusCode: 500,
        statusMessage: 'Error al obtener las tareas',
      );
    }
  }

  //get task by id    https://fyc.uteq.edu.ec:4001/logged/task/:id
  Future<Response> getTaskById(int idTask, String token) async {
    try {
      _httpInterceptor.addHeaders(
        {'Authorization': "Bearer $token"},
      );
      final dio = _httpInterceptor.dio;
      final response = await dio.get(
        '${_baseUrl}assignments/$idTask/task',
      );
      return response;
    } catch (e) {
      print(e.toString());
      return Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': 'Error al obtener las tareas'},
        statusCode: 500,
        statusMessage: 'Error al obtener las tareas',
      );
    }
  }

  //update task
  Future<Response> updateTaskStatus(int idTask, String token) async {
    try {
      _httpInterceptor.addHeaders(
        {'Authorization': "Bearer $token"},
      );
      final dio = _httpInterceptor.dio;
      final response =
          await dio.patch('${_baseUrl}assignments/$idTask/completed');
      return response;
    } catch (e) {
      print(e.toString());
      return Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': 'Error al obtener las tareas'},
        statusCode: 500,
        statusMessage: 'Error al obtener las tareas',
      );
    }
  }
}
