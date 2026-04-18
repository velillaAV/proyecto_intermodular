import 'dart:math';

import 'package:proyecto_intermodular/models/ModeloJugador.dart';

class Logicajugadores {


  final listaPorteros = [
    Modelojugador(
          id_jugador: 1,
          nombre: "Nikola Vasijl",
          pais: "images/logoBosnia.png",
          valor_clausula: 14000000,
          valor_venta: 4000000,
          fotoRutaJugador: "images/nikolaVasijl.png",
          posicion: "POR",
        ),
        Modelojugador(
          id_jugador: 2,
          nombre: "Martin Zlomislic",
          pais: "images/logoBosnia.png",
          valor_clausula: 8000000,
          valor_venta: 1000000,
          fotoRutaJugador: "images/martinZlomislic.png",
          posicion: "POR",
        ),
       
        
       
  ];

  final listaDefensas = [
       Modelojugador(
          id_jugador: 3,
          nombre: "Sead Kolasinac",
          pais: "images/logoBosnia.png",
          valor_clausula: 18000000,
          valor_venta: 6000000,
          fotoRutaJugador: "images/seadKolasinac.png",
          posicion: "DEF",
        ),
        Modelojugador(
          id_jugador: 4,
          nombre: "Tarik Muharemovic",
          pais: "images/logoBosnia.png",
          valor_clausula: 40000000,
          valor_venta: 20000000,
          fotoRutaJugador: "images/tarikMuharemovic.png",
          posicion: "DEF",
        ),
        Modelojugador(
          id_jugador: 5,
          nombre: "Amar Dedic",
          pais: "images/logoBosnia.png",
          valor_clausula: 38000000,
          valor_venta: 18000000,
          fotoRutaJugador: "images/amarDedic.png",
          posicion: "DEF",
        ),
         Modelojugador(
          id_jugador: 6,
          nombre: "Nikola Katic",
          pais: "images/logoBosnia.png",
          valor_clausula: 8000000,
          valor_venta: 2000000,
          fotoRutaJugador: "images/nikolaKatic.png",
          posicion: "DEF",
        ),
        Modelojugador(
          id_jugador: 13,
          nombre: "Marcos Senesi",
          pais: "images/logoArgentina.png",
          valor_clausula: 22000000,
          valor_venta: 12000000,
          fotoRutaJugador: "images/marcosSenesi.png",
          posicion: "DEF",
        ),
        Modelojugador(
          id_jugador: 14,
          nombre: "Nathan Ngoy",
          pais: "images/logoBelgica.png",
          valor_clausula: 22000000,
          valor_venta: 12000000,
          fotoRutaJugador: "images/nathanNgoy.png",
          posicion: "DEF",
        ),
        Modelojugador(
          id_jugador: 15,
          nombre: "Renato Veiga",
          pais: "images/logoPortugal.png",
          valor_clausula: 22000000,
          valor_venta: 12000000,
          fotoRutaJugador: "images/renatoVeiga.png",
          posicion: "DEF",
        ),

  ];

  final listaCentrocampistas = [
      Modelojugador(
          id_jugador: 7,
          nombre: "Benjamin Tahirovic",
          pais: "images/logoBosnia.png",
          valor_clausula: 12000000,
          valor_venta: 4000000,
          fotoRutaJugador: "images/benjaminTahirovic.png",
          posicion: "CEN",
        ),
        Modelojugador(
          id_jugador: 8,
          nombre: "Amar Memic",
          pais: "images/logoBosnia.png",
          valor_clausula: 12000000,
          valor_venta: 4000000,
          fotoRutaJugador: "images/amarMemic.png",
          posicion: "CEN",
        ),
        Modelojugador(
          id_jugador: 9,
          nombre: "Amir Hadziahmetovic",
          pais: "images/logoBosnia.png",
          valor_clausula: 12000000,
          valor_venta: 4000000,
          fotoRutaJugador: "images/amirHadziahmetovic.png",
          posicion: "CEN",
        ),
        Modelojugador(
          id_jugador: 16,
          nombre: "Pape Gueye",
          pais: "images/logoSenegal.png",
          valor_clausula: 42000000,
          valor_venta: 22000000,
          fotoRutaJugador: "images/papeGueye.png",
          posicion: "CEN",
        ),
        Modelojugador(
          id_jugador: 17,
          nombre: "Sebastian Berhalter",
          pais: "images/logoUSA.png",
          valor_clausula: 20000000,
          valor_venta: 10000000,
          fotoRutaJugador: "images/sebastianBerhalter.png",
          posicion: "CEN",
        ),

  ];

