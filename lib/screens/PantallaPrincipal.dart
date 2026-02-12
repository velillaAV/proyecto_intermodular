import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/screens/EleccionLiga.dart';
import 'package:proyecto_intermodular/screens/PantallaCrearLiga.dart';
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

  void _elegirLiga(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const Eleccionliga())
    );
  }

  

void _informacionMundialista() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Pantallainformacionmundialista()),
  );
}


  late String nombreUser = Logicausuario.getUsuarioActual().getNombre();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensiones.paddingAppbar), child: Appbar()),
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
                    height: 100,
                    width: 200,
                    color: const Color.fromARGB(255, 95, 95, 95),
                    child: TextButton(
                      onPressed: _elegirLiga,
                      child: Text("CREAR LIGA"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 70,
                    width: 200,
                    color: Colors.grey,
                    child: TextButton(
                      onPressed: _elegirLiga,
                      child: Text("UNIRSE A LIGA"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 70,
                    width: 200,
                    color: Colors.grey,
                    child: TextButton(
                      onPressed: _elegirLiga,
                      child: Text("TUS LIGAS"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("INFORMACIÓN"),
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    width: 200,
                    color: Colors.grey,
                    child: TextButton(

                      onPressed: _informacionMundialista,

                      child: Text("INFORMACIÓN MUNDIALISTA"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
