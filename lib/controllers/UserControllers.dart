import 'package:proyecto_intermodular/models/user.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';

class UserControllers {

  static void creacionYInsercionDeUsuario(String _nombre, String _contrasena, int _edad, String _tratamiento, String _lugarNacimiento, String? _fotoRuta, bool _adminONo) { //Con los parametros recibidos, se crea un usuario y se introduce en la lista especifica
    Usuario usuarioNuevo = new Usuario(
        nombre: _nombre,
        contrasena: _contrasena,
        edad: _edad,
        genero: _tratamiento,
        lugarNacimiento: _lugarNacimiento,
        fotoRuta: _fotoRuta,
        isAdmin: _adminONo
      );
      print(usuarioNuevo);
      if(_adminONo == false) {
         Logicausuario.anadirUsuarios(usuarioNuevo);
         
      }

      if(_adminONo == true) {
        Logicausuario.anadirAdmins(usuarioNuevo);
      }

  }
}