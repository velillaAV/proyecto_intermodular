import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

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
   
  }

  void _enviarPrediccion() {
    
    widget.prediccion.comprobacion(marcadorA, marcadorB);
    if(widget.prediccion.verificarLocal == true) {
      if(widget.prediccion.verificarVisitante == true) {
        colorLocal = Colors.green;
        colorVisitante = Colors.green;
        widget.usuario.puntuar(3);
        
      }
      if(widget.prediccion.verificarVisitante == false) {
        colorLocal = Colors.green;
        colorVisitante = Colors.red;
        widget.usuario.puntuar(1);
        
      }
    }    
    if(widget.prediccion.verificarLocal == false) {
      if(widget.prediccion.verificarVisitante == false) {
        colorLocal = Colors.red;
        colorVisitante = Colors.red;
       
        
      } 
       if(widget.prediccion.verificarVisitante == true) {
        colorLocal = Colors.red;
        colorVisitante = Colors.green;
        widget.usuario.puntuar(1);
        
      }
    } 
   
    widget.usuario.predicciones.add(widget.prediccion);
    widget.actualizar();
  }
   
  @override
  Widget build(BuildContext context) {
    return 
    widget.usuario.predicciones.any((element) => element == widget.prediccion,)
    
   ?Padding(
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
                Image.network(
                  widget.prediccion.equipoLocal,
                  width: 140,
                  height: 140,
                ),
                Container(
                  width: 60,
                  color: widget.prediccion.verificarLocal == true
                  ?Colors.green: Colors.red,
                  child: Text(marcadorA.toString()),
                ),
                const SizedBox(width: 20),

                const Text("-", style: TextStyle(fontSize: 20)),

                const SizedBox(width: 20),
                Container(
                  width: 60,
                  color: widget.prediccion.verificarVisitante == true
                  ?Colors.green: Colors.red,
                  child: Text(marcadorB.toString()),
                ),
                Image.network(
                  widget.prediccion.equipoVisitante,
                  width: 140,
                  height: 140,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ): Padding(
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
                Image.network(
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
                Image.network(
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
