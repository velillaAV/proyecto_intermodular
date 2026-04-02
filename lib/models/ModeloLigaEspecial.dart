import 'package:proyecto_intermodular/models/ModeloEquipo.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloLiga.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/user.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';

class Modeloligaespecial extends Modeloliga {

  final List<Modeloequipo> listaSelecciones = [
    Modeloequipo(nombre: 'México', usuario: Modelousuario(), equipo: [], escudo: 'images/logoMexico.png'),
    Modeloequipo(nombre: 'Sudafrica', usuario: null, equipo: [], escudo: 'images/logoSudafrica.png'),
    Modeloequipo(nombre: 'Corea Del Sur', usuario: null, equipo: [], escudo: 'images/logoCorea.png'),
    Modeloequipo(nombre: 'Republica Checa', usuario: null, equipo: [], escudo: 'images/logoRepublicaCheca.png'),
  ];

  Modeloligaespecial({
    required super.id_liga,
    required super.cod_invitacion,
    required super.propietario,
  });


}
