import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista2.dart';

//Carta que aparece en la alineación de la plantilla

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
              } else if (widget.posicion > 0 && widget.posicion < 5) {
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
                                  .where((x) => x.posicion == "DEF")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "DEF")
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
              } else if (widget.posicion > 4 && widget.posicion < 8) {
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
                                  .where((x) => x.posicion == "CEN")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "CEN")
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
              } else if (widget.posicion > 7 && widget.posicion < 11) {
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
                                  .where((x) => x.posicion == "DEL")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "DEL")
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
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          )
        : GestureDetector(
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
              } else if (widget.posicion > 0 && widget.posicion < 5) {
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
                                  .where((x) => x.posicion == "DEF")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "DEF")
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
              } else if (widget.posicion >= 5 && widget.posicion < 8) {
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
                                  .where((x) => x.posicion == "CEN")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "CEN")
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
              } else if (widget.posicion >= 8 && widget.posicion < 11) {
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
                                  .where((x) => x.posicion == "DEL")
                                  .length,
                              itemBuilder: (context, index) {
                                return CardFutbolista2(
                                  posicion: widget.posicion,
                                  usuario: widget.usuario,
                                  jugador: widget.usuario.equipo.equipo
                                      .where((x) => x.posicion == "DEL")
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
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:  widget.usuario.alineacion
                          .elementAt(widget.posicion)?.isIcono == true

                ? Colors.amber:
                    Colors.black,
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
                          .puntos
                          .toString(),
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
                      widget.usuario.alineacion
                          .elementAt(widget.posicion)!
                          .pais,
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
