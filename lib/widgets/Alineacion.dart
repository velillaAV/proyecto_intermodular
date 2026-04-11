import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista.dart';

class Alineacion extends StatefulWidget {
  const Alineacion({super.key, required this.usuario, required this.liga});
  final Modelousuario usuario;
  final Liga liga;
  @override
  State<Alineacion> createState() => _AlineacionState();
}

class _AlineacionState extends State<Alineacion> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('images/FondoAlineacion.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.5)),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
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
                    ],
                  ),
                ),
      
                
                Column(
                  children: [
                    CardFutbolista(usuario: widget.usuario, posicion: 0),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardFutbolista(usuario: widget.usuario, posicion: 1),
                        CardFutbolista(usuario: widget.usuario, posicion: 2),
                        CardFutbolista(usuario: widget.usuario, posicion: 3),
                        CardFutbolista(usuario: widget.usuario, posicion: 4),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardFutbolista(usuario: widget.usuario, posicion: 5),
                        CardFutbolista(usuario: widget.usuario, posicion: 6),
                        CardFutbolista(usuario: widget.usuario, posicion: 7),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardFutbolista(usuario: widget.usuario, posicion: 8),
                        CardFutbolista(usuario: widget.usuario, posicion: 9),
                        CardFutbolista(usuario: widget.usuario, posicion: 10),
                      ],
                    ),
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
