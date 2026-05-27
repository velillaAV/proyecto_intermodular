import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/models/user.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/EquipoJugador.dart';

class CardJugador extends StatefulWidget {
  const CardJugador({super.key, required this.jugador, required this.indexPlayer, required this.usuario, required this.liga, required this.actualizar, });
  final User jugador;
  final Modelousuario usuario;
  final int indexPlayer;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<CardJugador> createState() => _CardJugadorState();
}

class _CardJugadorState extends State<CardJugador> {
  
  @override
  Widget build(BuildContext context) {
    final esUsuarioActual =
        widget.jugador.getNombre() == Logicausuario.getUsuarioActual().getNombre();
    return GestureDetector(
      onTap: () {
        final usuarioLiga = widget.jugador.usuario_ligas.firstWhere(
          (ligaUsuario) => ligaUsuario.ligaPerteneciente == widget.liga,
          orElse: () => Modelousuario()..ligaPerteneciente = widget.liga,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EquipoJugador(usuario: usuarioLiga, liga: widget.liga, actualizar:widget.actualizar),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: esUsuarioActual
            ? Colors.blue.shade100
            : Colors.white.withOpacity(0.92),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue.shade900,
                child: Text(
                  '${widget.indexPlayer + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.jugador.getNombre(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      esUsuarioActual ? 'Tú' : 'Jugador',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
               Text(
                widget.jugador.usuario_ligas.isNotEmpty ? widget.jugador.usuario_ligas.last.puntos.toString() : '0',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  }
}