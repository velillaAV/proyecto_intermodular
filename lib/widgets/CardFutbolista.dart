import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista2.dart';

class CardFutbolista extends StatefulWidget {
  const CardFutbolista({
    super.key,
    required this.usuario,
    required this.posicion,
  });
  final Modelousuario usuario;
  final int posicion;
  @override
  State<CardFutbolista> createState() => _CardFutbolistaState();
}

class _CardFutbolistaState extends State<CardFutbolista> {
  @override
  Widget build(BuildContext context) {
    return widget.usuario.alineacion.elementAt(widget.posicion) == null
        ? GestureDetector(
            onTap: () {
              if (widget.posicion == 0) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text("CAMBIAR JUGADOR"),
                    content: Container(
                      width: 1600,
                      height: 1600,
                      color: const Color.fromARGB(255, 95, 96, 96),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.usuario.equipo.equipo
                                  .where((x) => x.posicion == "POR")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "POR")
                                      .elementAt(index),
                                  actualizar: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                    
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          )
        :GestureDetector(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  //Puntos
                   Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                          widget.usuario.alineacion
                              .elementAt(widget.posicion)!
                              .puntos.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),


                  // Pais
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      widget.usuario.alineacion.elementAt(widget.posicion)!.pais,
                      width: 30,
                    ),
                  ),

                  // IMAGEN JUGADOR
                  Positioned(
                    top: 30,
                    left: 20,
                    right: 20,
                    child: Image.asset(
                      widget.usuario.alineacion
                          .elementAt(widget.posicion)!
                          .fotoRutaJugador,
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
                          widget.usuario.alineacion
                              .elementAt(widget.posicion)!
                              .nombre,
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
            ),
          ); 
  }
}
