import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';
import 'package:proyecto_intermodular/models/ModeloPuja.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/services/LogicaJugadores.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServicioMercadoDiario {
  /// Obtener mercado diario de una liga
  Future<ModeloMercadoDiario> obtenerMercadoHoy(int idLiga) async {
    final mSupaBase = Supabase.instance.client;
    late ModeloMercadoDiario mercadoDiario;
    try {
      final mercado = await mSupaBase
          .from('mercado_diario')
          .select()
          .eq('id_liga', idLiga)
          .order('id_mercado', ascending: false)
          .single();

      // Mapear jugadores desde la lista JSON
      List<Modelojugador> jugadores = (mercado['jugadores_json'] as List)
          .map(
            (jugador) => Modelojugador(
              id_jugador: jugador['id_jugador'],
              nombre: jugador['nombre'],
              pais: jugador['pais'],
              valor_clausula: (jugador['valor_clausula'] as num).toDouble(),
              valor_venta: (jugador['valor_venta'] as num).toDouble(),
              posicion: jugador['posicion'],
            ),
          )
          .toList();

      mercadoDiario = ModeloMercadoDiario(
        idLiga: idLiga,
        fechaActualizacion: DateTime.parse(mercado['fecha_actualizacion']),
        fechaProximoCambio: DateTime.parse(mercado['fecha_proximo_cambio']),
        jugadores: jugadores,
        idMercado: await getCountMercado(),
      );
    } catch (e) {
      if (e is PostgrestException) {
        print('PostgrestException al obtener mercado_diario: ${e.message}');
        print('DETALLES: ${e.details}'); // Aquí suele decir qué campo falla
        print('HINT: ${e.hint}');
      } else {
        print('Error al obtener mercado_diario: $e');
      }
    }
    return mercadoDiario;
  }

  Future<void> insertarMercadoDiario(int idLiga) async {
    final mSupaBase = Supabase.instance.client;
    try {
      final List<Modelojugador> jugadores = await Logicajugadores()
          .otorgarEquipo();
      final List<Map<String, dynamic>> jugadoresJSON = jugadores
          .map((jugador) => jugador.toJson())
          .toList();

      await mSupaBase.from('mercado_diario').insert({
        'id_liga': idLiga,
        'jugadores_json': jugadoresJSON,
        'fecha_proximo_cambio': DateTime.now()
            .add(const Duration(hours: 2))
            .toIso8601String(),
      });
    } catch (e) {
      if (e is PostgrestException) {
        print('Error al insertar mercado_diario: ${e.message}');
        print('DETALLES: ${e.details}'); // Aquí suele decir qué campo falla
        print('HINT: ${e.hint}');
      } else {
        print('Error al insertar mercado_diario: $e');
      }
    }
  }

  Future<void> insertarPuja(
    int id_usuario,
    int id_mercado,
    int id_jugador,
    double puja,
  ) async {
    final mSupaBase = Supabase.instance.client;
    try {
      await mSupaBase.from('pujas_jugador').insert({
        'id_mercado': id_mercado,
        'id_usuario': id_usuario,
        'id_jugador': id_jugador,
        'puja': puja as int,
      });
    } catch (e) {
      print('Error al insertar puja: $e');
    }
  }

  Future<int> resolverPuja(
    int id_mercado,
    int id_jugador,
    int id_liga,
    int jugador_id,
  ) async {
    final mSupaBase = Supabase.instance.client;
    int idUsuario = 0;
    try {
      final idUsuarioJSON = await mSupaBase
          .from('pujas_jugador')
          .select('id_usuario')
          .eq('id_mercado', id_mercado)
          .eq('id_jugador', id_jugador)
          .order('puja', ascending: false)
          .single();
       idUsuario = idUsuarioJSON as int;
      await mSupaBase
          .from('pujas_jugador')
          .delete()
          .eq('id_jugador', id_jugador)
          .eq('id_mercado', id_mercado)
          .eq('id_liga', id_liga);
      final espacio = await mSupaBase
          .from('liga_participantes')
          .select()
          .eq('id_usuario', idUsuario)
          .eq('id_liga', id_liga)
          .single();
      final cont = await mSupaBase
          .from('liga_participantes')
          .select('equipo')
          .eq('id_usuario', idUsuario)
          .eq('id_liga', id_liga)
          .count(CountOption.exact);
      int contExact = cont.count;
      List<dynamic> jugador = espacio['equipo'] ?? {};
      jugador.add(jugador_id);
      await mSupaBase
          .from('liga_participantes')
          .update({'equipo': jugador})
          .eq('id_usuario', idUsuario)
          .eq('id_liga', id_liga);
    } catch (e) {
      print('Error al resolver la puja: $e');
    }
    return idUsuario;
  }

  Future<double> getValorPuja(int id_mercado, int id_jugador, int id_liga) async {
    final mSupaBase = Supabase.instance.client;
    late Modelojugador jugador;
    double puja = 0;
    try {
      final pujaJSON = await mSupaBase
          .from('pujas_jugador')
          .select('puja')
          .eq('id_mercado', id_mercado)
          .eq('id_jugador', id_jugador)
          .order('puja', ascending: false)
          .single();
      puja = (pujaJSON as int).toDouble();
      
    } catch (e) {
      print('Error al obtener valor de la puja: $e');
    }
    return puja;
     
  }

  Future<int> getCountMercado() async {
    final mSupaBase = Supabase.instance.client;

    final cuenta = await mSupaBase
        .from('mercado_diario')
        .select()
        .count(CountOption.exact);
    return cuenta.count;
  }
}
