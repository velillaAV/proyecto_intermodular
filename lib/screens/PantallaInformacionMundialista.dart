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
                  descriptions: [
                    [
                      "La Copa Mundial de la FIFA México 1970 fue la novena edición de la Copa Mundial de Fútbol. Se celebró en México, entre el 31 de mayo y el 21 de junio.",
                      "Mundial que tendría como debutantes a Marruecos, Israel y El Salvador, Selecciones que llegaban al final de su epoca dorada como Peru, Brasil o Inglaterra",
                      "Selecciones que explotarian poco después como Alemania Federal, Checoslovaquia y Bélgica, y entre las ausencias más claras estaban la de España que se fue eliminada en la fase clasificatoria,",
                      "tras una derrota penosa 2-0 contra Finlandia en Helsinki, empezó el debacle español, que hizo que Bélgica y Yugoslavia se pusieran por delante en el grupo ",
                      "Por otra parte en las eliminatorias Sudamericanas, Argentina vió como Peru le quitaba la plaza después de que los peruanos lograran evitar la derrtota en los dos partidos entre ellos",
                      "Entre todas las leyendas que disputarian la edición, el pichichi del mundial anterior, Eúsebio, no pudo asistir debido a una pesima fase clasificatoria de Portugal con una sola victoria"
                    ],
                    [
                      "La Copa Mundial de la FIFA México 1986 fue la decimotercera edición de la Copa Mundial de Fútbol. Se desarrolló entre el 31 de mayo y el 29 de junio.",
                    ],
                    [
                      "La Copa Mundial de la FIFA Estados Unidos 1994 fue la decimoquinta edición de la Copa Mundial de Fútbol, y se desarrolló en los Estados Unidos entre el 17 de junio y el 17 de julio de 1994.",
                      "Se eligió a Estados Unidos como sede del Mundial por primera vez en la historia, lo que generó gran polémica por ser un país sin tradición futbolística debido a la popularidad de otros deportes como el béisbol, el fútbol americano, el hockey sobre hielo y el baloncesto. ",
                    ],
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
