import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';

class Prediccion extends StatefulWidget {
  const Prediccion({
    super.key,
    required this.prediccion,
    required this.usuario,
    required this.actualizar,
    required this.posicion, required this.id_liga,
  });

  final Modelopredicciones prediccion;
  final Modelousuario usuario;
  final int id_liga;
  final int posicion;
  final void Function() actualizar;

  @override
  State<Prediccion> createState() => _PrediccionState();
}

class _PrediccionState extends State<Prediccion> {
  final TextEditingController _equipoLocalController = TextEditingController();
  final TextEditingController _equipoVisitanteController = TextEditingController();

  int marcadorA = 0;
  int marcadorB = 0;

  Color colorLocal = Colors.grey;
  Color colorVisitante = Colors.grey;

  String cambiarRutaImagen(String rutaImagen) {
    return 'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/$rutaImagen';
  }

  void _updateScore() {
    marcadorA = int.tryParse(_equipoLocalController.text) ?? 0;
    marcadorB = int.tryParse(_equipoVisitanteController.text) ?? 0;
  }

  Future<void> _enviarPrediccion() async {
    widget.prediccion.comprobacion(marcadorA, marcadorB);
    
    if (widget.prediccion.verificarLocal) {
      if (widget.prediccion.verificarVisitante) {
        colorLocal = Colors.green;
        colorVisitante = Colors.green;
        widget.usuario.puntuar(3);
      } else {
        colorLocal = Colors.green;
        colorVisitante = Colors.red;
        widget.usuario.puntuar(1);
      }
    } else {
      if (!widget.prediccion.verificarVisitante) {
        colorLocal = Colors.red;
        colorVisitante = Colors.red;
      } else {
        colorLocal = Colors.red;
        colorVisitante = Colors.green;
        widget.usuario.puntuar(1);
      }
    }
   await Logicaligas.guardarPuntos(widget.usuario.puntos, Logicausuario.getUsuarioActual().id_usuario!, widget.id_liga);
   await  Logicaligas.guardarIdPrediccion(widget.posicion, Logicausuario.getUsuarioActual().id_usuario!, widget.id_liga, widget.prediccion.id_prediccion);
    widget.usuario.predicciones.add(widget.prediccion);
    widget.actualizar();
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = MediaQuery.of(context).size.width * 0.22;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // Imagen local
                Image.network(
                  cambiarRutaImagen(widget.prediccion.equipoLocal),
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                ),

                const SizedBox(width: 10),

                // Marcador local
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: widget.usuario.predicciones.contains(widget.prediccion)
                        ? (widget.prediccion.verificarLocal ? Colors.green : Colors.red)
                        : colorLocal,
                    child: widget.usuario.predicciones.contains(widget.prediccion)
                        ? Center(child: Text(marcadorA.toString(), style: const TextStyle(fontSize: 20)))
                        : TextField(
                            controller: _equipoLocalController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(hintText: "0"),
                            onChanged: (_) => _updateScore(),
                          ),
                  ),
                ),

                const SizedBox(width: 10),
                const Text("-", style: TextStyle(fontSize: 22)),
                const SizedBox(width: 10),

                // Marcador visitante
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: widget.usuario.predicciones.contains(widget.prediccion)
                        ? (widget.prediccion.verificarVisitante ? Colors.green : Colors.red)
                        : colorVisitante,
                    child: widget.usuario.predicciones.contains(widget.prediccion)
                        ? Center(child: Text(marcadorB.toString(), style: const TextStyle(fontSize: 20)))
                        : TextField(
                            controller: _equipoVisitanteController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(hintText: "0"),
                            onChanged: (_) => _updateScore(),
                          ),
                  ),
                ),

                const SizedBox(width: 10),

                // Imagen visitante
                Image.network(
                  cambiarRutaImagen(widget.prediccion.equipoVisitante),
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          if (!widget.usuario.predicciones.contains(widget.prediccion))
            ElevatedButton(
              onPressed:  _enviarPrediccion,
              child: const Text("Enviar predicción"),
            ),
        ],
      ),
    );
  }
}