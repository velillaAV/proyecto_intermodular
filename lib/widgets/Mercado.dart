import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista3.dart';

class Mercado extends StatefulWidget {
  const Mercado({
    super.key,
    required this.usuario,
    required this.liga,
    required this.actualizar,
  });
  final Modelousuario usuario;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<Mercado> createState() => _MercadoState();
}

class _MercadoState extends State<Mercado> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('images/FondoMundial2026.jpg', fit: BoxFit.cover),
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
                      ? const Center(child: Text('No hay futbolistas en el Mercado'))
                      : ListView.builder(
                          itemCount: widget.liga.mercado.length,
                          itemBuilder: (context, index) {
                            widget.actualizar();
                            return CardFutbolista3(
                              usuario: widget.usuario,
                              jugador: widget.liga.mercado[index],
                              actualizar: () {}, liga: widget.liga,
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
