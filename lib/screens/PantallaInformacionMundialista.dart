import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class Pantallainformacionmundialista extends StatefulWidget {
  const Pantallainformacionmundialista({super.key});

  @override
  State<Pantallainformacionmundialista> createState() =>
      _PantallainformacionmundialistaState();
}

class _PantallainformacionmundialistaState
    extends State<Pantallainformacionmundialista> {
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
      ),
    );
  }
}
