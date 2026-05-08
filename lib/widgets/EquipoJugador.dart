import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista5.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista6.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class EquipoJugador extends StatefulWidget {
  const EquipoJugador({
    super.key,
    required this.usuario,
    required this.liga,
    required this.actualizar,
  });
  final Modelousuario usuario;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<EquipoJugador> createState() => _EquipoJugadorState();
}

class _EquipoJugadorState extends State<EquipoJugador> {

  @override
  Widget build(BuildContext context) {
    void estf() {
      setState(() {
        
      });
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: Stack(
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
                    child: ListView.builder(
                      itemCount: widget.usuario.equipo.equipo.length,
                      
                      itemBuilder: (context, index) {
                       
                        widget.actualizar();

                        return widget.liga.runtimeType == Liga
                            ? CardFutbolista5(
                                usuario: widget.usuario,
                                jugador: widget.usuario.equipo.equipo[index],
                                actualizar: widget.actualizar,
                                liga: widget.liga,
                              )
                            : CardFutbolista6(
                                usuario: widget.usuario,
                                jugador: widget.usuario.equipo.equipo[index],
                                actualizar: widget.actualizar,
                                liga: widget.liga,
                                
                              );
                              
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
