import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iva_app/app/core/helpers/helpers.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api'; // Alterar para a URL do servidor em produção
  
  // Headers padrão
  static Future<Map<String, String>> _getHeaders() async {
    final token = await Helpers.getToken();
    return {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  // GET Request
  static Future<dynamic> get(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erro ao fazer requisição GET: $e');
    }
  }

  // POST Request
  static Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erro ao fazer requisição POST: $e');
    }
  }

  // PUT Request
  static Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erro ao fazer requisição PUT: $e');
    }
  }

  // DELETE Request
  static Future<dynamic> delete(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Erro ao fazer requisição DELETE: $e');
    }
  }

  // Manipula a resposta
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      // Token inválido ou expirado
      throw UnauthorizedException('Sessão expirada. Faça login novamente.');
    } else {
      throw ApiException(
        'Erro ${response.statusCode}: ${response.body}',
        response.statusCode,
      );
    }
  }
}

// Exceções customizadas
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => message;
}
