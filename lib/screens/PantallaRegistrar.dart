import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_intermodular/config/constantes/colors.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/translations/users/languagesPantallaRegistrar.dart';
import 'package:proyecto_intermodular/config/utils/Camera.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/controllers/UserControllers.dart';
import 'package:proyecto_intermodular/screens/PantallaInicioSesion.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';


class PantallaRegistrar extends StatefulWidget {
  const PantallaRegistrar({super.key});

  @override
  State<PantallaRegistrar> createState() => _PantallaRegistrarState();
}

const List<String> listaLugares = <String>[
  'Zaragoza',
  'Huesca',
  'Teruel',
  'Frankfurt',
];
typedef EntradaMenu = DropdownMenuEntry<String>;

class _PantallaRegistrarState extends State<PantallaRegistrar> {
  


  void _aceptar() {
    if (_nombre.isEmpty) { //Los 4 primeros son simples, si los campos estan vacios, saltan
      print("El campo (nombre) está vacio");
      const snackBarNombre = SnackBar(
        content: Text("El campo (nombre) está vacio"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarNombre);

    } else if (_contrasena.isEmpty) {
      print("El campo (contraseña) está vacio");
      const snackBarContrasena = SnackBar(
        content: Text("El campo (contraseña) está vacio"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarContrasena);

    } else if (_contrasenaRepetida.isEmpty) {
      print("El campo (contraseña repetida) está vacio");
      const snackBarContrasena = SnackBar(
        content: Text("El campo (contraseña) está vacio"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarContrasena);

    } else if (_edad == 0) {
      print("El campo (edad) está vacio");
      const snackBarEdad = SnackBar(
        content: Text("El campo (edad) está vacio"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarEdad);

    } else if (_contrasena != _contrasenaRepetida) { //Si la contraseña repetida no es la mimsa que la otra salta
      print("La contraseña no es igual que la repetida");
      const snackBarContrasenaRepetida = SnackBar(
        content: Text("La contraseña no es igual que la repetida"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarContrasenaRepetida);

    } else if (!_tickONo) { //Si no ha aceptado los terminos salta
      print("No están aceptados los terminos");
      const snackBarTerminos = SnackBar(
        content: Text("No están aceptados los terminos"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarTerminos);

    } else if(Logicausuario.mismoNombre(_nombre)) { //Si existe un usuario con el mismo nombre salta
      const snackBarUsuario = SnackBar(
        content: Text("El usuario ya existe")
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarUsuario);

    } 
    
     
    
    else { //Si todo esta correcto, se crea el usuario
      UserControllers.creacionYInsercionDeUsuario(_nombre, _contrasena, _edad, _tratamiento, _lugarNacimiento, _fotoRuta, false); //Con este metodo de UserControllers, se crea y se inserta el usuario a la vez
   
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pantallainiciosesion()),
      );
    }
  }

  void _cancelar() { //Si el usuario pulsa cancelar se le envia de vuelta a Pantalla de Inicio de sesion
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Pantallainiciosesion()),
    );
  }

  String _nombre = "";

  String _contrasena = "";

  String _contrasenaRepetida = "";

  String _tratamiento = "Sr";

  int _edad = 0;

  String _lugarNacimiento = listaLugares.first;

  bool _tickONo = false;

  String? _fotoRuta;

//Inicializamos la lista desplegable que usaremos para el lugar de nacimiento
  static final List<EntradaMenu> menuEntries =
      UnmodifiableListView<EntradaMenu>(
        listaLugares.map<EntradaMenu>(
          (String name) => EntradaMenu(value: name, label: name),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Color colorBotonTick(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      
      appBar: AppBar(
        flexibleSpace:  Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [const Color.fromARGB(255, 6, 58, 231), Colors.red, Colors.green],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: Dimensiones.paddingEnano),
            Text(
              Languagespantallaregistrar.getTexto(Languagespantallaregistrar.registrar),
              style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
            ),
          ],
        ),
        backgroundColor: Colorcetes.appBarColor,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Languagespantallaregistrar.getTexto(Languagespantallaregistrar.tratamiento),
                                style: TextStyle(fontSize: Dimensiones.paddingMediano),
                              ),
                              SizedBox(width: Dimensiones.paddingMediano),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Sr",
                                    groupValue: _tratamiento,
                                    onChanged: (value) {
                                      setState(() {
                                        _tratamiento = value!;
                                      });
                                    },
                                  ),
                                  Text("Sr"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Sra",
                                    groupValue: _tratamiento,
                                    onChanged: (value) {
                                      setState(() {
                                        _tratamiento = value!;
                                      });
                                    },
                                  ),
                                  Text("Sra"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensiones.paddingMediano),
                          Container(
                            width: 500,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: Languagespantallaregistrar.getTexto(Languagespantallaregistrar.nombre),
                                  ),
                                  onChanged: (value) {
                                    _nombre = value;
                                  },
                                ),
                                SizedBox(height: Dimensiones.paddingMediano),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: Languagespantallaregistrar.getTexto(Languagespantallaregistrar.contrasena),
                                  ),
                                  onChanged: (value) {
                                    _contrasena = value;
                                  },
                                ),
                                SizedBox(height: Dimensiones.paddingMediano),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: Languagespantallaregistrar.getTexto(Languagespantallaregistrar.repitecontrasena),
                                  ),
                                  onChanged: (value) {
                                    _contrasenaRepetida = value;
                                  },
                                ),
                                SizedBox(height: Dimensiones.paddingMediano),
                                Row(
                                  children: [
                                    Text(Languagespantallaregistrar.getTexto(Languagespantallaregistrar.subeFoto)),
                                    SizedBox(width: 30),
                                    FloatingActionButton.extended(
                                      label: Text(Languagespantallaregistrar.getTexto(Languagespantallaregistrar.galeria)),
                                      onPressed: () async {
                                        final path =
                                            await CameraGalleryService()
                                                .selectPhoto();
                                        if (path == null) return;
                                        setState(() {
                                          _fotoRuta = path;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 30),
                                    FloatingActionButton.extended(
                                      label: Text(Languagespantallaregistrar.getTexto(Languagespantallaregistrar.tomarFoto)),
                                      onPressed: () async {
                                        final path =
                                            await CameraGalleryService()
                                                .takePhoto();
                                        if (path == null) return;
                                        setState(() {
                                          _fotoRuta = path;
                                        });
                                      },
                                    ),
                                  ],
                                ),

                                SizedBox(height: Dimensiones.paddingMediano),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: Languagespantallaregistrar.getTexto(Languagespantallaregistrar.edad),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    _edad = int.parse(value);
                                  },
                                ),
                                SizedBox(height: Dimensiones.paddingMediano),
                                DropdownMenu(
                                  label: Text(Languagespantallaregistrar.getTexto(Languagespantallaregistrar.lugarNacimiento)),
                                  initialSelection: listaLugares.first,
                                  onSelected: (String? value) {
                                    setState(() {
                                      _lugarNacimiento = value!;
                                    });
                                  },
                                  dropdownMenuEntries: menuEntries,
                                ),
                                SizedBox(height: Dimensiones.paddingMediano),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languagespantallaregistrar.getTexto(Languagespantallaregistrar.aceptarTerminos),
                                      style: TextStyle(fontSize: Dimensiones.paddingMediano),
                                    ),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor:
                                          WidgetStateProperty.resolveWith(
                                            colorBotonTick,
                                          ),
                                      value: _tickONo,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _tickONo = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensiones.paddingMediano),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: _aceptar,
                                      style: CustomStyles.estiloBotones,
                                      child: Row(children: [Text(Languagespantallaregistrar.getTexto(Languagespantallaregistrar.aceptar))]),
                                    ),
                                    SizedBox(height: Dimensiones.paddingMediano),
                                    ElevatedButton(
                                      onPressed: _cancelar,
                                      style: CustomStyles.estiloBotones,
                                      child: Row(children: [Text(Languagespantallaregistrar.getTexto(Languagespantallaregistrar.cancelar))]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
