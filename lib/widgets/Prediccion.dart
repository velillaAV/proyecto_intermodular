import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/services/LogicaPredicciones.dart';

class Prediccion extends StatefulWidget {
  const Prediccion({
    super.key,
    required this.prediccion,
    required this.usuario,
    required this.actualizar,
    required this.posicion,
  });
  final Modelopredicciones prediccion;
  final Modelousuario usuario;
  final int posicion;
  final void Function() actualizar;
  @override
  State<Prediccion> createState() => _PrediccionState();
}

class _PrediccionState extends State<Prediccion> {
  final TextEditingController _equipoLocalController = TextEditingController();
  final TextEditingController _equipoVisitanteController =
      TextEditingController();
   int  marcadorA = 0;
   int marcadorB = 0;
      Color colorLocal = Colors.grey;
      Color colorVisitante = Colors.grey;
  
  void _updateScore() {
    marcadorA = int.tryParse(_equipoLocalController.text) ?? 0;
    marcadorB = int.tryParse(_equipoVisitanteController.text) ?? 0;
    widget.prediccion.golesLocal = marcadorA;
    widget.prediccion.golesVisitante = marcadorB;
  }

  void _enviarPrediccion() {
    widget.usuario.predicciones.add(widget.prediccion);

    if (marcadorA.compareTo(Logicapredicciones.listaPredicciones
                .elementAt(widget.posicion)
                .golesLocal).isEven
             &&
        marcadorB.compareTo(Logicapredicciones.listaPredicciones
                .elementAt(widget.posicion)
                .golesVisitante).isEven) {
      widget.usuario.puntuar(3);
      colorLocal = Colors.green;
      colorVisitante = Colors.green;
    } else {
      if (marcadorA.compareTo(Logicapredicciones.listaPredicciones
                .elementAt(widget.posicion)
                .golesLocal).isOdd &&
          marcadorB.compareTo(Logicapredicciones.listaPredicciones
                .elementAt(widget.posicion)
                .golesVisitante).isOdd) {
          colorLocal = Colors.red;
          colorVisitante = Colors.red;
      } else {
        if (marcadorA.compareTo(Logicapredicciones.listaPredicciones
                .elementAt(widget.posicion)
                .golesLocal).isEven ||
             marcadorB.compareTo(Logicapredicciones.listaPredicciones
                .elementAt(widget.posicion)
                .golesVisitante).isOdd) {
                 widget.usuario.puntuar(1);
         
                     colorLocal = Colors.green;
                     colorVisitante = Colors.red;
              
                  
                

        }   else  {
                    colorLocal = Colors.red;
                     colorVisitante = Colors.green;
        }
        
       
      }
    }
    widget.actualizar();
  }
   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Equipo A
          Container(
            width: 450,
            color: Colors.grey,
            child: Row(
              children: [
                Image.asset(
                  widget.prediccion.equipoLocal,
                  width: 140,
                  height: 140,
                ),
                Container(
                  width: 60,
                  color: colorLocal,
                  child: TextField(
                    controller: _equipoLocalController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "0"),
                    onChanged: (_) => _updateScore(),
                  ),
                ),
                const SizedBox(width: 20),

                const Text("-", style: TextStyle(fontSize: 20)),

                const SizedBox(width: 20),
                Container(
                  width: 60,
                  color: colorVisitante,
                  child: TextField(
                    controller: _equipoVisitanteController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "0"),
                    onChanged: (_) => _updateScore(),
                  ),
                ),
                Image.asset(
                  widget.prediccion.equipoVisitante,
                  width: 140,
                  height: 140,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _enviarPrediccion,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: const Text("Enviar predicción"),
          ),
        ],
      ),
    );
  }
}
