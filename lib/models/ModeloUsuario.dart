import 'package:proyecto_intermodular/models/ModeloEquipo.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';

class Modelousuario {

  Modeloequipo equipo = Modeloequipo(equipo: []);
  double saldo = 100000000;
  List<Modelojugador?> alineacion = [null, null, null, null, null, null, null, null, null, null, null];
  List<Modelopredicciones> predicciones = [];
  int puntos = 0;
  List<int> puntos_fase = [];

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

}

