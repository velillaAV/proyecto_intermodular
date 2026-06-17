import 'package:proyecto_intermodular/models/ModeloEquipo.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/models/liga.dart';

class Modelousuario {
  Modeloequipo equipo = Modeloequipo(equipo: []);
  double saldo = 100000000;
  List<Modelojugador?> alineacion = [null, null, null, null, null, null, null, null, null, null, null];
  List<Modelopredicciones> predicciones = [];
  int puntos = 0;
  List<int> puntos_fase = [];
  late Liga ligaPerteneciente;

  void puntuar(int puntuacion) {
    puntos += puntuacion;
  }

  void guardarPuntuacion() {
    puntos_fase.add(puntos);
  }

  void restarSaldo(double coste) {
    saldo - coste;
  }

  void sumarSaldo(double suma) {
    saldo + suma;
  }

  int orden(String posicion) {
  switch (posicion) {
    case 'POR':
      return 0;
    case 'DEF':
      return 1;
    case 'CEN':
      return 2;
    case 'DEL':
      return 3;
    default:
      return 99;
  }
}


  void ordenarEquipo() {
    equipo.equipo.sort((a, b) => orden(a.posicion).compareTo(orden(b.posicion)));
  }

}

