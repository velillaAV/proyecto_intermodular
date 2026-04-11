class Modelojugador {
  final int id_jugador;
  final String nombre;
  final String posicion;
  final String pais;
  int puntos = 0;
  double valor_venta;
  double valor_clausula;
  List<int> puntos_fase = [];
  final String fotoRutaJugador;

  Modelojugador({
    required this.id_jugador,
    required this.nombre,
    required this.pais,
    required this.valor_clausula,
    required this.valor_venta,
    required this.fotoRutaJugador,
    required this.posicion,
  });
  void _puntuar(int puntuacion) {
    puntos = puntuacion;
  }

  void _guardarPuntuacion() {
    puntos_fase.add(puntos);
  }
}
