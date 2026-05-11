import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaNormal.dart';
import 'package:proyecto_intermodular/services/LogicaJugadores.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista4.dart';

class PantallaOtorgacionDeEquipo extends StatefulWidget {
  const PantallaOtorgacionDeEquipo({
    super.key,
    required this.usuario,
    required this.liga,
  });
  final Modelousuario usuario;
  final Liga liga;
  @override
  State<PantallaOtorgacionDeEquipo> createState() =>
      _PantallaOtorgacionDeEquipoState();
}

class _PantallaOtorgacionDeEquipoState
    extends State<PantallaOtorgacionDeEquipo> {
  List<Modelojugador> equipoOtorgado = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEquipo();
  }

  Future<void> _loadEquipo() async {
    try {
      List<Modelojugador> equipo = await Logicajugadores().otorgarEquipo();
      setState(() {
        equipoOtorgado = equipo;
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
          child: Appbar(),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (equipoOtorgado.isEmpty) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
          child: Appbar(),
        ),
        body: Center(
          child: Text('Error: No se pudo generar el equipo. Intenta de nuevo.'),
        ),
      );
    }

    double valorEquipo = 0;
    for (int i = 0; i < equipoOtorgado.length; i++) {
      valorEquipo += equipoOtorgado[i].valor_venta;
    }

    void _aceptarEquipo() {
       widget.usuario.equipo.equipo = equipoOtorgado;
      for(var jugador in widget.usuario.equipo.equipo) {
        jugador.idPropietario = widget.liga.participantes.indexOf(Logicausuario.usuarioActual);
        widget.usuario.equipo.suplentes.add(jugador);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PantallaLigaNormal(liga: widget.liga, usuario: widget.usuario),
        ),
      );
    }

    return Scaffold(
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
          ), Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        widget.liga.participantes.last.nombre,
                        style: TextStyle(color: Colors.black, fontSize: 38),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("VALOR EQUIPO", style: TextStyle(color: Colors.black)),
                  SizedBox(height: 5),
                  Text(
                    valorEquipo.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: equipoOtorgado.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // ajusta según la carta
                ),
                itemBuilder: (context, index) {
                  return CardFutbolista4(
                    jugador: equipoOtorgado[index],
                  ); 
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _aceptarEquipo,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text("Aceptar"),
            ),
          ],
        ),
        ]
      ),
    );
  }
}
