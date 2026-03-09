import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/screens/EleccionLiga.dart';
import 'package:proyecto_intermodular/screens/PantallaInformacionMundialista.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  void _elegirLiga() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Eleccionliga()),
    );
  }

  void _informacionMundialista() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Pantallainformacionmundialista(),
      ),
    );
  }

  late String nombreUser = Logicausuario.getUsuarioActual().getNombre();
  @override
  Widget build(BuildContext context) {
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
              "images/FondoMundial2026.jpg",
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.2),
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Bienvenido a la Road to the FIFA World Cup 26 App, $nombreUser',
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "LIGAS FANTASY",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 70,
                      width: 200,
                      color: Colors.grey,
                      child: TextButton(
                        onPressed: _elegirLiga,
                        child: Text(
                          "CREAR LIGA",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 70,
                      width: 200,
                      color: Colors.grey,
                      child: TextButton(
                        onPressed: _elegirLiga,
                        child: Text(
                          "UNIRSE A LIGA",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 70,
                      width: 200,
                      color: Colors.grey,
                      child: TextButton(
                        onPressed: _elegirLiga,
                        child: Text(
                          "TUS LIGAS",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "INFORMACIÓN",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 70,
                      width: 250,
                      color: Colors.grey,
                      child: TextButton(
                        onPressed: _informacionMundialista,
                        child: Text(
                          "INFORMACIÓN MUNDIALISTA",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
