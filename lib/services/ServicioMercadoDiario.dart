
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServicioMercadoDiario {
  /// Obtener mercado diario de una liga
  Future<ModeloMercadoDiario> obtenerMercadoHoy(int idLiga) async {
    final mSupaBase = Supabase.instance.client;
    final mercado = await mSupaBase
    .from('mercado_diario')
    .select()
    .eq('id_liga', idLiga)
    .single();

// Mapear jugadores desde la lista JSON
List<Modelojugador> jugadores = (mercado['jugadores_json'] as List)
    .map((jugador) => Modelojugador(
          id_jugador: jugador['id_jugador'],
          nombre: jugador['nombre'],
          pais: jugador['pais'],
          valor_clausula: (jugador['valor_clausula'] as num).toDouble(),
          valor_venta: (jugador['valor_venta'] as num).toDouble(),
          posicion: jugador['posicion'],
        ))
    .toList();




   
    ModeloMercadoDiario mercadoDiario = ModeloMercadoDiario(
      idLiga: idLiga,
      fechaActualizacion: DateTime.parse(mercado['fecha_actualizacion']),
      fechaProximoCambio: DateTime.parse(mercado['fecha_proximo_cambio']),
      jugadores: jugadores,
    );


    return mercadoDiario;
  }

  /// Obtener URL completa de imagen de jugador
}
