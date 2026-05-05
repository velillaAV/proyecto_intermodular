class ModeloMercadoDiario {
  final int idLiga;
  final DateTime fechaActualizacion;
  final DateTime fechaProximoCambio;
  final List<JugadorMercado> jugadores;

  ModeloMercadoDiario({
    required this.idLiga,
    required this.fechaActualizacion,
    required this.fechaProximoCambio,
    required this.jugadores,
  });

  // Calcular tiempo restante hasta próxima actualización
  Duration get tiempoRestante {
    final ahora = DateTime.now();
    final diferencia = fechaProximoCambio.difference(ahora);
    return diferencia.isNegative ? Duration.zero : diferencia;
  }

  // Formatear cuenta atrás
  String get cuentaAtrasFormato {
    final duration = tiempoRestante;
    final horas = duration.inHours;
    final minutos = duration.inMinutes.remainder(60);
    final segundos = duration.inSeconds.remainder(60);
    return '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}';
  }

  factory ModeloMercadoDiario.fromJson(Map<String, dynamic> json) {
    return ModeloMercadoDiario(
      idLiga: json['mercado']['id_liga'],
      fechaActualizacion: DateTime.parse(json['mercado']['fecha_actualizacion']),
      fechaProximoCambio: DateTime.parse(json['mercado']['fecha_proximo_cambio']),
      jugadores: (json['jugadores'] as List)
          .map((j) => JugadorMercado.fromJson(j))
          .toList(),
    );
  }
}

class JugadorMercado {
  final int idJugador;
  final String nombre;
  final String posicion;
  final String pais;
  final double valorClausula;
  final double valorVenta;
  final String foto;

  JugadorMercado({
    required this.idJugador,
    required this.nombre,
    required this.posicion,
    required this.pais,
    required this.valorClausula,
    required this.valorVenta,
    required this.foto,
  });

  factory JugadorMercado.fromJson(Map<String, dynamic> json) {
    return JugadorMercado(
      idJugador: json['id_jugador'],
      nombre: json['nombre'],
      posicion: json['posicion'],
      pais: json['pais'],
      valorClausula: (json['valor_clausula'] as num).toDouble(),
      valorVenta: (json['valor_venta'] as num).toDouble(),
      foto: json['foto'],
    );
  }
}
