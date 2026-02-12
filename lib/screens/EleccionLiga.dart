import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';

class Eleccionliga extends StatefulWidget {
  const Eleccionliga({super.key});

  @override
  State<Eleccionliga> createState() => _EleccionligaState();
}

class _EleccionligaState extends State<Eleccionliga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensiones.paddingAppbar), child: Appbar()),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("ELIGE TIPO", style: TextStyle(fontSize: 80),)
        ],
      ),
    );
  }
}