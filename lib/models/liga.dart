

import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/user.dart';

class Liga {


  int id_liga;
  int cod_invitacion;
  User propietario;
  String nombreLiga;
  String  fase = "Fase de Grupos: Jornada 1";
  List<User> participantes = [];
  List<Modelojugador> mercado = [];


  Liga({
    required this.id_liga,
    required this.cod_invitacion,
    required this.propietario,
    required this.nombreLiga,
  });

  void insertarPropietario() {
    participantes.add(propietario);
  }

  int getId_liga(){
    return id_liga;
  }

  int getCod_invitacion(){
    return cod_invitacion;
  }

  User getPropietario(){
    return propietario;
  }

  String getNombreLiga(){
    return nombreLiga;
  }

  List<User> getParticipantes(){
    return participantes;
  }

  List<Modelojugador> getMercado(){
    return mercado;
  }

  void setId_Liga(int id_liga){
    this.id_liga = id_liga;
  }

  void setCod_invitacion(int cod_invitacion){
    this.cod_invitacion = cod_invitacion;
  }

  void setPropietario(User propietario){
    this.propietario = propietario;
  }

  void setNombreLiga(String nombreLiga){
    this.nombreLiga = nombreLiga;
  }

  void setParticipantes(List<User> participantes){
    this.participantes = participantes;
  }

  void setMercado(List<Modelojugador> mercado){
    this.mercado = mercado;
  }

  void avanzarFase(int jornada) {
    if (jornada == 2) {
        fase = "Fase de Grupos: Jornada 2";
    }
    if (jornada == 3) {
        fase = "Fase de Grupos: Jornada 3";
    }
    if (jornada == 4) {
        fase = "Dieciseisavos";
    }
    if (jornada == 5) {
        fase = "Octavos de final";
    }
    if (jornada == 6) {
        fase = "Cuartos de Final";
    }
    if (jornada == 7) {
        fase = "Semifinal";
    }
    if (jornada == 8) {
        fase = "Final";
    }
  }
}