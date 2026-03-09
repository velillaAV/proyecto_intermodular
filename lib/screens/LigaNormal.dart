import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class Liganormal extends StatefulWidget {
  const Liganormal({super.key});

  @override
  State<Liganormal> createState() => _LiganormalState();
}

class _LiganormalState extends State<Liganormal> {
  bool esPublica = true;
  String nombreLiga = "";
  String propietario = "";

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
            Text("Datos de tu liga"),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de la liga',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Liga pública"),
                Checkbox(
                  value: esPublica,
                  onChanged: (bool? valor) {
                    if (valor == null) return;
                    setState(() {
                      esPublica = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
