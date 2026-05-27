import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/models/user.dart';

class CardOfertas extends StatefulWidget {
  const CardOfertas({
    super.key,
    required this.usuario,
    required this.jugador,
    required this.actualizar,
    required this.liga,
    required this.posicion, required this.ofertador,
  });
  final Modelousuario usuario;
  final Modelousuario ofertador;
  final Modelojugador jugador;
  final Liga liga;
  final int posicion;
  final void Function() actualizar;
  @override
  State<CardOfertas> createState() => _CardOfertasState();
}

class _CardOfertasState extends State<CardOfertas> {
  @override
  Widget build(BuildContext context) {
    User usuarioOfertador;
    try {
      usuarioOfertador = widget.liga.participantes.singleWhere(
        (user) => user.usuario_ligas.contains(widget.ofertador),
      );
    } catch (_) {
      usuarioOfertador = User(
        id_usuario: null,
        nombre: 'Desconocido',
        contrasena: '',
        genero: '',
        edad: 0,
        lugarNacimiento: '',
        fotoRuta: null,
        isAdmin: false,
      );
    }

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

          // Nombre del ofertador
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        usuarioOfertador.nombre,
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
                        Text(
                          "Valor venta",
                          style: TextStyle(fontSize: 10, color: Colors.white54),
                        ),
                        Text(
                          widget.jugador.valor_venta.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.jugador.oferta[widget.posicion].cantidad
                              .toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 15),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'aceptar') {
                setState(() {
                   widget.usuario.sumarSaldo(
                  widget.jugador.oferta[widget.posicion].cantidad,
                ); 
                widget.usuario.equipo.equipo.remove(widget.jugador);
                if (widget.usuario.alineacion.contains(widget.jugador)) {
                  int pos = widget.usuario.alineacion.indexOf(widget.jugador);
                  widget.usuario.alineacion.remove(widget.jugador);
                  widget.usuario.alineacion.insert(pos, null);
                }
                if (widget.usuario.equipo.suplentes.contains(widget.jugador)) {
                  widget.usuario.equipo.suplentes.remove(widget.jugador);
                }
                widget.ofertador.equipo.equipo
                    .add(widget.jugador);
                widget.ofertador.equipo.suplentes
                    .add(widget.jugador);   
                     
               
                widget.actualizar();
                Navigator.of(context).pop();
                });
                
               
              } else if (value == 'denegar') {
                widget.jugador.oferta[widget.posicion].usuario.sumarSaldo(
                widget.jugador.oferta[widget.posicion].cantidad);
                Navigator.of(context).pop();
                widget.actualizar();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'aceptar', child: Text('Aceptar')),
              PopupMenuItem(value: 'denegar', child: Text('Denegar')),
            ],
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Acciones", style: TextStyle(color: Colors.black)),
              ),
          ),
        ],
      ),
    );
  }
}
