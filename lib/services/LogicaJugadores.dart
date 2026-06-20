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
    int portero = Random().nextInt(96);
    final porteros = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'POR')
        .range(portero, portero);
    final defensas = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'DEF');
    final centrocampistas = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'CEN');
    final delanteros = await mSupaBase
        .from('jugadores')
        .select()
        .eq('posicion', 'DEL');
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
    defensaList = defensas
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
    centrocampistasList = centrocampistas
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
    delanterosList = delanteros
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

    for (int i = 0; i < 5; i++) {
      defensaListFinal.add(
        defensaList.elementAt(Random().nextInt(defensaList.length)),
      );
      while (defensaListFinal.length != defensaListFinal.toSet().length) {
        defensaListFinal.removeWhere(
          (elemento) => elemento.nombre == defensaListFinal.last.nombre,
        );
        defensaListFinal.add(
          defensaList.elementAt(Random().nextInt(defensaList.length)),
        );
      }
    }
    for (int i = 0; i < 4; i++) {
      centrocampistasListFinal.add(
        centrocampistasList.elementAt(
          Random().nextInt(centrocampistasList.length),
        ),
      );
      while (centrocampistasListFinal.length !=
          centrocampistasListFinal.toSet().length) {
        centrocampistasListFinal.removeWhere(
          (elemento) => elemento.nombre == centrocampistasListFinal.last.nombre,
        );
        centrocampistasListFinal.add(
          centrocampistasList.elementAt(
            Random().nextInt(centrocampistasList.length),
          ),
        );
      }
    }
    for (int i = 0; i < 4; i++) {
      delanterosListFinal.add(
        delanterosList.elementAt(Random().nextInt(delanterosList.length)),
      );
      while (delanterosListFinal.length != delanterosListFinal.toSet().length) {
        delanterosListFinal.removeWhere(
          (elemento) => elemento.nombre == delanterosListFinal.last.nombre,
        );
        delanterosListFinal.add(
          delanterosList.elementAt(Random().nextInt(delanterosList.length)),
        );
      }
    }
    equipo =
        porterosList +
        defensaListFinal +
        centrocampistasListFinal +
        delanterosListFinal;
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
