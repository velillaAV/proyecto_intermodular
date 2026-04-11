import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/widgets/CardJugador.dart';

class Clasificacion extends StatefulWidget {
  const Clasificacion({super.key, required this.liga});
  final Liga liga;
  @override
  State<Clasificacion> createState() => _ClasificacionState();
}

class _ClasificacionState extends State<Clasificacion> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/FondoMundial2026.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.75)),
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
                          horizontal: 16,
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.liga.nombreLiga,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: widget.liga.participantes.isEmpty
                        ? const Center(
                            child: Text('No hay jugadores en la liga'),
                          )
                        : ListView.builder(
                            itemCount: widget.liga.participantes.length,
                            itemBuilder: (context, index) {
                              return CardJugador(
                                jugador: widget.liga.participantes[index],
                                indexPlayer: index,
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}