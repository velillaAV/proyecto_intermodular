import 'package:proyecto_intermodular/models/user.dart';

class Logicausuario {
  static final List<Usuario> _listaUsuarios = [
    Usuario(
      nombre: "Edgar",
      contrasena: "Edgar",
      genero: 'Sr',
      edad: 19,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: false,
    ),
    Usuario(
      nombre: "Alvaro",
      contrasena: "Alvaro",
      genero: 'Sr',
      edad: 21,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: false,
    ),
    Usuario(
      nombre: "Dario",
      contrasena: "Dario",
      genero: 'Sr',
      edad: 19,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: false,
    ),
  ];

  static final List<Usuario> _listaAdmins = [];

  static final List<Usuario> _listaUsuariosAdmins = [
    Usuario(
      nombre: "Edgar",
      contrasena: "Edgar",
      genero: 'Sr',
      edad: 19,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: false,
    ),
    Usuario(
      nombre: "Alvaro",
      contrasena: "Alvaro",
      genero: 'Sr',
      edad: 21,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: false,
    ),
    Usuario(
      nombre: "Dario",
      contrasena: "Dario",
      genero: 'Sr',
      edad: 19,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: false,
    ),
  ];

  static final List<Usuario> _admin = [
    Usuario(
      nombre: "admin",
      contrasena: "admin",
      genero: 'Sr',
      edad: 21,
      lugarNacimiento: 'Zaragoza',
      fotoRuta: null,
      isAdmin: true,
    ),
  ];

  static Usuario usuarioActual = Usuario(
    nombre: "null",
    contrasena: "contrasena",
    genero: "genero",
    edad: 0,
    lugarNacimiento: "lugarNacimiento",
    fotoRuta: "fotoRuta",
    isAdmin: false,
  );

  static void anadirUsuarios(Usuario usuarios) {
    _listaUsuarios.add(usuarios);
    _listaUsuariosAdmins.add(usuarios);
  }

  static void anadirAdmins(Usuario admin) {
    _listaAdmins.add(admin);
    _listaUsuariosAdmins.add(admin);
  }

  static List<Usuario> getListaUsuarios() {
    return _listaUsuarios;
  }

  static List<Usuario> getListaAdmins() {
    return _listaAdmins;
  }

  static List<Usuario> getListaUsuariosAdmins() {
    return _listaUsuariosAdmins;
  }

  static Usuario getUsuarioActual() {
    return usuarioActual;
  }

  static void setUsuarioActual(Usuario usuario) {
    usuarioActual = usuario;
  }

  static Usuario? buscarUsuarioPorNombre(String nombre) {
    for (final usuario in _listaUsuarios) {
      if (usuario.getNombre() == nombre) {
        return usuario;
      }
    }
    return null;
  }

  static bool confirmarBloqueo(String nombre, String contrasena) {
    //Se confirma si el usuario esta bloqueado
    bool validador = false;

    for (int i = 0; i < _listaUsuariosAdmins.length; i++) {
      Usuario u = _listaUsuariosAdmins[i];
      if (u.getNombre() == nombre && u.getContrasena() == contrasena) {
        if (u.isBlocked == true) {
          validador = true;
        }
      }
    }

    return validador;
  }

  static bool confirmarUsuarios(String nombre, String contrasena) {
    //Estos tres metodos sirven para confirmar que las credenciales al iniciar sesion existan en el sistema, y de paso guardamos al usuario en una variable llamado usuario actual
    bool validador = false;

    for (int i = 0; i < _listaUsuarios.length; i++) {
      Usuario u = _listaUsuarios[i];
      if (u.getNombre() == nombre && u.getContrasena() == contrasena) {
        validador = true;
        usuarioActual = u;
      }
    }

    return validador;
  }

  static bool confirmarAdmins(String nombre, contrasena) {
    bool validador = false;

    for (int i = 0; i < _listaAdmins.length; i++) {
      Usuario u = _listaAdmins[i];
      if (u.getNombre() == nombre && u.getContrasena() == contrasena) {
        validador = true;
        usuarioActual = u;
      }
    }

    return validador;
  }

  static bool confirmarAdmin(String nombre, contrasena) {
    bool validador = false;

    for (int i = 0; i < _admin.length; i++) {
      Usuario u = _admin[i];
      if (u.getNombre() == nombre && u.getContrasena() == contrasena) {
        validador = true;
        usuarioActual = u;
      }
    }

    return validador;
  }

  static bool mismoNombre(String nombre) {
    //Se comprueba si el usuario tiene el mismo nombre que otro usuario
    bool validador = false;

    for (int i = 0; i < _listaUsuarios.length; i++) {
      Usuario u = _listaUsuarios[i];
      if (u.getNombre() == nombre) {
        validador = true;
        usuarioActual = u;
      }
    }

    return validador;
  }

  static bool mismoNombreEditarUsuario(String nombre) {
    bool validador = false;

    for (int i = 0; i < _listaUsuariosAdmins.length; i++) {
      Usuario u = _listaUsuariosAdmins[i];
      if (u.getNombre() == nombre) {
        validador = true;
        usuarioActual = u;
      }
    }

    return validador;
  }

  static String? recuperarContrasena(String nombre) {
    //Sirve para devolver la contraseña al usuario
    String contrasena = " ";
    int contadorDiscordancia = 0;
    for (int i = 0; i < _listaUsuarios.length; i++) {
      Usuario u = _listaUsuarios[i];
      if (u.getNombre().compareTo(nombre) == 0) {
        contrasena = u.getContrasena();
      } else {
        contadorDiscordancia++;
      }
    }

    if (contadorDiscordancia == _listaUsuarios.length) {
      //Si las discordancias son las mismas que la cantidad de usuario, significa que el nombre que ha puesto no existe
      return null;
    }
    return contrasena;
  }

  static void eliminarUsuarios(Usuario usuario) {
    if (usuario.getNombre().compareTo("admin") == 0 ||
        usuario.getNombre().compareTo("Edgar") == 0 ||
        usuario.getNombre().compareTo("Alvaro") == 0) {
      //Si es el admin, no se borra
    } else {
      _listaUsuarios.remove(
        _listaUsuarios.elementAt(_listaUsuarios.indexOf(usuario)),
      );
    }
  }

  static Usuario seleccionarUsuario(int ID_User) {
    return _listaUsuarios.elementAt(ID_User);
  }
}
