
import 'package:proyecto_intermodular/config/translations/languagesInicioSesion.dart';

class Languagesgestionproductos {
  static int idiomaSeleccionado = Languagesiniciosesion.idiomaSeleccionado;

  static List<String> noProdcutos = ['No se ha encontrado nigún producto', 'No product found','Aucun produit trouvé'];
  static List<String> precio= ['precio', 'price','Aucun produit trouvé'];
  static List<String> descripcion= ['descripcion', 'description','description'];
  static List<String> crearProducto= ['Crear producto', 'Create product','Créer un produit'];
  static List<String> volver= ['Volver', 'Back','retour'];

  static String getTexto(List<String> texto){
      return texto[idiomaSeleccionado];
  }
}