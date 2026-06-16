import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';

//Carta de jugador que aparece cuando el usuario recibe un equipo en la liga normal

class CardFutbolista4 extends StatefulWidget {
  const CardFutbolista4({super.key, required this.jugador});
  final Modelojugador jugador;
  @override
  State<CardFutbolista4> createState() => _CardFutbolista4State();
}

class _CardFutbolista4State extends State<CardFutbolista4> {
  String cambiarRutaImagen(String rutaImagen) {
    String rutaNueva =
        'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/$rutaImagen';
    return rutaNueva;
  }

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
            child: Image.network(
              cambiarRutaImagen(widget.jugador.pais),
              width: 30,
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
                const SizedBox(height: 4),
                Text(
                  'Valor: ${widget.jugador.valor_venta.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
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
