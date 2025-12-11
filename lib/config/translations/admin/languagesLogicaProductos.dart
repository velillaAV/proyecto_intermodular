
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagescompraswidget {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> nombre1 = ['Pelota del Villarreal', 'Villarreal ball','Bal de Villarreal'];
  static List<String> descripcion1 = ['Pelota del Villarreal que puedes usar para meter golazos como Gerard Moreno', 'Villarreal ball that you can use to score amazing goals like Gerard Moreno','Ballon de Villarreal avec lequel vous pouvez marquer des buts incroyables comme Gerard Moreno'];
  static List<String> nombre2 = ['Camiseta Centenario Villarreal', 'Villarreal Centenary Shirt','Maillot du centenaire de Villarreal'];
  static List<String> descripcion2 = ['Camiseta Centenario del Villarreal del año 2023, lleva el dorsal y nombre de Kiko Femenia', 'Villarreal Centenary shirt from 2023, bearing the number and name of Kiko Femenia','Maillot du centenaire de Villarreal de 2023, portant le numéro et le nom de Kiko Femenia'];
  static List<String> descripcion3 = ['Camiseta de Diego Forlan durante su paso en el Atletico Madrid', 'Diego Forlan jersey during his time at Atletico Madrid','Le maillot de Diego Forlan lors de son passage à le Atletico Madrid'];
  static List<String> nombre3 = ['Camiseta Diego Forlan Atletico de Madrid', 'Diego Forlan Atletico Madrid jersey','Maillot Diego Forlan Atlético Madrid'];
  
  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}