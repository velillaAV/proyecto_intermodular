import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/services/LogicaPredicciones.dart';
import 'package:proyecto_intermodular/widgets/Prediccion.dart';

class Predicciones extends StatefulWidget {
  const Predicciones({
    super.key,
    required this.liga,
    required this.usuario,
    required this.actualizar,
  });
  final Liga liga;
  final Modelousuario usuario;
  final void Function() actualizar;
  @override
  State<Predicciones> createState() => _PrediccionesState();
}

class _PrediccionesState extends State<Predicciones> {
  @override
  Widget build(BuildContext context) {
    final predicciones = Logicapredicciones().prediccionesSegunRondaYUsuario(
      widget.liga.fase,
      widget.usuario,
    );
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/images/FondoMundial2026.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.white.withValues(alpha: 0.75)),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.liga.fase,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.liga.nombreLiga,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: predicciones.length,
                itemBuilder: (context, index) {
                  return Prediccion(
                    prediccion: predicciones.elementAt(index),
                    usuario: widget.usuario,
                    actualizar: () {
                      setState(() {});
                    },
                    posicion: index,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
