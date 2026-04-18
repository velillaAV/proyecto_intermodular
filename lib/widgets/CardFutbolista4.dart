import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
class CardFutbolista4 extends StatefulWidget {
  const CardFutbolista4({super.key, required this.jugador});
  final Modelojugador jugador;
  @override
  State<CardFutbolista4> createState() => _CardFutbolista4State();
}

class _CardFutbolista4State extends State<CardFutbolista4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4)),
        ],
      ),
      child: Stack(
        children: [
          //Puntos

          // Pais
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(widget.jugador.pais, width: 30),
          ),

          // IMAGEN JUGADOR
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Image.asset(
              widget.jugador.fotoRutaJugador,
              height: 90,
              fit: BoxFit.contain,
            ),
          ),

          // NOMBRE Y EQUIPO
          Positioned(
            bottom: 5,
            left: 8,
            right: 8,
            child: Column(
              children: [
                Text(
                  widget.jugador.nombre,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
