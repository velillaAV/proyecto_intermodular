import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
                  title: Row(
            children: [
              SizedBox(width: 10),
              Text('Pantalla Principal (Bayern Fan Page Demo)',
              style:TextStyle(color:Color.fromARGB(255, 240, 240, 240)),
              ),
            ],
          ),
                  backgroundColor: Color.fromARGB(255, 8, 113, 212),
      
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/FondoMundial2026.png"), opacity: 0.2, fit: BoxFit.fill)
          ),
          child: Center(
              child: Column(
            children: [
              
              SizedBox(height: 30,),
              Column(
                children: [
                  Text('Bienvenido a la Bayern Fan Page (Demo), ' + Logicausuario.getListaUsuarios().last.getNombre(), style: TextStyle(fontSize: 40),),
                  SizedBox(height: 20,),
                  Text("Esta pagina solamente es una demo, pero te resumo lo que puedes hacer de momento:", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                  Text("Quizzes", style: TextStyle(fontSize: 20),),
                   SizedBox(height: 20,),
                  Text("Ver resumenes de partidos historicos", style: TextStyle(fontSize: 20),),
                   SizedBox(height: 20,),
                  Text("Ver las leyendas mas representantes ", style: TextStyle(fontSize: 20),),
                   SizedBox(height: 20,),
                  Text("Y tan solo usando el menu de la izquierda", style: TextStyle(fontSize: 25),),
                
                ]
              )
            ]
              )
           
                
          ),
        ),
      
    );
  }
}