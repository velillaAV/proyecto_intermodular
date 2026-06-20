import 'dart:math';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Logicajugadores {
  final mSupaBase = Supabase.instance.client;

  Future<List<Modelojugador>> getJugadoresByPosicion(String posicion) async {
    final response = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', posicion);
    return response
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'],
            nombre: json['nombre'],
            pais: (json['pais']),
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
  }

  Future<List<Modelojugador>> otorgarEquipo() async {
    int numRandom = Random().nextInt(96);
    late List<Modelojugador> equipo;


    try {
    final porteros = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'POR')
        .range(numRandom, numRandom);
    final defensas = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'DEF').range(numRandom, numRandom + 5);
    final centrocampistas = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'CEN').range(numRandom, numRandom + 4);
    final delanteros = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'DEL').range(numRandom, numRandom + 4);
       
    List<Modelojugador> porterosList;
    List<Modelojugador> defensaList;
    List<Modelojugador> centrocampistasList;
    List<Modelojugador> delanterosList;
   
    porterosList = porteros
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'] as int,
            nombre: json['nombre'],
            pais: json['pais'],
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
        
        defensaList = defensas
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'] as int,
            nombre: json['nombre'],
            pais: json['pais'],
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
        centrocampistasList = centrocampistas
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'] as int,
            nombre: json['nombre'],
            pais: json['pais'],
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
        delanterosList = delanteros
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'] as int,
            nombre: json['nombre'],
            pais: json['pais'],
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();

       
        equipo = porterosList + defensaList + centrocampistasList + delanterosList;
       
    } catch (e) {
  if (e is PostgrestException) {
    print('ERROR AL OBTENER EQUIPO: ${e.message}');
    print('DETALLES: ${e.details}'); // Aquí suele decir qué campo falla
    print('HINT: ${e.hint}');
  } 
  } 
  return equipo;
  }

  Future<List<Modelojugador>> rellenarSelecciones(String pais) async {
    final response = await mSupaBase
        .from('jugadores')
        .select()
        .eq('pais', pais);
    return response
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'],
            nombre: json['nombre'],
            pais: (json['pais']),
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion'],
          ),
        )
        .toList();
  }

  /// Convertir rutas de imágenes locales a URLs del servidor
}
