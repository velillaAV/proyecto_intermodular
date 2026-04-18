import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class Modeloequipo {

  final String? nombre;
  List<Modelojugador> equipo;
  Modelousuario? usuario;
  final String? escudo;
  Modeloequipo({this.nombre, this.usuario, required this.equipo, this.escudo});

  
}