import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/screens/EleccionLiga.dart';
import 'package:proyecto_intermodular/screens/PantallaInformacionMundialista.dart';
import 'package:proyecto_intermodular/screens/TusLigas.dart';
import 'package:proyecto_intermodular/screens/UnirseLigaNormal.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('assets/images/FondoMundial2026.jpg'),
      context,
    );
  }

  void _elegirLiga() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Eleccionliga()),
    );
  }

  void _unirseLiga() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UnirseLigaNormal()),
    );
  }

  void _tusLigas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TusLigas()),
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                const Color.fromARGB(255, 6, 58, 231),
                Colors.red,
                Colors.green,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              'ROAD TO THE FIFA WORLD CUP 26 APP',
              style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/FondoMundial2026.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.white.withValues(alpha: 0.75)),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 25,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Bienvenido, $nombreUser",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "Road to the FIFA World Cup 26",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "LIGAS FANTASY",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _elegirLiga,
                      style: CustomStyles.estiloBotonInicioSesion,
                      child: const Text("CREAR LIGA"),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: _unirseLiga,
                      style: CustomStyles.estiloBotonRegistrarse,
                      child: const Text("UNIRSE A UNA LIGA"),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: _tusLigas,
                      style: CustomStyles.estiloBotonRojo,
                      child: const Text("TUS LIGAS"),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "INFORMACIÓN",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: _informacionMundialista,
                      style: CustomStyles.estiloBotonGoogle,
                      child: const Text("INFORMACIÓN MUNDIALISTA"),
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
