import 'package:flutter/material.dart';
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
            height: 65,
            color: Colors.red,
            child: DrawerHeader(
              child: Row(
                children: [
                  Icon(Icons.shield_moon),
                  Text("Bayern Fan Page")
                ],
              ),
            ),
          ),
          
          ListTile(
            title: Text("Pantalla Principal"),
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => PantallaPrincipal()));
            },
          ),
        ],
      ),
    );
  }
}