import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Logicapredicciones {
  final mSupaBase = Supabase.instance.client;

  Future<List<Modelopredicciones>> prediccionesSegunRondaYUsuario(
    String fase,
  ) async {
    final response = await mSupaBase
        .from('prediccion')
        .select()
        .eq('fase', fase);
    return response
        .map(
          (json) => Modelopredicciones(
            id_prediccion: json['id_prediccion'] as int,
            equipoLocal: json['equipo_local'],
            equipoVisitante: json['equipo_visitante'],
            fase: fase,
            golesLocal: json['goles_local'] as int,
            golesVisitante: json['goles_visitante'] as int,
          ),
        )
        .toList();
  }
}
