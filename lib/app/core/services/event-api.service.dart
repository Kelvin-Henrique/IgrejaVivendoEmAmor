import 'package:iva_app/app/core/services/api.service.dart';

class EventApiService {
  // Obter todos os eventos
  static Future<List<dynamic>> getAllEvents({bool? activeOnly}) async {
    try {
      String endpoint = '/events';
      if (activeOnly == true) {
        endpoint += '?activeOnly=true';
      }
      
      final response = await ApiService.get(endpoint);
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar eventos: $e');
    }
  }

  // Obter agenda semanal
  static Future<List<dynamic>> getWeeklySchedule() async {
    try {
      final response = await ApiService.get('/events/weekly');
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar agenda semanal: $e');
    }
  }

  // Obter eventos por dia da semana
  static Future<List<dynamic>> getEventsByDay(int dayOfWeek) async {
    try {
      final response = await ApiService.get('/events/by-day/$dayOfWeek');
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar eventos do dia: $e');
    }
  }

  // Obter evento por ID
  static Future<Map<String, dynamic>> getEventById(String id) async {
    try {
      final response = await ApiService.get('/events/$id');
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar evento: $e');
    }
  }
}
