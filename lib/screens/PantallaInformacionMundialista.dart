import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/ImageCarousel.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
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
              SizedBox(height: 50),
              Text(
                "Mundiales jugados en USA y/o en México",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 400,
                width: 600,
                child: ImageCarousel(
                  imagePaths: [
                    "images/mexicoMundial70.jpg",
                    "images/mexicoMundial86.jpg",
                    "images/estadosUnidosMundial94.jpg",
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Actuaciones memorables en mundiales",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/maradonaCup.jpg"),
                  ),
                ),
                height: 210,
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
