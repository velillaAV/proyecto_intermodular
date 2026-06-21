import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';

//Carta que aparece al seleccionar un jugador para la plantilla

class CardFutbolista2 extends StatefulWidget {
  const CardFutbolista2({
    super.key,
    required this.posicion,
    required this.usuario,
    
    required this.jugador,
    required this.actualizar, required this.id_liga,
  });
  final Modelousuario usuario;
  final int posicion;
  final int id_liga;
  final Modelojugador jugador;
  final void Function() actualizar;
  @override
  State<CardFutbolista2> createState() => _CardFutbolista2State();
}

class _CardFutbolista2State extends State<CardFutbolista2> {

   Color colorPosicion = Colors.orange;
  @override
  Widget build(BuildContext context) {
     if(widget.jugador.posicion == "DEF") {
      colorPosicion = Colors.deepPurple;
    } else  {
      if(widget.jugador.posicion == "CEN") {
        colorPosicion = Colors.blue;
      } else  {
        if(widget.jugador.posicion == "DEL") {
          colorPosicion = Colors.green;
        }
      }
    }

    return GestureDetector(
      onTap: () async {
        if (widget.usuario.alineacion.elementAt(widget.posicion) == null) {
       await  Logicaligas.guardarIdAlineacion(widget.posicion, Logicausuario.usuarioActual.id_usuario!, widget.id_liga, widget.jugador.id_jugador);
      await Logicaligas.guardarIdEquipo(widget.usuario.equipo.suplentes.indexOf(widget.jugador), Logicausuario.usuarioActual.id_usuario!, widget.id_liga, 0);
          widget.usuario.alineacion[widget.posicion] = widget.jugador;
          widget.usuario.equipo.suplentes.remove(widget.jugador);
          widget.actualizar();
        } else {
      await  Logicaligas.guardarIdEquipo(widget.usuario.equipo.suplentes.indexOf(widget.jugador), Logicausuario.usuarioActual.id_usuario!, widget.id_liga, widget.usuario.alineacion.elementAt(widget.posicion)!.id_jugador);
       await Logicaligas.guardarIdAlineacion(widget.posicion, Logicausuario.usuarioActual.id_usuario!, widget.id_liga, widget.jugador.id_jugador);
          Modelojugador cambiado = widget.usuario.alineacion.elementAt(
            widget.posicion,
          )!;

          widget.usuario.alineacion[widget.posicion] = widget.jugador;
          widget.usuario.equipo.suplentes.remove(widget.jugador);
          widget.usuario.equipo.suplentes.add(cambiado);
          widget.actualizar();
        }
      },

      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.jugador.isIcono == true
          ? Colors.amber:
              const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 0,
                  height: 0,
                ),
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

                      const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.green,
                        size: 16,
                      ),

                      const SizedBox(width: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Clausula",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            widget.jugador.valor_clausula.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Porcentaje
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
