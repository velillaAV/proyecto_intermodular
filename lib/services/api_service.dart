import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_intermodular/config/api_config.dart';

class ApiService {
  static const String baseUrl = Config.baseUrl;

  // REGISTRO
  static Future<bool> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );

    return response.statusCode == 201;
  }

  // LOGIN
  static Future<Map<String, dynamic>?> login(String nombre, String contrasena) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "contrasena": contrasena,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // OBTENER USUARIOS
  static Future<List<dynamic>> getUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}