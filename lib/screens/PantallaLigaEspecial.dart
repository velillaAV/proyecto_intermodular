import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/screens/PantallaPrincipal.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/CardJugador.dart';
import 'package:proyecto_intermodular/widgets/Clasificacion.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';
import 'package:proyecto_intermodular/models/user.dart';
import 'package:proyecto_intermodular/services/logicaUsuarios.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';

class PantallaLigaEspecial extends StatefulWidget {
  const PantallaLigaEspecial({super.key, required this.liga, required this.usuario});
  
  final Liga liga;
  final Modelousuario usuario;

  @override
  State<PantallaLigaEspecial> createState() => _PantallaLigaEspecialState();
}

class _PantallaLigaEspecialState extends State<PantallaLigaEspecial> {
  int _selectedIndex = 0;
  
  
  

  

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
   
  }
  }
  @override
  Widget build(BuildContext context) {

    final List<Widget> _pantallas = [
      Clasificacion(liga: widget.liga)
      
  ];
    Widget pantalla = Clasificacion(liga: widget.liga);
    widget.liga.nombreLiga.trim().isNotEmpty
        ? widget.liga.nombreLiga
        : 'LIGA FANTASY';

    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: pantalla,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Clasificación',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Equipo'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Predicciones',
          ),
        ],
      ),
    );
  }
}
