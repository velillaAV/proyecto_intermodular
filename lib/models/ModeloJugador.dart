import 'package:proyecto_intermodular/models/ModeloOferta.dart';
import 'package:proyecto_intermodular/models/ModeloPuja.dart';

class Modelojugador {
  final int id_jugador;
  final String nombre;
  final String posicion;
  final String pais;
  int idPropietario = 0;
  int puntos = 0;
  double valor_venta;
  double valor_clausula;
  List<int> puntos_fase = [];
  List<Puja> pujas = [];
  List<Oferta> oferta = [];
  DateTime fechaFinSubasta = DateTime.now().add(Duration(minutes: 1));

  Modelojugador({
    required this.id_jugador,
    required this.nombre,
    required this.pais,
    required this.valor_clausula,
    required this.valor_venta,
    required this.posicion,
  });
  void puntuar(int puntuacion) {
    puntos = puntuacion;
  }

  void guardarPuntuacion() {
    puntos_fase.add(puntos);
  }

  void aumentarClausula(double suma) {
    valor_clausula += suma;
  }

  void definirValorVenta(double venta) {
    valor_venta += venta;
  }
 
}
