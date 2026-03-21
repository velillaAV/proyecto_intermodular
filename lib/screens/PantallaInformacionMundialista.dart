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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/FondoMundial2026.jpg"),
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
                        "En el Grupo A, la Unión Soviética empató en el partido inaugural contra la anfitriona México, pero se consagro líder con dos grandiosas actuaciones de Anatoli Býshovets ante los belgas y los salvadoreños",
                        "El segundo puesto del grupo se lo jugaron México y Bélgica en el último partido de la fase de grupos, en donde los de casa ganaron por la minima, pasando como segundos de grupo.",
                        "El Grupo B fue más sorpresivo, donde Italia y Uruguay pasaron a la siguiente fase, mientras que los suecos se lamentaron de empatar contra la debutante Israel",
                        "El Grupo C era el que más expectativa tenía, la vigente campeona Inglaterra y la Brasil de Pele, Rivelino y Jairzinho en un mismo grupo, Jairzinho encaminó el liderato tras marcar en todos los encuentros de la fase de grupos",
                        "En el enfrentamiento directo entre ingleses y brasileños se vió la mejor parada de la historia por parte de Gordon Banks a Pelé y los britanicos se conformaron con el segundo puesto del grupo tras el gol de Jairzinho, y las prometedoras Rumania y Checoslovaquia se fueron eliminadas. ",
                        "En el ultimo grupo Perú y Alemania demostraron un nivel ofensivo brutal y atronador, pasando gracias a sus arietes estrellas, Teofilo Cubillas y el Torpedo Müller.",
                        "En los Cuartos de Final, Uruguay se enfrentó a los soviéticos y una gran actuacion de Ladislao Marzurkiewicz llevó el partido a la prórroga en donde con un gol pólemico de Víctor Esparrago, Uruguay pasaba a las semifinales",
                        "Uno de los encuentros más vistosos lo mostraron Inglaterra y Alemania que sería una revancha de la final del mundial anterior. Los goles de Mullery y Peters pusieron a los ingleses dos goles por delante en el marcador",
                        "Pero un gran gol de Beckenbauer y la insistencia de los germanos hizo que llegara el empate por parte de un cabezazo de Uwe Seeler que con una extraña parabola superó a Bonetti, y en la prórroga, Gerd Müller destronó a los campeones y le dio a Alemania el pase a la final."
                            "Los anfitriones buscaron pasar a las semifinales ante Italia, y un tempranero gol de José González les dió esperanza que dudo poco o nada ya que los italianos empataron con fortuna antés del descanso, y en la segunda parte Italia se desató con un doblete de Riva y un gol de Rivera.",
                        "En el último encuentro de cuartos Perú y Brasil se midieron en un duelo sudamericano que Rivelino y Tostao encaminaron hacía la Canarinha, pero Gallardo recortó distancias. ",
                        "Tostao volvió a marcar para los brazucas y Cubillas recortaba de nuevo a favor de los peruanos, Jairzinho no se quisó ir sin marcar, y sentenció el partido con el 4-2 definitivo",
                        "En semifinales Uruguay planteó un partido duro ante Brasil en donde molieron a patadas a los brasileños, Cubilla adelantó a los charrúas, pero Clodoaldo empató al borde del descanso",
                        "En la segunda parte Pelé después de amagar con el cuerpo a Marzurkiewicz casi marca un golazo con mucha técnica, aún así aparecio el de siempre, Jairzinho y Rivelino, pusieron el 2-1 y 3-1 respectivamente llevando a Brasil a la final una vez más",
                        "Italia y Alemania en la otra semifinal disputaron el partido del siglo, en donde Bonisegna adelantó a los italianos a los 8 minutos, a pesar del catenaccio de Italia, Alemania siguió intentando.",
                        "En la segunda parte los germanos reclamaron un penalti sobre Beckenbauer que el arbitro indicó como falta, lo peor fue la lesión de hombro del mismo Beckenbauer que tuvo que seguir jugando con un vendaje puesto",
                        "El esfuerzo teúton tuvo recompensa con un gol de Schellinger en el último minuto, llevando el partido a la prórroga. Al iniciar la prórroga con una jugada de pillo, Müller adelantó a Alemania, y poco después Burgnich volvió a empatar la eliminatoria",
                        "Y poco después tras demostrar una gran capacidad de control de balón, Riva adelantaba a Italia en el marcador, pero después del descanso Müller volvía a empatar en el 110, aún así Gianni Rivera cerró la contienda marcando un minuto después el gol de la victoria Italiana",
                        "Italia siendo el equivo más defensivo del certamen contra Brasil, el equipo más ofensivo, el Ying contra el Yang. Pelé adelantó a los brazucas con un potente cabezazo en el minuto 18, minutos después Bonisegna aprovechó un despiste defensivo para empatar la final",
                        "Al descanso brasileños y italianos empataban a 1, y en la segunda parte un potente zurdazo de Gérson desde fuera del área derribó la muralla italiana, y Jairzinho que siempre estaba listo para la fiesta puso el 3-1 encarrilando el partido para la verde amarela",
                        "Cuando el partido ya agonizaba, Brasil protagonizo una gran jugada colectiva, Pelé asistió a Carlos Arberto por la banda que con un tiro raso ponía el 4-1 definitivo. Brasil y O Rei Pelé conseguían el tercer mundial de su historia, agrandando la leyenda en ambas partes",
                      ],
                      [
                        "La Copa Mundial de la FIFA México 1986 fue la decimotercera edición de la Copa Mundial de Fútbol. Se desarrolló entre el 31 de mayo y el 29 de junio. Primeramente se iba a organizar en Colombia pero al final no lograron cumplir las exigencias de la FIFA",
                        "En el Grupo A, la vigente campeona Italia empató en el primer encuentro contra Bulgaria, mientras que Argentina venció por 3-1 a Corea con doblete de Jorge Valdano a pesar de las duras entradas de los asiaticos sobre Maradona",
                        "En el encuentro entre italianos y argentinos Maradona empató el encuentro tras el pénalti de Altobelli en los primeros minutos, y con una victoria 2-1 ante Bulgaria, Argentina pasaba como primera de grupo",
                        "En el Grupo B, la anfitriona México vencia a Bélgica por la minima con un gol de Hugo Sánchez y Quirarte, y cuando estuvieron a punto de vencer a Paraguay también por la minima, Julio Romero empató en el 85",
                        "Por parte de los belgas, Nico Claesen y Enzo Scifo certificaron su primera victoria ante Irak, pero se tuvieron que conformar con pasar como mejor tercera tras empatar a 2 contra Paraguay en la última jornada",
                        "En el Grupo C, Papin le dió la victoria por la mínima a Francia ante Canadá, mientras que la Unión Soviética goleó 6-0 ante Hungría, en la segunda jornada franceses y soviéticos empataron a 1 mientras que Hungría se redimió venciendo a Canada 2-0",
                        "En la última jornada Francia y la Unión Soviética vencieron a Hungría y a Canadá respectivamente dandoles a ambos el pase a Octavos de Final. En el Grupo D Brasil y España clasificaron facilmente ante Irlanda del Norte y Algeria",
                        "En el grupo E, Uruguay empezo ganando ante Alemania con el gol tempranero de Alzamendi, pero Klaus Allofs empató el encuentro en los minutos finales, en el otro encuentro, Dinamarca ganó por la minima a Escocia con el tanto de Preben Elkjaer Larsen",
                        "La misma Dinamarca dió un golpe sobre la mesa goleando 6-1 a Uruguay con un hat trick del mismo Preben Elkjaer Larsen, y para cerrar la gesta, Dinamarca clasificó como lider tras ganar 2-0 a Alemania",
                        "La otra selección sorpresa fue Marruecos que tras sacar dos empates valiosos ante Polonia y Inglaterra, se puso primera tras una victoria historica ante la Portugal de Paulo Futre, mientras que con hat trick de Lineker, Inglaterra venció a Polonia y se puso segunda",
                        "En octavos Marruecos puso en aprietos a Alemania, pero un golazo de tiro libre de Lothar Matthaüs le dió la victoria a los germanos, la Francia de Platini eliminó a una Italia venida a menos. Mientras que España le dió de su propia medicina a Dinamarca con 1-5 y póker de Butragueño",
                        "Socrates lideró la goleada de Brasil a Polonia, mientras que Lineker siguió marcando con un doblete ante Paraguay. Argentina lo tuvo más complicado de lo esperado ante Uruguay, en la primera parte Paculli adelantó a la albiceleste que tuvo que aguantar los ataques Uruguayos para pasar a cuartos",
                        "La sorpresa de los octavos la protagonizó Bélgica, que a pesar del hat trick de Igor Belanov, los goles de Ceulemans, Scifo, Demol y Claesen eliminaron a los soviéticos, mientras que la anfitriona eliminó 2-0 a Bulgaria en donde Negrete marcó el gol más bello de la historia del mundial",
                        "En los cuartos de final, México a pesar de quedarse con un jugador más en el minuto 66 ante Alemania, no fueron capaces de marcar y en los penaltis, Martin Schumacher se vistió de heróe dandole el pase a los teutones a la semifinal",
                        "España pudo haber llegado a la semifinal, pero Ceulemans adelantó a los belgas y a pesar del empate de Juan Señor, en los penaltis, Jean Marie Pfaff detuvo el lanzamiento de Eloy Olaya eliminando a los españoles",
                        "El encuentro más atractivo a primera vista fue entre Brasil y Francia, en donde Careca adelantó a la verde amarela, Platini empató a nada del descanso, y Zico falló un pénalti que llevó el partido a la prórroga, en la tanda de penaltis, los fallos de Socrates y Julio Cesar le dieron el pase a Francia",
                        "Sin duda alguna el duelo más esperado era el Argentina-Inglaterra, con la guerra de las Malvinas bastante reciente, los dos equipos salieron con todo, y en el minuto 51, Diego Armando se sacó la primera genialidad marcando el gol más pólemico de la historia del futbol tras darle con la mano al balón",
                        "Después de realizar la mano de dios y con el estadio aún en schock, Maradona tras combinar con Burruchaga arrancó de medio campo y marcó el gol del siglo, Inglaterra contrarrestó a Argentina con la entrada de John Barnes que tras volver loca a la defensa asistió a Lineker para el 2-1 defintivo",
                        "En semifinales ante Bélgica Maradona volvió a brillar, con dos goles de gran calidad le dió el pase a la final a la albiceleste, en la otra semifinal un golazo de falta de Andy Brehme y otro de vaselina de Rudi Völler, hizo que Alemania eliminara a Francia y llegara a otra final.",
                        "En la gran final a los 22 minutos trás un centro de Burruchaga, el Tata Brown aprovechó la mala salida de Schumacher para marcar el 1-0, en la segunda parte, Valdano aumentó la renta para Argentina",
                        "Alemania tiró de la épica, y en 3 minutos caóticos, Rudi Völler y Karl-Heinz Rummenigge empataron la final en dos saques de esquina, pero dos minutos después Burruchaga le dió el golpe final a Alemania marcando el 3-2 definitivo que cerraba uno de los mundiales más épicos",
                      ],
                      [
                        "La Copa Mundial de la FIFA Estados Unidos 1994 fue la decimoquinta edición de la Copa Mundial de Fútbol, y se desarrolló en los Estados Unidos entre el 17 de junio y el 17 de julio de 1994.",
                        "En el Grupo A, la anfitriona dejó una buena imagen tras empatar ante Suiza y ganar ante Colombia con el tan recordado gol en propia de Escobar, por su parte Suiza goleó 1-4 a Rumania, una Rumania que tras ganar a Estados Unidos se puso lider acompañado por Suiza como segunda y USA como mejor tercera",
                        "En el Grupo B, la dupla brazuca Bebeto y Romario aterrorizaron el grupo con victorias ante Rusia y Camerún, pero contra los suecos, un gol de Kennet Andersson dejó el partido en empate, dejando a Brasil como primera y a Suecia segunda",
                        "En el Grupo C, Alemania abrió el mundial con una victoria por la mínima ante Bolivia, y España empezó con un tropiezo trás empatar a 2 ante Corea debido a la expulsión de Nadal, pero el empate ante Alemania y la victoria ante Bolivia clasificaba a España"
                            "El Grupo D fue el más igualado, Argentina comenzó goleando 4-0 a Grecia con hat trick de Batistuta, y Nigeria ganó a Bulgaria por 3-1, Argentina, después de vencer a Nigeria por la minima, vió como Maradona era expulsado trás dar positivo en dopaje",
                        "Cosa que concluyó en la derrota ante Bulgaria por 0-2 dejando tanto a Nigeria, Bulgaria y Argentina con 6 puntos. En el Grupo E Italia empezó perdiendo ante Irlanda, pero después de una victoria ante Noruega y un empate ante México Italia pasaba como mejor tercera y México como primera",
                        "En el Grupo F se vió otro empate a 6 puntos, entre Países Bajos, Bélgica y la sorprendente Arabia Saudita que lo consiguió gracias a un golazo técnico de Al Owairan ante Bélgica después de regatearse a 4 jugadores",
                        "La vígente campeona Alemania dió paso a los Octavos ganando ante Bélgica con doblete de Völler y gol de Klinsmann, España por su parte, vencía contundentemente a Suiza con goles de Hierro, Luis Enrique y Beguiristain",
                        "Suecia acabó con el sueño arabe con un doblete de la torre Kennet Andersson, la sorpresa fue Rumania que con un doblete de Dumitrescu eliminó a la Argentina del descalificado Maradona, Italia empezó mal ante Nigeria pero con un doblete de Baggio lograron remontar",
                        "La Bulgaria de Stoichkov eliminó a México en pénaltis, Brasil lo tuvo crudo trás quedarse con uno menós ante Estados Unidos pero el gol de Bebeto les dió la clasificación, en cuartos de final los brazucas se adelantaron en la segunda parte con goles de Bebeto y Romário",
                        "Pero los goles de Dennis Bergkamp y Aron Winter empataron el partido para Holanda, aún así, el golazo de falta de Branco sentenció el encuentro, clasificando a Brasil, Italia y España se midieron en duelo reñido, un tiro lejano de Dino Baggio adelantaba a Italia",
                        "Pero un afortunado gol de Luís Caminero empataba el encuentro, Julio Salinas pudó adelantar a la roja, pero falló la más clara del encuentro y pocos minutos después Baggio no falló, y España se despedía del mundial con un pénalti no pitado a Luis Enrique",
                        "Las dos revelaciones del mundial Rumanía y Suecia empataron a 2, y en la tanda de pénalti, el portero sueco Thomas Ravelli se vistió de heroe parando el último penalti, la sorpresa de los cuartos fue la remontada bulgara ante la vigente campeona Alemania",
                        "Italia neutralizó el pénalti de Stoichkov con otro doblete más de Roberto Baggio, mientras que los brasileños se volvían a enfrentar a Suecia, esta vez un cabezazo de Romário le dio la victoria a la verde amarela, clasificando a la gran final",
                        "Como en México 70, Italia y Brasil se volvían a ver las caras, ambas selecciones con tres mundiales, lo que convertiriría al vencedor tetracampeon del mundo, en las primeras ocasiones Pagluica casí comete un error gravísimo, pero le acabó salvando el palo",
                        "El partido acabó llendose a los penaltis, Baresi y Marcio Santos fallaron los primeros lanzamientos, los 4 siguientes de ambos conjuntos entraron, hasta que Claudio Taffarel detuvo el de Daniele Massaro, Dunga marcó el suyo, dejando la responsabilidad en Roberto Baggio",
                        "El astro italiano mandó su remate al cielo, el silencio recorrió las calles de Italia, y Brasil ganaba su cuarta copa del mundo.",
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
                SizedBox(
                  height: 400,
                  width: 600,
                  child: ImageCarousel(
                    imagePaths: [
                      "images/maradonaCup.jpg",
                      "images/jairzinho.jpg",
                      "images/baggio.jpg",
                    ],
                    descriptions: [
                      [
                        "La actuación de Diego Maradona en la Copa Mundial de la FIFA 1986 es considerada una de las mejores actuaciones individuales de la historia del fútbol. Fue el líder absoluto de la albiceleste y participó directamente en 10 de los 14 goles del equipo (5 goles y 5 asistencias)." ,
                        "En el debút ante corea dió 3 asistencias, 2 a Valdano y otra a Ruggeri, además de soportar las entradas de los coreanos. Contra Italia la vigente campeona,  marcó de vaselina ante Giovanni Galli para empatar el partido, y selló la fase de grupos con una asistencia al Burru ante Bulgaria",
                        "Contra Uruguay su conducción y regates rompieron la defensa uruguaya aunque no marcó ni asistió, contra Inglaterra el Diego se desatió marcando la mano de dios y el gol del siglo ante Peter Shilton. En las semis, un doblete ante Bélgica certificó el pase de Argentina a la final",
                        "En la gran final, después de que Alemania remontara un fuerte 2-0, Maradona dió una asistencia clave para Burruchaga que marcó el 3-2 que le daba el mundial a la albiceleste y aumentaba el hito del mismo Diego Armando"                    
                      ],
                      [ 
                        "La actuación de Jairzinho en el Mundial de 1970 es una de las más impresionantes en la historia del fútbol. Conocido como “el Huracán de la Derecha”, fue una pieza clave del legendario equipo de Selección de fútbol de Brasil que conquistó el torneo.",
                        "Lo que hace su desempeño especialmente memorable es que logró marcar al menos un gol en cada uno de los partidos que disputó, un récord que muy pocos jugadores han conseguido en una sola Copa del Mundo. Desde el primer encuentro, Jairzinho mostró su potencia, velocidad y capacidad goleadora",
                        "En la fase de grupos, anotó contra Checoslovaquia, Inglaterra y Rumanía, siendo decisivo en todos ellos. Especialmente recordado es su gol frente a Inglaterra, vigente campeona en ese momento, donde su fuerza física y determinación rompieron la defensa rival.",
                        "En la fase eliminatoria, Jairzinho continuó su racha goleadora. Marcó en los cuartos de final contra Perú, en semifinales frente a Uruguay, y no podía faltar su gol en la final ante la selección italiana.",
                        "En ese último encuentro, contribuyó a la victoria por 4-1, que consolidó a Brasil como tricampeón del mundo y le permitió quedarse definitivamente con el trofeo Jules Rimet (COPA DEL MUNDO). Con todo eso la actuación de Jairzinho se convirtió en una de las más infravaloradas y poco recordadas"
                      ],
                      [ "La actuación de Roberto Baggio en la Copa Mundial de la FIFA 1994 es una de las más recordadas y contradictorias en la historia del fútbol, marcada por un inicio discreto, una fase final brillante y un desenlace dramático.",
                        "En la fase de grupos, su rendimiento fue irregular y generó críticas. Italia tuvo dificultades para avanzar y Baggio no logró destacar en los primeros partidos, lo que llevó a cuestionamientos sobre su estado físico y su influencia en el juego.",
                        "A partir de los octavos de final, Baggio se transformó en el jugador decisivo del torneo. Marcó dos goles clave contra Nigeria incluido el empate agónico que llevó el partido a la prórroga, y continuó con goles determinantes frente a España en cuartos de final y contra Bulgaria en semifinales.",
                        "En la final contra Brasil, disputada tras un torneo agotador y con Baggio físicamente mermado, el partido terminó sin goles y se decidió en la tanda de penaltis. Ahí llegó lo más trágico de su carrera: Baggio falló el último penalti, enviando el balón a las nubes, lo que dio el título a Brasil."
                                            ],
                    ],
                  ),
                ),
                 SizedBox(height: 20),
                Text(
                  "PLAYOFFS EUROPEOS",
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
                      "images/rutaA.png",
                      "images/rutaB.png",
                      "images/rutaC.png",
                      "images/rutaD.png"
                    ],
                    descriptions: [
                      [
                        "Esta semana en la ruta A de los play offs europeos, Italia, Gales, Irlanda de Norte y Bosnia buscaran su pase al mundial, y aquí te hablo de las 4 selecciones y sus oportunidades." ,
                        "Gennaro Gattuso que ya dió su convocatoria para la Azurra quiere enmendar el paso mundialista de los ultimos años de Italia, fase de grupos en 2010 y 2014, eliminada en clasificatorios por Suecia en 2018 y Macedonia del Norte en 2022",
                        "Repasando la convocatoria, el extremo ex de la Juve ahora jugador del Liverpool Federico Chiesa vuelve tras una ausencia de 2 años en la selección, y con ganas de volver al nivel de esa Eurocopa 2021, en donde vacunaba a cualquiera.",
                        "Parte por parte, en porteria Donnarumma no tiene cambio, aunque Valverde lo haya vacilado en Champions, en una defensa revejuvenecida, volverá del lesión Giorgio Scalvini, que se juntaran al grupo de los defensas promesa junto a Diego Coppola y Marco Palestra del Cagliari",
                        "aún así, Alessandro Bastoni y el firme Gianluca Mancini lideraran la zaga. El polivalente Dimarco que se está marcando un temporadón y Di Lorenzo ocuparan sus respectivos laterales. En el centro del campo Nicolo Barella, Sandro Tonali y Manuel Locatelli serían la apuesta de Gattuso para manejar el partido",
                        "Chiesa y Politano se disputaran la banda derecha, mientras que el prometedor Pio (el pollito Pio) Esposito se ha hecho un hueco en la punta de ataque, probablemente acompañado de Mateo Retegui, todo es problable para que Italia clasifique, pero recuerden, nunca apuesten por Italia."
                        "    ",
                        "Por parte de Irlanda del Norte es mal augurio que principalmente sus jugadores más resltables son sus dos laterales, Connor Bradley y Trai Hume, pero para añadirle más picante, dire algunos jugadores que podrían sorpender.",
                        "Para empezar el delantero del West Bromwich Albion, Isaac Price lleva 7 goles y 1 asistencia e intenta evitar el descenso de los suyos. En la defensa también hay otros nombres propios, como el defensa del Sunderland Daniel Ballard, o el lateral ex Watford Jamal Lewis.",
                        "Con todo esto Irlanda del Norte intentaran vestirse de Macedonios y eliminar a Italia, aunque al final acabaremos viendo Catenaccio vs Brexit, lo cual será un entretenido duelo de todas maneras",
                        "      ",
                        "Los galeses que siguen en el proceso Post-Bale, han encontrado nuevos faros en el ataque como Harry Wilson dell Fulham, la bala Daniel James del Leeds United, David Brooks. Brenan Jonhson, si es como cuando ibas a elegir un chupachus de niño, hay de todos los sabores",
                        "En el centro del campo, Nathan Ampadu si se diera la ocasión, repeteria mundial. Y en la defensa Ben Cabango tiene esos vibes que desprendia Ashley Williams en la Eurocopa de 2016 en la que Gales llegó a semifinales.",
                        "Hay cierta fe en esta Gales, tiene mucho juego ofensivo en el tintero, y pueden ganarle con poca dificultad a Bosnia, pero la problable final contra Italia esta fuera de su rango, pero en el decimo aniversario de las semifinales de Gales en la Euro 2016 todo puede pasar. ",
                        "       ",
                        "Para acabar estaría la Bosnia de Edin Dzeko, la mistica de esta selección nunca se la quitaran, pero los Miralem Pjanec, Hasan Salihadmidzic, Zvejdan Misimovic o Vedad Ibisevic ya no están.",
                        "Las bazas más claras de los bosnios, son su delantera la cual tiene bastantes opciones, el mismo Edin Dzeko que está destinado ha jugar su segundo mundial después de 2014, a su lado Tabakovic y Erdem Demirovic, ambos delanteros de la Bundes con mucho talento.",
                        "Bosnia puede darle pelea a Gales, pero si llegarán a vencerles como siempre, lo llegarían a tener bastante jodido en una posible final ante Italia."
        
                      ],
                      [ 
                        "La actuación de Jairzinho en el Mundial de 1970 es una de las más impresionantes en la historia del fútbol. Conocido como “el Huracán de la Derecha”, fue una pieza clave del legendario equipo de Selección de fútbol de Brasil que conquistó el torneo.",
                        "Lo que hace su desempeño especialmente memorable es que logró marcar al menos un gol en cada uno de los partidos que disputó, un récord que muy pocos jugadores han conseguido en una sola Copa del Mundo. Desde el primer encuentro, Jairzinho mostró su potencia, velocidad y capacidad goleadora",
                        "En la fase de grupos, anotó contra Checoslovaquia, Inglaterra y Rumanía, siendo decisivo en todos ellos. Especialmente recordado es su gol frente a Inglaterra, vigente campeona en ese momento, donde su fuerza física y determinación rompieron la defensa rival.",
                        "En la fase eliminatoria, Jairzinho continuó su racha goleadora. Marcó en los cuartos de final contra Perú, en semifinales frente a Uruguay, y no podía faltar su gol en la final ante la selección italiana.",
                        "En ese último encuentro, contribuyó a la victoria por 4-1, que consolidó a Brasil como tricampeón del mundo y le permitió quedarse definitivamente con el trofeo Jules Rimet (COPA DEL MUNDO). Con todo eso la actuación de Jairzinho se convirtió en una de las más infravaloradas y poco recordadas"
                      ],
                      [ "La actuación de Roberto Baggio en la Copa Mundial de la FIFA 1994 es una de las más recordadas y contradictorias en la historia del fútbol, marcada por un inicio discreto, una fase final brillante y un desenlace dramático.",
                        "En la fase de grupos, su rendimiento fue irregular y generó críticas. Italia tuvo dificultades para avanzar y Baggio no logró destacar en los primeros partidos, lo que llevó a cuestionamientos sobre su estado físico y su influencia en el juego.",
                        "A partir de los octavos de final, Baggio se transformó en el jugador decisivo del torneo. Marcó dos goles clave contra Nigeria incluido el empate agónico que llevó el partido a la prórroga, y continuó con goles determinantes frente a España en cuartos de final y contra Bulgaria en semifinales.",
                        "En la final contra Brasil, disputada tras un torneo agotador y con Baggio físicamente mermado, el partido terminó sin goles y se decidió en la tanda de penaltis. Ahí llegó lo más trágico de su carrera: Baggio falló el último penalti, enviando el balón a las nubes, lo que dio el título a Brasil."
                                            ],
                      [
        
                                            ]                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
