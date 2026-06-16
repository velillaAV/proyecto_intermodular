import 'dart:convert';

import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServicioMercadoDiario {
  /// Obtener mercado diario de una liga
  Future<ModeloMercadoDiario> obtenerMercadoHoy(int idLiga) async {
    final mSupaBase = Supabase.instance.client;

    final jugadoresJson = await mSupaBase.from('mercado_diario').select('jugadores');
    List<Modelojugador> jugadores = jugadoresJson.map(
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



    final mercado = await mSupaBase
        .from('mercado_diario')
        .select()
        .eq('id_liga', idLiga).single();

    ModeloMercadoDiario mercadoDiario = ModeloMercadoDiario(
      idLiga: idLiga,
      fechaActualizacion: mercado['fecha_actualizacion'],
      fechaProximoCambio: mercado['fecha_proximo_cambio'],
      jugadores: jugadores,
    );

    return mercadoDiario;
  }

  /// Obtener URL completa de imagen de jugador
}
