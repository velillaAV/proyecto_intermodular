import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/screens/PantallaPrincipal.dart';
import 'package:proyecto_intermodular/widgets/Alineacion.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/Clasificacion.dart';
import 'package:proyecto_intermodular/widgets/Predicciones.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class PantallaLigaEspecial extends StatefulWidget {
  const PantallaLigaEspecial({
    super.key,
    required this.liga,
    required this.usuario,
  });

  final Liga liga;
  final Modelousuario usuario;

  @override
  State<PantallaLigaEspecial> createState() => _PantallaLigaEspecialState();
}

class _PantallaLigaEspecialState extends State<PantallaLigaEspecial> {
  int _selectedIndex = 0;
  int _bottomIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else {
      if (index == 1) {
        setState(() {
          _selectedIndex = index - 1;
          _bottomIndex = index;
        });
      }

      if (index == 2) {
        setState(() {
          _selectedIndex = index - 1;
          _bottomIndex = index;
        });
      }

      if (index == 3) {
        setState(() {
          _selectedIndex = index - 1;
          _bottomIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pantallas = [
      Clasificacion(
        liga: widget.liga,
        usuario: widget.usuario,
        actualizar: () {
          setState(() {
            
          });
        },
      ),
      Alineacion(
        usuario: widget.usuario,
        liga: widget.liga,
        actualizar: () {
          setState(() {});
        },
      ),
      Predicciones(
        liga: widget.liga,
        usuario: widget.usuario,
        actualizar: () {
          setState(() {});
        },
      ),
    ];
    Widget pantalla = _pantallas[_selectedIndex];
    widget.liga.nombreLiga.trim().isNotEmpty
        ? widget.liga.nombreLiga
        : 'LIGA FANTASY';

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: pantalla,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
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
