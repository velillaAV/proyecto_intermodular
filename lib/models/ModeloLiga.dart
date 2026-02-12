import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/user.dart';

class Modeloliga {


    final int id_liga;
    final int cod_invitacion;
    final User propietario;
    List<User> participantes = [];
    List<Modelojugador> mercado = [];
    

  Modeloliga({required this.id_liga, required this.cod_invitacion, required this.propietario});


  void _insertarPropietario() {
      participantes.add(propietario);
  }

  
}

