import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class Logicajugadores {
  final String baseUrl = 'http://localhost:3000'; // Cambia según tu IP en móvil

  Future<List<Modelojugador>> getJugadoresByPosicion(String posicion) async {
    final response = await http.get(Uri.parse('$baseUrl/jugadores/posicion/$posicion'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Modelojugador(
        id_jugador: json['id_jugador'],
        nombre: json['nombre'],
        pais: _convertirRutaImagen(json['pais']),
        valor_clausula: json['valor_clausula'].toDouble(),
        valor_venta: json['valor_venta'].toDouble(),
        posicion: json['posicion'],
      )).toList();
    } else {
      throw Exception('Failed to load players');
    }
  }

  Future<List<Modelojugador>> otorgarEquipo() async {
    final response = await http.get(Uri.parse('$baseUrl/jugadores/generar-equipo'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Modelojugador(
        id_jugador: json['id_jugador'],
        nombre: json['nombre'],
        pais: _convertirRutaImagen(json['pais']),
        valor_clausula: json['valor_clausula'].toDouble(),
        valor_venta: json['valor_venta'].toDouble(),
        posicion: json['posicion'],
      )).toList();
    } else {
      throw Exception('Failed to generate team');
    }
  }
   Future<List<Modelojugador>> rellenarSelecciones() async {
    final response = await http.get(Uri.parse('$baseUrl/jugadores/getJugadores'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Modelojugador(
        id_jugador: json['id_jugador'],
        nombre: json['nombre'],
        pais: _convertirRutaImagen(json['pais']),
        valor_clausula: json['valor_clausula'].toDouble(),
        valor_venta: json['valor_venta'].toDouble(),
        posicion: json['posicion'],
      )).toList();
    } else {
      throw Exception('Failed to generate team');
    }
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