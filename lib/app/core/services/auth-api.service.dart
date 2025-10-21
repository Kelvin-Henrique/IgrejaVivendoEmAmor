import 'package:iva_app/app/core/services/api.service.dart';

class AuthApiService {
  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await ApiService.post('/auth/login', {
        'email': email,
        'password': password,
      });
      
      return response;
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  // Registro
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await ApiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
      });
      
      return response;
    } catch (e) {
      throw Exception('Erro ao fazer registro: $e');
    }
  }

  // Obter usuário atual
  static Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await ApiService.get('/auth/me');
      return response;
    } catch (e) {
      throw Exception('Erro ao obter dados do usuário: $e');
    }
  }

  // Alterar senha
  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await ApiService.post('/auth/change-password', {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
    } catch (e) {
      throw Exception('Erro ao alterar senha: $e');
    }
  }
}
