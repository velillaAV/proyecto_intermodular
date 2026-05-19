import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:proyecto_intermodular/models/ModeloJugador.dart';

class Logicajugadores {
  // Cambia 'localhost' por tu IP para móvil, ej: '192.168.1.100'
  final String baseUrl = 'http://localhost:3000'; // Para móvil: 'http://TU_IP:3000'

  Future<List<Modelojugador>> getJugadoresByPosicion(String posicion) async {
    final response = await http.get(
      Uri.parse('$baseUrl/jugadores/posicion/$posicion'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map(
            (json) => Modelojugador(
              id_jugador: json['id_jugador'],
              nombre: json['nombre'],
              pais: _convertirRutaImagen(json['pais']),
              valor_clausula: (json['valor_clausula'] as num).toDouble(),
              valor_venta: (json['valor_venta'] as num).toDouble(),
              posicion: json['posicion'],
            ),
          )
          .toList();
    } else {
      throw Exception('Failed to load players');
    }
  }

  Future<List<Modelojugador>> otorgarEquipo() async {
    final response = await http.get(
      Uri.parse('$baseUrl/jugadores/generar-equipo'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to generate team: ${response.statusCode}');
    }

    final data = json.decode(response.body);
    return (data as List)
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'],
            nombre: json['nombre'],
            pais: _convertirRutaImagen(json['pais']),
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
  }

  Future<List<Modelojugador>> rellenarSelecciones(String pais) async {
    final response = await http.get(Uri.parse('$baseUrl/jugadores/pais/${Uri.encodeComponent(pais)}'));

    if (response.statusCode != 200) {
      print("error");
      print(response.statusCode);
      throw Exception('Error: ${response.statusCode}');
    }
    
    final data = json.decode(response.body);

    return (data as List)
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'],
            nombre: json['nombre'],
            pais: _convertirRutaImagen(json['pais']),
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
  }

  /// Convertir rutas de imágenes locales a URLs del servidor
  String _convertirRutaImagen(String ruta) {
    if (ruta.startsWith('http')) {
      return ruta; // Ya es una URL completa
    }
    if (ruta.startsWith('images/')) {
      return '$baseUrl/assets/$ruta'; // Convertir a URL del servidor
    }
    return '$baseUrl/assets/images/$ruta'; // Por si no tiene el prefijo
  }
}
