import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaNormal.dart';

class Liganormal extends StatefulWidget {
  const Liganormal({super.key});

  @override
  State<Liganormal> createState() => _LiganormalState();
}

class _LiganormalState extends State<Liganormal> {
  String nombreLiga = "";
  int numParticipantes=0;
  String propietario = "";
  bool clausulas = true;

  void _enviarLiga() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaLigaNormal(ligaNombre: nombreLiga),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Datos de tu liga", style: TextStyle(fontSize: 20),),
            SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de la liga',
                ),
                onChanged: (value){
                  nombreLiga = value;
                },
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número de participantes',
                ),
                onChanged: (value) {
                  numParticipantes=int.tryParse(value) ?? 0;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Cláusulas"),
                Checkbox(
                  value: clausulas,
                  onChanged: (bool? valor) {
                    if (valor == null) return;
                    setState(() {
                      clausulas = valor;
                    });
                  },
                ),
              ],
            ),
            TextButton(
                onPressed: _enviarLiga,
                child: Text("Crear liga")
            )
          ],
        ),
      ),
    );
  }
}
