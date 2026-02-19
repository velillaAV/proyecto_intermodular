import 'package:proyecto_intermodular/models/ModeloEquipo.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloLiga.dart';

class Modeloligaespecial extends Modeloliga {

  List<Modeloequipo> equipos = [
    Modeloequipo(nombre: "Mexico", usuario: null, equipo: [Modelojugador(id_jugador: 1, nombre: "Edson Alvarez", pais: "Mexico", valor_clausula: 0, valor_venta: 0)])
  ];
  Modeloligaespecial({
    required super.id_liga,
    required super.cod_invitacion,
    required super.propietario,
  });


}
