import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/colors.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaEspecial.dart';
import 'package:proyecto_intermodular/services/LogicaJugadores.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class SeleccionPais extends StatefulWidget {
  const SeleccionPais({super.key, required this.liga});
  final Modeloligaespecial liga;
  @override
  State<SeleccionPais> createState() => _SeleccionPaisState();
}

class _SeleccionPaisState extends State<SeleccionPais> {
  

  bool isPicked = false;
  int indexGeneral = -1;
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/FondoMundial2026.jpg"),
            opacity: 0.2,
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: widget.liga.listaSelecciones.length,
                itemBuilder: (context, index) {
                  final seleccion = widget.liga.listaSelecciones[index];
                  final isSelected = indexGeneral == index;

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: GestureDetector(
                      onTap: seleccion.usuario != null
                          ? null
                          : () {
                              setState(() {
                                indexGeneral = index;
                              });
                            },

                      child: seleccion.usuario == null
                          ? AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colorcetes.selectionColor
                                    : Colorcetes.cardColors,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    seleccion.escudo!,
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          seleccion.nombre!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Opacity(
                              opacity: 0.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colorcetes.cardColors,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      seleccion.escudo!,
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,

                                        children: [
                                          Text(
                                            seleccion.nombre!,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 1),
                                          SizedBox(width: 600),
                                          Flexible(
                                            child: Icon(
                                              Icons.lock,
                                              size: 40,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: indexGeneral == -1
                      ? null
                      : () {
                          widget.liga.listaSelecciones[indexGeneral].usuario =
                              Logicausuario.getUsuarioActual().unirLiga();

                          final seleccion =
                              widget.liga.listaSelecciones[indexGeneral];
                          Logicausuario.getUsuarioActual()
                                  .usuario_ligas
                                  .last
                                  .equipo =
                              seleccion;
                          for (var jugador
                              in Logicausuario.getUsuarioActual()
                                  .usuario_ligas
                                  .last
                                  .equipo
                                  .equipo) {
                            Logicausuario.getUsuarioActual()
                                .usuario_ligas
                                .last
                                .equipo
                                .suplentes
                                .add(jugador);
                          }
                          Logicausuario.getUsuarioActual()
                                  .usuario_ligas
                                  .last
                                  .ligaPerteneciente =
                              widget.liga;
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("País seleccionado"),
                              content: Text("Has elegido ${seleccion.nombre}"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PantallaLigaEspecial(
                                            liga: widget.liga,
                                            usuario:
                                                Logicausuario.getUsuarioActual()
                                                    .usuario_ligas
                                                    .last,
                                          ),
                                    ),
                                  ),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                  child: const Text("Confirmar selección"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
