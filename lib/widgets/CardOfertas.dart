import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/models/user.dart';

//Carta de jugador que aparece en el mercado

class CardOfertas extends StatefulWidget {
  const CardOfertas({
    super.key,
    required this.usuario,
    required this.jugador,
    required this.actualizar,
    required this.liga,
    required this.posicion,
  });
  final Modelousuario usuario;
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
    User usuarioOfertador = widget.liga.participantes.singleWhere(
      (user) => user.usuario_ligas.contains(widget.usuario),
    );

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
                          widget.jugador.oferta[widget.posicion].cantidad.toString(),
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

          // Porcentaje
          SizedBox(height: 20),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'aceptar') {
                widget.usuario.sumarSaldo(
                  widget.jugador.oferta[widget.posicion].cantidad,
                );
                widget.jugador.oferta[widget.posicion].usuario.equipo.equipo
                    .add(widget.jugador);
                widget.usuario.equipo.equipo.remove(widget.jugador);
              } else if (value == 'denegar') {
                widget.jugador.oferta[widget.posicion].usuario.sumarSaldo(
                  widget.jugador.oferta[widget.posicion].cantidad,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'aceptar', child: Text('Aceptar')),
              PopupMenuItem(value: 'denegar', child: Text('Denegar')),
            ],
            child: ElevatedButton(
              onPressed:
                  null, // Se deja en null porque lo maneja el PopMenuButton
              child: Text("Acciones"),
            ),
          ),
        ],
      ),
    );
  }
}
