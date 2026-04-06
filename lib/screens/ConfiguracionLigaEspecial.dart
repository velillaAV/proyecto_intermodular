

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/screens/SeleccionPaisLigaEspecial.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class ConfiguracionLigaEspecial extends StatefulWidget {
  const ConfiguracionLigaEspecial({super.key});
  

  @override
  State<ConfiguracionLigaEspecial> createState() => _ConfiguracionLigaEspecialState();
}

class _ConfiguracionLigaEspecialState extends State<ConfiguracionLigaEspecial> {
  String nombreLiga = "";
  int numParticipantes=0;
  String propietario = "";
 

  void _enviarLiga() {
    Modeloligaespecial ligaNueva =  Modeloligaespecial(id_liga: Logicaligas.getLigasEspeciales().length + 1, cod_invitacion: Logicaligas.getLigas().length + 1, propietario: Logicausuario.usuarioActual, nombreLiga: nombreLiga);
    Logicaligas.getLigas().add(ligaNueva);
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeleccionPais(liga: ligaNueva,)),
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
