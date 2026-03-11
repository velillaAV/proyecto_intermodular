

import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/user.dart';

class Liga {


  int id_liga;
  int cod_invitacion;
  User propietario;
  List<User> participantes = [];
  List<Modelojugador> mercado = [];


  Liga({required this.id_liga, required this.cod_invitacion, required this.propietario});


  void _insertarPropietario() {
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

  void setParticipantes(List<User> participantes){
    this.participantes = participantes;
  }

  void setMercado(List<Modelojugador> mercado){
    this.mercado = mercado;
  }
}