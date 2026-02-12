class Modelojugador {
  final int id_jugador;
  final String nombre;
  final String pais;
  int puntos = 0;
  double valor_venta;
  double valor_clausula;
  List<int> puntos_fase = [];

  Modelojugador({
    required this.id_jugador,
    required this.nombre,
    required this.pais,
    required this.valor_clausula,
    required this.valor_venta,
  });
  void _puntuar(int puntuacion) {
    puntos = puntuacion;
  }

  void _guardarPuntuacion() {
    puntos_fase.add(puntos);
  }

  
}
