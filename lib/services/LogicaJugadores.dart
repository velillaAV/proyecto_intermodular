import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_intermodular/models/ModeloEstadisticas.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/config/api_config.dart';

class Logicajugadores {
  // Ahora usa la configuración centralizada
  final String baseUrl = Config.baseUrl;

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
              valor_clausula: json['valor_clausula'].toDouble(),
              valor_venta: json['valor_venta'].toDouble(),
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
    if (response.statusCode == 500) {
      throw Exception('Failed to generate team');
    }

    final data = json.decode(response.body);
    return (data as List)
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'],
            nombre: json['nombre'],
            pais: _convertirRutaImagen(json['pais']),
            valor_clausula: json['valor_clausula'].toDouble(),
            valor_venta: json['valor_venta'].toDouble(),
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
    print("me voy a volar los sesos");
    
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

 Future<void> sumarPuntos(ModeloEstadisticas stats) async {

  final response = await http.post(
    Uri.parse('$baseUrl/jugadores/puntuar'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(stats.toJson()),
  );

  if (response.statusCode != 200) {
    print("error");
    print(response.body);
    throw Exception('Error: ${response.statusCode}');
  } else {
    print("actualización correcta");
  }
}
Future<int> obtenerPuntosJugador(int idJugador) async {
  final response = await http.get(
    Uri.parse('$baseUrl/jugadores/puntos/$idJugador'),
  );

  if (response.statusCode != 200) {
    print("Error obteniendo puntos");
    print(response.body);

    throw Exception(
      'Error: ${response.statusCode}',
    );

  }


  final data = jsonDecode(response.body);

  return data['puntos'];
}

}
