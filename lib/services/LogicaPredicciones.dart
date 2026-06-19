import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class Logicapredicciones {
  static final listaPredicciones = [
   
  ];

  

  List<Modelopredicciones> prediccionesSegunRondaYUsuario(String fase, Modelousuario usuario) {
    List<Modelopredicciones> listaFase = [];

    for (Modelopredicciones prediccion in Logicapredicciones.listaPredicciones) {
        if(fase == prediccion.fase ) {
          listaFase.add(prediccion);
        }
    }


    return listaFase;
  }
}
