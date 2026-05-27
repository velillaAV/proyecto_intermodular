import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/screens/PantallaInicioSesion.dart';
import 'package:proyecto_intermodular/screens/PantallaPrincipal.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [const Color.fromARGB(255, 6, 58, 231), Colors.red, Colors.green],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Row(
            children: [
              Text("ROAD TO THE WORLD CUP 26 APP", style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
          ListTile(
            title: Text("Pantalla Principal"),
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => PantallaPrincipal()));
            },
          ),
         ListTile(
            title: Text("Cerrar Sesión"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Pantallainiciosesion(),
                ),
              );
            },
          ),

          ListTile(
            title: Text("Salir de la aplicación"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Pantallainiciosesion(),
                  settings: RouteSettings()
                ),
              );
            },
          ),
        ]
      ),
    );
  }
}