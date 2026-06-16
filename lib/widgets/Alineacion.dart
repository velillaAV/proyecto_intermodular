import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista.dart';

class Alineacion extends StatefulWidget {
  const Alineacion({
    super.key,
    required this.usuario,
    required this.liga,
    required this.actualizar,
  });
  final Modelousuario usuario;
  final Liga liga;
  final void Function() actualizar;
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
            child: Image.network(
              'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/images/FondoAlineacion.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withValues(alpha: 0.5)),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                  ],
                ),
              ),

              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: CardFutbolista(usuario: widget.usuario, posicion: 0),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 1,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 2,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 3,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 4,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 5,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 6,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 7,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 8,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 9,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: CardFutbolista(
                          usuario: widget.usuario,
                          posicion: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 150),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
