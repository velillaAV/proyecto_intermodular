import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class Modeloequipo {

  final String nombre;
  final List<Modelojugador> equipo;
  final Modelousuario? usuario;
  final String? escudo;
  Modeloequipo({required this.nombre, required this.usuario, required this.equipo, this.escudo});
}