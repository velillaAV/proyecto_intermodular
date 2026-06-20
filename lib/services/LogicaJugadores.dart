// ignore_for_file: avoid_print

import 'dart:math';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Logicajugadores {

  Future<List<Modelojugador>> getJugadoresByPosicionYLimite(String posicion, int limite) async {
    final mSupaBase = Supabase.instance.client;
    int numRandom = Random().nextInt(20);
    final response = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', posicion.trim()).limit(limite).range(numRandom, numRandom + limite);
    return response
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'] as int,
            nombre: json['nombre'],
            pais: json['pais'],
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion']
          ),
        )
        .toList();
  }

    Future<List<Modelojugador>> getJugadoresByPosicion(String posicion) async {
    final mSupaBase = Supabase.instance.client;
    int numRandom = Random().nextInt(100);
    final response = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', posicion.trim());
    return response
        .map(
          (json) => Modelojugador(
            id_jugador: json['id_jugador'] as int,
            nombre: json['nombre'],
            pais: json['pais'],
            valor_clausula: (json['valor_clausula'] as num).toDouble(),
            valor_venta: (json['valor_venta'] as num).toDouble(),
            posicion: json['posicion']
          ),
        )
        .toList();
  }

   Future<List<Modelojugador>> otorgarEquipo() async {
    final mSupaBase = Supabase.instance.client;
    int numRandom = Random().nextInt(96);
    final porteros = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'POR')
        .range(numRandom, numRandom);
    List<Modelojugador> porterosList;
    List<Modelojugador> defensaList;
    List<Modelojugador> centrocampistasList;
    List<Modelojugador> delanterosList;
    List<Modelojugador> equipo;
    List<Modelojugador> defensaListFinal = [];
    List<Modelojugador> centrocampistasListFinal = [];                                                           
    List<Modelojugador> delanterosListFinal = [];

    porterosList = porteros
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
        defensaList = await getJugadoresByPosicion('DEF');
        centrocampistasList = await getJugadoresByPosicion('CEN');

        delanterosList = await getJugadoresByPosicion('DEL');


        for(int i = 0; i < 5; i++) {
         defensaListFinal.add(defensaList.elementAt(Random().nextInt(defensaList.length)));
        }
        for(int i = 0; i < 4; i++) {
          centrocampistasListFinal.add(centrocampistasList.elementAt(Random().nextInt(centrocampistasList.length)));
        } for(int i = 0; i < 4; i++) {
          delanterosListFinal.add(delanterosList.elementAt(Random().nextInt(delanterosList.length)));
        }
        equipo = porterosList + defensaListFinal + centrocampistasListFinal + delanterosListFinal;
        return equipo;
        
  }

   Future<List<Modelojugador>> rellenarMercado() async {
    final mSupaBase = Supabase.instance.client;
    int numRandom = Random().nextInt(20);
    final porteros = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'POR')
        .range(numRandom, numRandom);
    List<Modelojugador> porterosList;
    List<Modelojugador> defensaList;
    List<Modelojugador> centrocampistasList;
    List<Modelojugador> delanterosList;
    List<Modelojugador> equipo;
   

    porterosList = porteros
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
        defensaList = await getJugadoresByPosicionYLimite('DEF', 5 );
        print('defensas hechos');
        centrocampistasList = await getJugadoresByPosicionYLimite('CEN', 4);

        delanterosList = await getJugadoresByPosicionYLimite('DEL', 4);
        print('delanteros hechos');


      
        equipo = porterosList + defensaList + centrocampistasList + delanterosList;
        return equipo;
        
  }

  Future<List<Modelojugador>> rellenarSelecciones(String pais) async {
    final mSupaBase = Supabase.instance.client;
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
