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
              image: AssetImage("assets/images/FondoMundial2026.jpg"),
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
                        "La actuación de Diego Maradona en la Copa Mundial de la FIFA 1986 es considerada una de las mejores actuaciones individuales de la historia del fútbol. Fue el líder absoluto de la albiceleste y participó directamente en 10 de los 14 goles del equipo (5 goles y 5 asistencias).",
                        "En el debút ante corea dió 3 asistencias, 2 a Valdano y otra a Ruggeri, además de soportar las entradas de los coreanos. Contra Italia la vigente campeona,  marcó de vaselina ante Giovanni Galli para empatar el partido, y selló la fase de grupos con una asistencia al Burru ante Bulgaria",
                        "Contra Uruguay su conducción y regates rompieron la defensa uruguaya aunque no marcó ni asistió, contra Inglaterra el Diego se desatió marcando la mano de dios y el gol del siglo ante Peter Shilton. En las semis, un doblete ante Bélgica certificó el pase de Argentina a la final",
                        "En la gran final, después de que Alemania remontara un fuerte 2-0, Maradona dió una asistencia clave para Burruchaga que marcó el 3-2 que le daba el mundial a la albiceleste y aumentaba el hito del mismo Diego Armando",
                      ],
                      [
                        "La actuación de Jairzinho en el Mundial de 1970 es una de las más impresionantes en la historia del fútbol. Conocido como “el Huracán de la Derecha”, fue una pieza clave del legendario equipo de Selección de fútbol de Brasil que conquistó el torneo.",
                        "Lo que hace su desempeño especialmente memorable es que logró marcar al menos un gol en cada uno de los partidos que disputó, un récord que muy pocos jugadores han conseguido en una sola Copa del Mundo. Desde el primer encuentro, Jairzinho mostró su potencia, velocidad y capacidad goleadora",
                        "En la fase de grupos, anotó contra Checoslovaquia, Inglaterra y Rumanía, siendo decisivo en todos ellos. Especialmente recordado es su gol frente a Inglaterra, vigente campeona en ese momento, donde su fuerza física y determinación rompieron la defensa rival.",
                        "En la fase eliminatoria, Jairzinho continuó su racha goleadora. Marcó en los cuartos de final contra Perú, en semifinales frente a Uruguay, y no podía faltar su gol en la final ante la selección italiana.",
                        "En ese último encuentro, contribuyó a la victoria por 4-1, que consolidó a Brasil como tricampeón del mundo y le permitió quedarse definitivamente con el trofeo Jules Rimet (COPA DEL MUNDO). Con todo eso la actuación de Jairzinho se convirtió en una de las más infravaloradas y poco recordadas",
                      ],
                      [
                        "La actuación de Roberto Baggio en la Copa Mundial de la FIFA 1994 es una de las más recordadas y contradictorias en la historia del fútbol, marcada por un inicio discreto, una fase final brillante y un desenlace dramático.",
                        "En la fase de grupos, su rendimiento fue irregular y generó críticas. Italia tuvo dificultades para avanzar y Baggio no logró destacar en los primeros partidos, lo que llevó a cuestionamientos sobre su estado físico y su influencia en el juego.",
                        "A partir de los octavos de final, Baggio se transformó en el jugador decisivo del torneo. Marcó dos goles clave contra Nigeria incluido el empate agónico que llevó el partido a la prórroga, y continuó con goles determinantes frente a España en cuartos de final y contra Bulgaria en semifinales.",
                        "En la final contra Brasil, disputada tras un torneo agotador y con Baggio físicamente mermado, el partido terminó sin goles y se decidió en la tanda de penaltis. Ahí llegó lo más trágico de su carrera: Baggio falló el último penalti, enviando el balón a las nubes, lo que dio el título a Brasil.",
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
                      "images/rutaD.png",
                    ],
                    descriptions: [
                      [
                        "Esta semana en la ruta A de los play offs europeos, Italia, Gales, Irlanda de Norte y Bosnia buscaran su pase al mundial, y aquí te hablo de las 4 selecciones y sus oportunidades.",
                        "Gennaro Gattuso que ya dió su convocatoria para la Azurra quiere enmendar el paso mundialista de los ultimos años de Italia, fase de grupos en 2010 y 2014, eliminada en clasificatorios por Suecia en 2018 y Macedonia del Norte en 2022",
                        "Repasando la convocatoria, el extremo ex de la Juve ahora jugador del Liverpool Federico Chiesa vuelve tras una ausencia de 2 años en la selección, y con ganas de volver al nivel de esa Eurocopa 2021, en donde vacunaba a cualquiera.",
                        "Parte por parte, en porteria Donnarumma no tiene cambio, aunque Valverde lo haya vacilado en Champions, en una defensa revejuvenecida, volverá del lesión Giorgio Scalvini, que se juntaran al grupo de los defensas promesa junto a Diego Coppola y Marco Palestra del Cagliari",
                        "aún así, Alessandro Bastoni y el firme Gianluca Mancini lideraran la zaga. El polivalente Dimarco que se está marcando un temporadón y Di Lorenzo ocuparan sus respectivos laterales. En el centro del campo Nicolo Barella, Sandro Tonali y Manuel Locatelli serían la apuesta de Gattuso para manejar el partido",
                        "Chiesa y Politano se disputaran la banda derecha, mientras que el prometedor Pio (el pollito Pio) Esposito se ha hecho un hueco en la punta de ataque, probablemente acompañado de Mateo Retegui, todo es problable para que Italia clasifique, pero recuerden, nunca apuesten por Italia."
                            "    ",
                        "Por parte de Irlanda del Norte es mal augurio que principalmente sus jugadores más resltables son sus dos laterales, Connor Bradley (actualmente lesionado) y Trai Hume, pero para añadirle más picante, dire algunos jugadores que podrían sorpender.",
                        "Para empezar el delantero del West Bromwich Albion, Isaac Price lleva 7 goles y 1 asistencia e intenta evitar el descenso de los suyos. En la defensa también hay otros nombres propios, como el defensa del Sunderland Daniel Ballard, o el lateral ex Watford Jamal Lewis.",
                        "Con todo esto Irlanda del Norte intentaran vestirse de Macedonios y eliminar a Italia, aunque al final acabaremos viendo Catenaccio vs Brexit, lo cual será un entretenido duelo de todas maneras",
                        "      ",
                        "Los galeses que siguen en el proceso Post-Bale, han encontrado nuevos faros en el ataque como Harry Wilson dell Fulham, la bala Daniel James del Leeds United, David Brooks. Brenan Jonhson, si es como cuando ibas a elegir un chupachus de niño, hay de todos los sabores",
                        "En el centro del campo, Nathan Ampadu si se diera la ocasión, repeteria mundial. Y en la defensa Ben Cabango tiene esos vibes que desprendia Ashley Williams en la Eurocopa de 2016 en la que Gales llegó a semifinales.",
                        "Hay cierta fe en esta Gales, tiene mucho juego ofensivo en el tintero, y pueden ganarle con poca dificultad a Bosnia, pero la problable final contra Italia esta fuera de su rango, pero en el decimo aniversario de las semifinales de Gales en la Euro 2016 todo puede pasar. ",
                        "       ",
                        "Para acabar estaría la Bosnia de Edin Dzeko, la mistica de esta selección nunca se la quitaran, pero los Miralem Pjanec, Hasan Salihadmidzic, Zvejdan Misimovic o Vedad Ibisevic ya no están.",
                        "Las bazas más claras de los bosnios, son su delantera la cual tiene bastantes opciones, el mismo Edin Dzeko que está destinado ha jugar su segundo mundial después de 2014, a su lado Tabakovic y Erdem Demirovic, ambos delanteros de la Bundes con mucho talento.",
                        "Y en defensa otro veterano como Sead Kolasinac portará su granito de arena. Bosnia puede darle pelea a Gales, pero si llegarán a vencerles como siempre, lo llegarían a tener bastante jodido en una posible final ante Italia.",
                      ],
                      [
                        "Desde una Suecia desinflada, una Ucrania con jovenes promesas y con una Polonia que busca el last dance de Robert Lewandowski hasta una Albania que quiere sorprender, y de esa forma se dictara el clasificado de la ruta B, pero de momento, analicémoslos.",
                        " ",
                        "Como se ha mencionado antes, Suecia va caída en picada, y es que a pesar de los nombres con los que forma su equipo no opinan igual, la verdad es que Gyokeres y Isak no han sido capaces de contribuir en la fase clasificatoria.",
                        "Aún así hay ciertos jugadores que pueden aportar esa chispa, sin irnos muy lejos de Inglaterra, también está Elanga que a pesar del 7-2 contra el FC Barcelona estuvo muy activo en la primera parte, y puede llevar a los suecos en bolandas o un Williot Swedberg que es pieza clave de un gran Celta",
                        "Y por otra parte, aunque no es atacante, Mattias Svanberg ha tenido que ocupar posiciones ofensivas debido a la ausencia de dos grandes nombres pero de pequeño rendimiento actual. Las lesiones no permitiran que Dejan Kulusevski pueda participar en los play offs pero tienen cierto recambio",
                        "Y estoy hablando de Roony Bardghji la joya del FC Barcelona y que junto a Benjamin Nygren serán bastante importantes en el intento de pasar los play offs, pero no nos dejemos la defensa, en la que predominan el Isak bueno, Isak Hien, y el que ha visto mejores dias, Victor Lindelof",
                        "En el centro del campo jugadores prometedores como Hugo Larsson, la perla de un Tottenham en declive Lucas Bergvall o un jugador que siempre da la cara como Yasin Ayari."
                            "En general Suecia si no juega como en los clasificatorios lo tiene ciertamente a la altura, pero Ucrania, tampoco es moco de pavo",
                        " ",
                        "Y hablando de Ucrania, continuemos con ellos, sumando datos curiosos a la olla, su ultimo mundial fue hace 20 años, liderados por Andriy Shevchencko nada más nada menos, y aunque después de su retiro Ucrania ha estado desorientada, hay que decir que han logrado cosechar buenos jugadores",
                        "En el ataque parece que tienen una obsesion con el Girona, o el Girona con ellos, porque Vladislav Vanat le ha quitado el puesto a Artem Dobvyk, aunque hay que admitir que se lo ha merecido, y acompañandole estaran el siempre fiable Oleksandr Zubkov, y el jedi Viktor Tsygankov",
                        "La defensa tampoco se queda atras, la apuesta de Luis Enrique Illia Zabarniy será quien se encargará de parar a Gyokeres, a sus lados Konoplya y el euforico Mykolenko. Mientras que como último recurso el portero Anatoliy Trubin siempre estará por la favor de volver a volar los cierlos",
                        "No miento al decir que Ucrania puede darle pelea e incluso ganarle a Suecia y intentar ganar la final ante Polonia o Albania, tiene un equipo bastante completo",
                        ""
                            "Por su parte una Polonia que viene en mejora, hará todo lo que esté en su mano para que Robert Lewandowski juegue su ultimo mundial, y lo mejor de todo, es que tienen bastantes oportunidades",
                        "Hay que recordar que la única razón de estar en play off es haber estado en el mismo grupo que un gran equipo como lo es Holanda, pero Jakub Kaminski nos recordó que Polonia no es poca cosa marcando el empate ante Holanda en los clasificatorios",
                        "Jakub Kaminski, Robert Lewandoski, y Oskar Pietuszewski buscaran marcar la diferencia en el ataque, mientras que el que generará las jugadas será el veterano Piotr Zielinski. Aún así su defensa de 5 no se lo quita ni el paso de los tiempos",
                        "Polonia no debería tener problemas en ganar a Albania, luego ya tendría que sufrir para poder vencer a Ucrania o a Suecia en una posible final, pero lo que es seguro es que Lewandowski si que lo dará todo para su last dance",
                        "",
                        "Lo sé, lo sé, Albania es la que menos posibilidad tiene, pero algo se podrá rascar seguro, y su mayor recurso es su portero con experiencia en la Seria A, Tomas Strakosha",
                        "En defensa el mitico lateral Elseid Hysaj dará lo último que le queda para que Albania clasifique, mientras que en el resto de la defensa Berat Djismiti y Ivan Balliu serán quien saquen la cara por sus compañeros",
                        "La Eurocopa 2024 de los albaneses influira mucho en a convocatoria, ya que a Laçi y a Assllani no los quitan del centro del campo ni pagando, mientras que en el ataque hay un poco más de consistencia",
                        "El autor del gol más rapido de las Eurocopas Nedim Bajrami querrá seguir volando en busca de romper las defensas rivales y que Uzuni y Armando Broja marquen los goles. Albania lo tiene dificil, es cierto, pero las probabilidades nunca son 0",
                      ],
                      [
                        "La Ruta C facilmente es la más desigualada, dos equipos que hicieron una muy buena Eurocopa 2024, Rumania y Turquía por un lado y Kosovo y Eslovaquia por otro, es verdad que no se puede esperar mucho de ese lado de la ruta, pero vamos a ver más a fondo",
                        "  ",
                        "Hay que empezar admitiendo que la Eurocopa de Eslovaquia tampoco fue mala ya que casí eliminan a Inglaterra, y ahora tienen la posibilidad de jugar el mundial, y tienen ciertos jugadores para conseguirlo",
                        "La defensa es la cara de esta Eslovaquia, aunque Milan Skriniar no está para nada en su nivel en el Inter, siempre es un seguro para la zaga eslovaca, y si a eso le subas al infravalorado David Hancko y a Daniel Valjent más o menos tienen la defensa bastante completa",
                        "Stanislav Lobotka volverá a ser el eje de este equipo, acompañado por Ondrej Duda. A decir verdad, el ataque es la parte más floja, pero hay algunas joyitas como Leo Sauer, Robert Bozenik o Lukas Haraslin que pueden aportar su granito de arena",
                        "Eslovaquia necesitara defender bien al pirata para llegar a la final, ya le ganaron una vez a Alemania y estuvieron a punto de clasificar directos al mundial si no fuera por esa derrota ante Irlanda del Norte y el goal average, los eslovacos pueden sorprender y mucho",
                        "",
                        "Kosovo, Kosovo, Kosovo, se que quitando ciertos temas, nadie espera mucho de Kosovo, pero hay que decir que Kosovo tuvo un final de clasificatorias bastante bueno, ganando a Suecia, Eslovenia y empatando a Suiza",
                        "Las claves de esta selección kosovar es su dupla de ataque, el mitico, el pirata Vedat Muriqi que en los sueños de todos estaría el jugando el mundial, es que es un simbolo emblematico en Mallorca, y su compañero de armas tampoco se queda atras",
                        "Fisnik Asllani, ver un partido del Hoffenheim es un lujo, ya sea por este hombre o por el infravalorado croata Andrej Kramaric, y es que con 8 goles y 5 asistencias estan sirviendo para intentar meter al mitico Hoffenheim en la Champions League para el año que viene",
                        "Otra joyita que hay encubierta es el lateral del Como Mergim Vojvoda, y sin irnos de Italia, está el bi campeón de Italia con el Napolés Amir Rrahmani. En otras palabras Kosovo tiene algunas opciones de al menos llegar a la final, ya el clasificar al mundial sería una cosa bastante improbable",
                        "",
                        "Turquía, que puedo yo decir, si no hubieran estado en nuestro grupo, hubieran pasado en cualquier otro grupo, a pesar del 6-0 que les metimos, tienen un talento que desborda y no tiene pinta de parar, cosa que trae recuerdos de Corea y Japón 2002",
                        "Por donde empezar, en el ataque hay un montón de diamantes brutos, un Arda Güler que está siendo clave en el Real Madrid, Kenan Yildiz que siempre se vuelve Lefter Kuçukandonyadis cuando juega con Turquía, y otros no tan conocidos como Can Uzun del Eintracht Frankfurt",
                        "Tras el rendimiento del Galatasaray en Champions, algunos jugadores como Yunus Akgun, o Baris Alper Yilmaz han aumentado su rendimiento, este último siendo de mis favoritos, Yilmaz no corre, vuela, es frenetico, es peleon, no tendrá la clase de los anteriores, pero te juega 120 minutos como si no fuera nada",
                        "En el centro del campo la ausencia de Hakan Calhanoglu se notará mucho, pero Orkan Koçku será una baza que les servira para los play off, siendo acompañado por Salih Ozcan que ya marcó contra España en el último partido de las clasificatorias",
                        "La defensa turca también está bastante completa, Merih Demiral cuyos cabezazos rompen redes, el lateral Ferdi Kadioglu que arrasa el cesped, o Abdulkerim Bardakci, es verdad que la pifiaron en la Eurocopa contra Portugal, pero su estado de forma ha mejorado si obviamos ese desastroso 6-0 que le metimos",
                        "No hay dudas de que Turquía es la favorita de muchos para clasificar al mundial, y tienen todo para hacerlo, pero tampoco se pueden confiar demasiado, o se les acabaran comiendo la tostada",
                        "",
                        "Rumania, siendo sinceros están bastante lejos de su rendimiento de aquella Eurocopa, pero aún tienen ciertos jugadores que dan la talla, y algunos diamantes encubiertos que tanto nos gustan",
                        "En la defensa como siempre, el inigualable lateral ex del Villarreal, actualmente en el Rayo Vallecano, el mejor lateral derecha de LaLiga el año pasado, Andrei Ratiuuu, y en el otro lateral, Nicusor Bancu que también repite de la Eurocopa 2024",
                        "En el centro del campo de por si no hay mucho que destacar, pero ahí va nuestra primera joyita encubierta, Florin Tanase, un jugón que está devolviendo al Steaua de Bucarest donde se merece, primeros en el grupo B de la fase eliminatoria de la liga rumana",
                        "Ya en el ataque, el veloz extremo Dennis Man, será quien lidere el ataque, mientras que Ianis Hagi quiere replicar la leyenda de su padre en el 1994 llevando a Rumania de nuevo a un mundia en Estados Unidos",
                        "Rumania lleva una selección bastante centrada en su liga, y todos tienen una gran conexión, lo cual les podría servir para pelear contra la rocosa y letal Turquía e intentar llegar a la final",
                      ],
                      [
                        "La última ruta para llegar al mundial, la ruta D, una Republica de Irlanda que le dió la vuelta a Hungría, Republica Checa que no pudo clasificar tras perder contra las Islas Feroes, La Macedonia del Norte mata italianos y la siempre prometedora Dinamarca",
                        " ",
                        "Es cierto que Republica de Irlanda empezó mal, derrota ante Portugal, Armenia y empate ante Hungría, pero en los ultimos partidos le dieron la vuelta a la tortilla para ganarle a los tres y pasar a los play offs en un partido de infarto ante Hungría",
                        "No podemos analizar a Republica de Irlanda sin mencionar al poseido por el alma de Robbie Keane, Troy Parrot, el lorete del AZ Alkmaar, fue más que decisivo para la clasificación irlandesa, hat trick ante Hungría y doblete ante Portugal, un delantero letal e infravalorado",
                        "Además de Parrot, esta Irlanda cuenta con varios creadores de juego por ejemplo el mediocentro ofensivo Finn Azaz o Josh Cullen, a pesar de tener varios jugadores jovenes, todo indica de que Seamus Coleman la leyenda absoluta del Everton, dará su ultimo esfuerzo para mandar a Irlanda al mundial",
                        "En la defensa predominará el futbolista del Brentford Nathan Collins, mientras que en la porteria Caominhin Kelleher será quien se encarge de defender a muerte esa porteria. Republica de Irlanda tiene ese tinte a equipo sorpresa y tiene varias papeletas para poder jugar el mundial",
                        "",
                        "Republica Checa, ya no se acerca ni al nivel de las Eurocopas del 96, 04, ni 21. Están bastante flojos a pesar de tener varios jugadores en buen nivel, siendo por ejemplo el lateral Vladimír Coufal que está siendo clave en el Hoffenheim que huele Champions League",
                        "Vayamos por parte, el portero del lider de Holanda el PSV, Matej Kovar será quien ocupe la porteria, Vladimir Coufal como ya hemos mencionado será el líder de la zaga junto a su compañero de equipo Robin Hranac",
                        "En el centro del campo el capítan Tomas Soucek será el que inicie el flujo del juego checo, mientras el que hará que fluya en ataque será Pavel Sulc que vuelve de lesíon, y junto a Patrick Schick se encargan de marcar los goles.",
                        "Como ya se ha visto, Republica Checa tiene jugadores para poder pelear, pero el que funcionen en combinación ya se verá, pero si hay algo seguro, el duelo entre Republicas estará más que emocionante",
                        "",
                        "Dinamarca sinceramente se podría haber ahorrado jugar los play offs, pero el empate ante Bielorrusia y la épica derrota ante Escocia les acabó negando el pase directo, aún así están en bastante mejor forma que el mundial 2022 y la Eurocopa 2024",
                        "Kasper Schmeichel parece que no piensa retirarse de la selección hasta al menos intentar jugar este mundial, y siempre es algo bueno que un Schmeichel este en la porteria danesa da igual su edad",
                        "En la defensa se ha sumado una bala que gracias a Michael Carrick ha dado un subidón a su rendimiento, y si, ese es Patrick Dorgu, jugador que dará mucho de que hablar. El resto de la defensa también es bastante fiable, el veterano Andreas Christensen, el rapido lateral del Benfica Bah",
                        "Y el central del Fullham Joachim Andersen, el doble pivote de Dinamarca es de lo mejorcito, Pierre Emile Hojbjerg y Morten Hjulmand ambos son jugadores muy completos para el centro del campo danés, además de contar con refuerzos como Nikolas Nartey del Stuttgart.",
                        "Y arriba, el renacido Rasmus Hojlund se combinará con el anotador de golazos Mikkel Damsgaard y el genio Christian Eriksen para darle ese juego ofensivo que tanto caracterizaba a Dinamarca. Dinamarca es la favorita de esta ruta, pero Macedonia ya es conocida por matar favoritas",
                        " ",
                        "El mejor equipo para acabar con el analísis de las rutas de los Play Offs, la mata gigantes Macedonia del Norte, es verdad que nunca se espera nada de ellos y por eso siempre sorprenden",
                        "Poco se puede resaltar de los macedonios, pero siempre a los dos mismos cracks, fieras y gigantes, Enis Bardhi y Stole Dimitrievski, dos clasicazos de LaLiga, quien no vio a Enis Bardhi en el Levante que se vaya a ver un video suyo en Youtube ya mismo",
                        "Y por parte de Stole es la representación de lo que ha sido Jan Oblak para Eslovenia, un muro que intenta proteger las esperanzas mundialistas de los macedonios día sí y día no",
                        "Para que no se quede corto soltemos algunas joyas encubiertas, Elif Elmas que a pesar de ser ciertamente conocido, empezó siendo una promesa y hoy ha bajado su nivel bastante, otro parecido es el ex del Girona Bojan Miovski",
                        "Hay muchas ganas de volver a ver jugar a Macedonia del Norte unos play offs después de los del mundial 2022, y se que darán espectaculo pase lo que pase",
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "FINAL PLAY OFFS",
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
                      "images/finalrutaA.png",
                      "images/finalrutaB.png",
                      "images/finalrutaC.png",
                      "images/finalrutaD.png",
                      "images/finalesrutaRD.png",
                    ],
                    descriptions: [
                      [
                        "En el encuentro entre Irlanda del Norte y Italia, como era de esperarse, Italia salió a por todas, y sus dos puntas Retegui y Moise Kean llegaron a conectar bastante bien, trás una cagada de Terry Devlin Matteo Retegui pudó haber marcado el primero, pero el portero se le adelantó",
                        "Y no fue en la segunda parte que trás un despeje de Isaac Price, Sandro Tonali enganchó una gran volea que supero a Pierce Charles y adelantaba a Italia. Moise Kean que había tenido un montón de oportunidades incluyendo una chilena, marcó en los últimos minutos para sentenciar.",
                        "En la otra semifinal, los bosnios plantearon un partido trabado en donde les sacaron 3 tarjetas amarillas solamente en la primera parte, pero en la segunda, Daniel James aprovechó un error garrafal de un jugador bosnio, para clavarla en el angulo y adelantar a los galeses",
                        "A partir de ahí Bosnia cambió a un estilo más ofensivo y Ermedin Demirovic tuvó el empate pero el travesaño se lo impidió, Nikola Vasijl mantuvo las esperanzas bosnias deteniendo el doblete de Daniel James, y cuando todo parecia perdido, como una eminencia apareció Edin Dzeko",
                        "Kerim Alajbegovic puso el córner al área, y Edin Dzeko cabeceó hacía atrás el balón que acabo entrando en la porteria, y sin celebrarlo euforicamente porque ya no le da más el body, Bosnia empataba la eliminatoria. Bosnia sufrió toda la prórroga en donde su defensa fue protagonista.",
                        "Los penaltis no empezaron bien para los bosnios, ya que Ermedin Demirovic fallaba el primero y Harry Wilson ponía a Gales por delante en la tanda, Tabakovic y Harris ambos anotaron sus lanzamientos, y trás el acierto de Basic, Nikola Vasijl tuvo otra oportunidad para empatar la tanda",
                        "Pero Brennan Johnson que tenía remanente de la mala suerte Spurs, terminó mandandó el balón a las nubes, empatando la tanda el mismo, Hadziahmetovic marcó, y Nikola Vasijl se volvía a vestir de heróe parando el tiro de Neco Williams y el mismo Kerim Alajbegovic que asistió a Dzeko se llevaba la resposabilidad",
                        "Y con un buen lanzamiento Bosnia pasaba a la final de la ruta A de los play offs, en donde junto a Italia querran pasar al mundial después de 12 años sin jugarlo",
                        "Bosnia y Italia, ambas que no pisaban un mundial desde 2014 tenían la oportunidad de hacerlo. Y en los primeros minutos, tras un error en el saque de Vasijl, Moise Kean la mandó a la escuadra abriendo el marcador, pero en el minuto 40, tras una entrada brusca a Memic, Bastoni se hacía expulsar tontamente",
                        "En la segunda parte, Moise Kean pudo doblar la ventaja pero a pesar de haber hecho un buen sprint, su remate se fue por encima del larguero, y Bosnia lo aprovechó minutos después, ya que Haris Tabakovic mandaba el partido a una prórroga que Italia buscaba evitar.",
                        "En la prórroga una gran parada de Vasijl evita que Italia marcara, Benjamin Tahirovic fue el que pudo materializar la ocasión más clara de la prórroga, pero su remate se fue rozando el palo. A Italia le serbian los penaltis recordandonos a esa Eurocopa de 2021, pero esta vez seria distinto",
                        "Pio Esposito mandó el balón a la grada, Bosnia no falló, pero Bryan Cristante y su remate al larguero, dictaron una pena repentina para Italia, que se encargó de certificarla Esmir Bajraktarevic. Italia seguía sin ir al mundial después de 12 años, y Bosnia volvía trás 12 años.",
                      ],
                      [
                        "Los suecos empezarón fuerte ante Ucrania, a los 5 minutos y gran pase de Benjamin Nygren dejó a Victor Gyokeres rematando solo frente a porteria, poniendo el 0-1, Gabriel Gudmunsson se subió a la moto y con un gran sprint estuvó a punto de poner tierra de por medio, pero el palo dijo que no",
                        "En la segunda parte, con un saque milagroso del portero sueco Kristoffer Nordfeldt asistió a Gyokeres que después de escuchar las críticas, marcaba su doblete poniendo el segundo en el marcador, Gyokeres que aún seguía con hambre, se construyó el mismo una jugada que acabó en un pénalti que el mismo marcaría",
                        "Tras el hat trick de Gyokeres, el partido ya estaba sentenciado aún así Matviy Ponomarenko marcaba el gol de la honra para Ucrania, y dejaba con un 1-3 el resultado final, pasando Suecia a la final sin ninguna molestia",
                        "En la otra semifinal, Hysaj sacó bajo la línea un gran cabezazo de Jan Bednarek, y en los últimos suspiros de la primera parte tras una cagada del mismo Jan Bednarek, Arber Hoxha aprovechó para quitarse a Grabara del medio adelantando a Albania",
                        "En la segunda parte, un gran remate de Piotr Zielinski se marchó por poco del la escuadra de la porteria albanesa, y poco después Nedim Bajrami falló una ocasión clarísima que les acabó pasando factura, ya que a lo 'Dzeko' Lewandowski empataba el partido de cabeza",
                        "y en el 72, con otro zapatazo Piotr Zielinski esta vez no falló culminando una gran remontada polaca que se quedaba con su pase a la final de los play offs",
                        "En la gran final, Suecia empezó de forma energica, Ayari con un gran taconazo, asistió a Elanga que la clavaba en la escuadra marcando el primero, Polonia no tardó en espabilarse, y Nicola Zalewski marcaba el empate 14 minutos después.",
                        "Antes del descanso Gustaf Lagerbielke con un gran testarazo volvía a poner por delante a Suecia, el partido que ya era un tira y afloja siguió con la misma dinamica y en la segunda parte Swiderski volvía a empatar el partido, y no fue hasta el final del partido cuando se definiria",
                        "En el minuto 87, después de una parada de Grabara, Zeneli le pegó al palo, el balón salió rebotado, y un Gyokeres que se estaba redimiendo de la fase clasificatoria, marcaba un gol agonico, que mandaba a Suecia al mundial 8 años después",
                      ],
                      [
                        "En un partido bastante reñido, Martin Valjent abrió el marcador a favor de Eslovaquia con un gran cabezazo a los 6 minutos, pero Kosovo reaccionó y Veldin Hodza empataba en el 21 el partido",
                        "A minutos del final de la primera parte, una falta de entendimiento provocó que un tiro libre de Lukas Haraslin que no llevaba mucho peligro acabara en gol, aún así en el inicio de la segunda mitad Fisnik Asllani con un cabezazo hermoso empataba de nuevo",
                        "Y para aumentar la locura, Florent Muslija marcaba de tiro libre para finalmente remontar el partido a favor de Kosovo, en el 73, Dubravka detuvo bien el remate de Hajdari, pero el rebote le cayó a Kreshnik Hajziri que marcaba un 2-4 sensacional",
                        "David Strelec cerraba un partidazo marcando el 3-4 en el 93, que dejaba aún así a Kosovo en la final",
                        "Turquía y Rumania abrieron los play offs jugando a las 18:00, a los 22 minutos Ianis Hagi se encontró con una buena ocasión que acabó mandandó demasiado alto, mientras que Kenan Yildiz y Arda Güler ya empezaban a hacer de las suyas, pero sin acertar en la punteria",
                        "Y no fue hasta la segunda parte en donde con un pase armonioso de Güler, Ferdi Kadioglu marcaba el primero del encuentro adelantando a Turquía, los turcos siguieron intentando, pero un remate de Yildiz que pegó en el travesaño y las paradas del guardameta del Celta Radu mantuvieron el resultado",
                        "Por parte de los rumanos, se encontraron con el palos tras el remates de Ratiu y con eso, Turquía se acercaba más de clasificar al mundial",
                        "En la gran final para el repechaje Kosovo tuvo la primera con un gran remate de Fisnik Asllani que primero detuvo Cakir y que luego pegó en el larguero, poco después con una gran jugada de Yildiz, Akturkoglu se quedaba solo frente a la porteria, pero un mal control de su parte hizo que no pudiera tirar",
                        "Ya en la segunda parte, Kokcu estaba a nada de marcar el primero, pero el mismo Akturkoglu le quitó el gol para marcar el suyo propio, adelantando de todas formas a Turquía en el marcador, Kenan Yildiz siguió con su masterclass, y a pesar de que pudo haber marcado, Turquía ganó y clasificaba al mundial",
                      ],
                      [
                        "En el partido entre republicas, se vió una primera parte de locura, en donde todo empezó trás un penalti sobre Nathan Collins provocado por Vladimir Darida, que evidentemente Troy Parrot se encargó de marcar para adelantar a los irlandeses y trás una jugada con muchas carambolas, Matej Kovar marcó en propia",
                        "Republica Checa que a los 23 minutos ya perdía 0-2, volvía a ver la esperanza tras que el arbitro pitara penalti debido a un claro agarrón sobre Ladislav Krejci que Patrick Schick marcaría con una clase inigualable para recortar distancias",
                        "Ya en los últimos minutos, con un gran testarazo, el mismo Ladislav Krejci marcaba el empate que mandaba el encuentro a la prórroga, en donde Tomas Soucek la tuvo para poner la remontada, pero trás un mal remate la acabó mandando a las nubes y con eso el partido se iba a los penaltis",
                        "En la tanda el pobre Matej Kovar que se había marcado en propia, detuvo el lanzamiento de Alan Browne dejando la responsabilidad a Jan Kliment que marcaba un gran penalti para mandar a los checos a la final",
                        "En la otra semifinal se vió el partido más desigual en donde Stole Dimitrievski tuvo que detener un potente remate de Hojbjerg que iba a ser el 1-0, pero en la segunda parte, en una jugada llena de errores de ambos equipos, Mikkel Damsgaard marcaba el 1-0 a favor de los daneses",
                        "9 minutos después trás un gran centro de Mikkel Damsgaard, este asistió a un Gustav Isaksen que un minuto después aprovechó el rechace de un gran paradón de Dimitrievski para marcar un doblete fulminante que Christian Norgaard evitando que Eriksen marcara un gol olímpico, puso el 4-0 definitivo",
                        "Haciendo que Republica Checa se vea con la Dinamarca del potencial para disputarse el pase al mundial",
                        "En la final, Republica Checa se adelantó a los 3 minutos con una volea impresionante de Pavel Sulc que dejaba a Dinamarca sin palabras, Pavel Sulc y Matej Kover se convirtieron en los protagonistas de la primera parte, Kovar parando un gran tiro libre y Pavel Sulc deslumbrando con su visión de juego.",
                        "Cosa que pudo haber hecho que Republica Checa pusiera tierra de por medio, pero Lukas Provod no pudo materializar la ocasión. En el 71, Joachim Anderser ponía las tablas en el marcador con un gran cabezazo, llevando el partido a la prórroga",
                        "En la prórroga, Ladislav Krejci que fue clave contra Republica de Irlanda marcaba el 2-1 en el 100 de partido, pero el delantero el Bodo/Glimt Kasper Hogh empató en el 110 haciendo su tan conocida celebración cosa que llevó el partido a la tanda de penaltis",
                        "Dinamarca falló 3 penaltis en la tanda, Republica Checa solo 1, y con el lanzamiento acertado de Michel Sadilek, Republica Checa volvía al mundial 20 años después.",
                      ],
                      [
                        "En los play offs del resto del mundo, Bolivia se enfrentaba a Surinam en un partido en donde Bolivia empezó fuerte con un gran disparo de Roberto Fernadéz que repeló el guardameta de Surinam",
                        "Trás otra jugada de calidad de Bolivia, Monteiro acabó rematando hacía atrás, fallando estrepitosamente, el partido continuó su rumbo, y Guillermo Viscarra salvaba a Bolivia con una gran parada que evitaba el 0-1",
                        "Ya en la segunda parte, Van Gelderen aprovechó una pelota suelta y marcaba el primero para adelantar a Surinam, pero el espiritu boliviano seguía firme y en el 72 Paniagua con un tiro ajustadísimo al palo largo marcaba el empate para Bolivia",
                        "Poco después Miguelito marcaba de penalti el 2-1 que certificaba la remontada de Bolivia, que con el corazón más encendido que nunca pasan a la final a enfrentarse a Irak",
                        "En la otra ruta, Nueva Caledonia se enfrentaba a los Reggie Boyz Jamaica, y como era de esperarse, Jamaica dominó el partido y Bailey Cadamarteri aprovechó un balón muerto en el área para marcar el 1-0",
                        "Los caledonios, probaron suerte y con un tiro desde su campo Athale casí marca un golazo que empataría el encuentro, el resto del partido los porteros se convirtieron en las figuras del partido, manteniendo el 1-0 hasta el final, cosa que dejaba a Jamaica en la final ante Republica del Congo",
                        "En la primera final del play off, Jamaica se enfrentaba a una Republica del Congo que queria volver al mundial después de 52 años, y Cédric Bakambu inició el sueño a los 9 minutos, pero se lo anularon por fuera de juego",
                        "Era de esperar que Republica del Congo dominara el encuentro, pero Jamaica pudo haberse adelantado con un remate de Kasey Palmer que acabó en córner. O el disparo lejano de Leon Bailey que se fue rozando el palo",
                        "Bakambu, tuvo la oportunidad de finalmente a marcar, pero su remate lo acabó parando el guardameta Jamaicano. El partido se fue a la prórroga, y Tuanzebe marcaba el gol que mandaba a Republica del Congo al mundial",
                        "En la segunda final del play off, Bolivia quería rozar el milagro ante una Irak que quería volver a pisar el mundial desde el 86, Irak empezó dominando y con un gran tiro libre de Al-Hamadi que sacaba con una gran parada de Viscarra, Irak hacia una demostración de intenciones",
                        "Y pocos minutos después el mismo Al-Hamadi marcaba de cabeza para adelantar a Irak, Bolivia recuperó la fé después de que Paniagua volviera a iluminar el camino con un gran gol por la escuadra, camino que se encargó de oscurecer el capitán de Irak Aymen Hussein, que con su gol, mandaba a Irak al mundial",
                      ],
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
