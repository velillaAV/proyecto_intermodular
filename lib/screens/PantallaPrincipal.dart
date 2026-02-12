import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaEspecial.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}



class _PantallaPrincipalState extends State<PantallaPrincipal> {
  void _ligaEspecial() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const PantallaLigaEspecial()),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/FondoMundial2026.png"),
            opacity: 0.2,
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    'Bienvenido a la Road to the FIFA World Cup 26 App, $nombreUser',
                    style: TextStyle(fontSize: 40),
                  ),

                  SizedBox(height: 100),
                  Text("LIGAS FANTASY"),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey,
                    child: TextButton(
                      onPressed: _ligaEspecial,
                      child: Text("LIGAS ESPECIALES"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
