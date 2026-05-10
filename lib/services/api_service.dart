import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.56.1:3000';

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

  // LIGAS
  static Future<Map<String, dynamic>?> createLiga(Map<String, dynamic> ligaData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ligas'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(ligaData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> getLigas() async {
    final response = await http.get(Uri.parse('$baseUrl/ligas'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  static Future<Map<String, dynamic>?> generarPartidosAleatorios() async {
    final response = await http.get(Uri.parse('$baseUrl/jugadores/partidos-aleatorios'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}