import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/screens/LigaNormal.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';


class Eleccionliga extends StatefulWidget {
  const Eleccionliga({super.key});

  @override
  State<Eleccionliga> createState() => _EleccionligaState();
}

class _EleccionligaState extends State<Eleccionliga> {
  void _ligaNormal(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Liganormal(),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/FondoMundial2026.png"),
            opacity: 0.2,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text("ELIGE TIPO", style: TextStyle(fontSize: 80)),
              Container(
                height: 150,
                width: 350,
                color: Colors.grey,
                child: TextButton(
                  onPressed: _ligaNormal,
                  child: Text(
                    "LIGA NORMAL",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 150,
                width: 350,
                color: Colors.grey,
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    "LIGA ESPECIAL",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
