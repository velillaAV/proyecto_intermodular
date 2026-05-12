import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_intermodular/config/api_config.dart';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';

class ServicioMercadoDiario {
  final String baseUrl = Config.baseUrl;

  /// Obtener mercado diario de una liga
  Future<ModeloMercadoDiario> obtenerMercadoHoy(int idLiga) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/mercado/$idLiga'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ModeloMercadoDiario.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('Mercado no encontrado para esta liga');
      } else {
        throw Exception('Error al cargar mercado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error conectando con servidor: $e');
    }
  }

  /// Obtener URL completa de imagen de jugador
  String getUrlImagenJugador(String rutaRelativa) {
    // Si ya es una URL completa, retornarla
    if (rutaRelativa.startsWith('http')) {
      return rutaRelativa;
    }
    // Si es una ruta relativa, agregar el baseUrl
    return '$baseUrl$rutaRelativa';
  }
}
