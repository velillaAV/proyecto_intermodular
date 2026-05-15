class ModeloEstadisticas {
  final int id_jugador;
  int goles;
  int asistencias;
  int minutos;
  int tarjetas_amarillas;
  int tarjetas_rojas;
  int? puntos;

  ModeloEstadisticas({
    required this.id_jugador,
    this.goles = 0,
    this.asistencias = 0,
    this.minutos = 0,
    this.tarjetas_amarillas = 0,
    this.tarjetas_rojas = 0,
    this.puntos = 0,
  });

    Map<String, dynamic> toJson() {
    return {
      "id_jugador": id_jugador,
      "goles": goles,
      "asistencias": asistencias,
      "minutos": minutos,
      "tarjetas_amarillas": tarjetas_amarillas,
      "tarjetas_rojas": tarjetas_rojas,
    };
  }
}