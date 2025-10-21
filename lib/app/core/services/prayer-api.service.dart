import 'package:iva_app/app/core/services/api.service.dart';

class PrayerRequestApiService {
  // Criar pedido de oração
  static Future<Map<String, dynamic>> createPrayerRequest({
    required String name,
    required String request,
  }) async {
    try {
      final response = await ApiService.post('/prayer-requests', {
        'name': name,
        'request': request,
      });
      
      return response;
    } catch (e) {
      throw Exception('Erro ao criar pedido de oração: $e');
    }
  }

  // Obter meus pedidos de oração
  static Future<List<dynamic>> getMyPrayerRequests() async {
    try {
      final response = await ApiService.get('/prayer-requests/my-requests');
      return response as List<dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar pedidos de oração: $e');
    }
  }

  // Obter pedido por ID
  static Future<Map<String, dynamic>> getPrayerRequestById(String id) async {
    try {
      final response = await ApiService.get('/prayer-requests/$id');
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar pedido: $e');
    }
  }

  // Deletar pedido de oração
  static Future<void> deletePrayerRequest(String id) async {
    try {
      await ApiService.delete('/prayer-requests/$id');
    } catch (e) {
      throw Exception('Erro ao deletar pedido: $e');
    }
  }
}
