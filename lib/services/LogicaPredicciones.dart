import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class Logicapredicciones {
  static final listaPredicciones = [
    Modelopredicciones(
      id_prediccion: 1,
      equipoLocal: "images/logoMexico.png",
      equipoVisitante: "images/logoSudafrica.png",
      fase: "Fase de Grupos: Jornada 1",
    ),
    Modelopredicciones(
      id_prediccion: 2,
      equipoLocal: "images/logoCorea.png",
      equipoVisitante: "images/logoChequia.png",
      fase: "Fase de Grupos: Jornada 1",
    ),
    Modelopredicciones(
      id_prediccion: 3,
      equipoLocal: "images/logoMexico.png",
      equipoVisitante: "images/logoCorea.png",
      fase: "Fase de Grupos: Jornada 2",
    ),
    Modelopredicciones(
      id_prediccion: 4,
      equipoLocal: "images/logoSudafrica.png",
      equipoVisitante: "images/logoChequia.png",
      fase: "Fase de Grupos: Jornada 2",
    ),
  ];

  void insertarResultado() {
        Logicapredicciones.listaPredicciones.elementAt(0).golesLocal = 1;
        Logicapredicciones.listaPredicciones.elementAt(0).golesVisitante = 1;
        Logicapredicciones.listaPredicciones.elementAt(1).golesLocal = 1;
        Logicapredicciones.listaPredicciones.elementAt(1).golesVisitante = 3;
        Logicapredicciones.listaPredicciones.elementAt(2).golesLocal = 1;
        Logicapredicciones.listaPredicciones.elementAt(2).golesVisitante = 2;
        Logicapredicciones.listaPredicciones.elementAt(3).golesLocal = 0;
        Logicapredicciones.listaPredicciones.elementAt(3).golesVisitante = 2;
  }

  List<Modelopredicciones> prediccionesSegunRondaYUsuario(String fase, Modelousuario usuario) {
    insertarResultado();
    List<Modelopredicciones> listaFase = [];

    for (Modelopredicciones prediccion in Logicapredicciones.listaPredicciones) {
        if(fase == prediccion.fase ) {
          listaFase.add(prediccion);
        }
    }


    return listaFase;
  }
}
