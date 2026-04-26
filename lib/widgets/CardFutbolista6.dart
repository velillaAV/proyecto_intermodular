import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/colors.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';

//Carta de jugador que aparece al visualizar la plantilla de un usuario en una Liga Normal

class CardFutbolista6 extends StatefulWidget {
  const CardFutbolista6({
    super.key,
    required this.usuario,
    required this.jugador,
    required this.actualizar,
    required this.liga,
  });
  final Modelousuario usuario;
  final Modelojugador jugador;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<CardFutbolista6> createState() => _CardFutbolista6State();
}

class _CardFutbolista6State extends State<CardFutbolista6> {
  Color colorPosicion = Colorcetes.porteroColor;

 

  @override
  Widget build(BuildContext context) {
    if (widget.jugador.posicion == "DEF") {
      colorPosicion = Colorcetes.defenseColor;
    } else {
      if (widget.jugador.posicion == "CEN") {
        colorPosicion = Colorcetes.centroCampistaColor;
      } else {
        if (widget.jugador.posicion == "DEL") {
          colorPosicion = Colorcetes.delanteroColor;
        }
      }
    }

    widget.liga.comprobarSubastas();
    widget.actualizar();
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white),
        ),

        child: Row(
          children: [
            Stack(
              children: [
                Container(width: 0, height: 0),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            // Info central
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorPosicion,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.jugador.posicion,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.jugador.nombre,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Valor venta",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            widget.jugador.valor_venta.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),

            
          ],
        ),
      );
    
  }
}