  final listaAtacantes = [
       Modelojugador(
          id_jugador: 10,
          nombre: "Ermedin Demirovic",
          pais: "images/logoBosnia.png",
          valor_clausula: 42000000,
          valor_venta: 22000000,
          fotoRutaJugador: "images/ermedinDemirovic.png",
          posicion: "DEL",
        ),
        Modelojugador(
          id_jugador: 11,
          nombre: "Haris Tabakovic",
          pais: "images/logoBosnia.png",
          valor_clausula: 11000000,
          valor_venta: 3000000,
          fotoRutaJugador: "images/harisTabakovic.png",
          posicion: "DEL",
        ),
        Modelojugador(
          id_jugador: 12,
          nombre: "Edin Dzeko",
          pais: "images/logoBosnia.png",
          valor_clausula: 10000000,
          valor_venta: 2000000,
          fotoRutaJugador: "images/edinDzeko.png",
          posicion: "DEL",
        ),
         Modelojugador(
          id_jugador: 18,
          nombre: "Mikel Oyarzabal",
          pais: "images/logoEspana.png",
          valor_clausula: 50000000,
          valor_venta: 30000000,
          fotoRutaJugador: "images/mikelOyarzabal.png",
          posicion: "DEL",
        ),
        Modelojugador(
          id_jugador: 19,
          nombre: "Alberto Moleiro",
          pais: "images/logoEspana.png",
          valor_clausula: 50000000,
          valor_venta: 30000000,
          fotoRutaJugador: "images/albertoMoleiro.png",
          posicion: "DEL",
        ),
         Modelojugador(
          id_jugador: 20,
          nombre: "Mika Godts",
          pais: "images/logoBelgica.png",
          valor_clausula: 40000000,
          valor_venta: 20000000,
          fotoRutaJugador: "images/mikaGodts.png",
          posicion: "DEL",
        ),
  ];

  List<Modelojugador> otorgarEquipo() {
    List<Modelojugador> equipo = [];
    Random porteroRandom = Random();
    int portero  = porteroRandom.nextInt(listaPorteros.length);
    equipo.add(listaPorteros.elementAt(portero));
    for (int i = 0; i < 5; i++) {
        Random defensaRandom = Random();
        int defensa  = defensaRandom.nextInt(listaDefensas.length);
        if(equipo.contains(listaDefensas.elementAt(defensa))) {
          while(equipo.contains(listaDefensas.elementAt(defensa)) == true) {
              defensa  = defensaRandom.nextInt(listaDefensas.length);
          }
        }
        equipo.add(listaDefensas.elementAt(defensa));
    }

     for (int i = 0; i < 4; i++) {
        Random centrocampistaRandom = Random();
        int centrocampista  = centrocampistaRandom.nextInt(listaCentrocampistas.length);
        if(equipo.contains(listaCentrocampistas.elementAt(centrocampista))) {
          while(equipo.contains(listaCentrocampistas.elementAt(centrocampista)) == true) {
             centrocampista  = centrocampistaRandom.nextInt(listaCentrocampistas.length);
          }
        }
        equipo.add(listaCentrocampistas.elementAt(centrocampista));
    }

    for (int i = 0; i < 4; i++) {
        Random atacanteRandom = Random();
        int atacante  = atacanteRandom.nextInt(listaAtacantes.length);
        if(equipo.contains(listaAtacantes.elementAt(atacante))) {
          while(equipo.contains(listaAtacantes.elementAt(atacante)) == true) {
             atacante  = atacanteRandom.nextInt(listaAtacantes.length);
          }
        }
        equipo.add(listaAtacantes.elementAt(atacante));
    }



    

    return equipo;
  }
}