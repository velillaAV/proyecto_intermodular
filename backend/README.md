# Backend API para Flutter - MySQL

Este es un backend simple construido con Node.js, Express y MySQL para conectar con una aplicación Flutter.

## Estructura del proyecto

```
backend/
├── config/
│   └── database.js          # Configuración de conexión a MySQL
├── controllers/
│   └── usuarioController.js # Lógica de negocio para usuarios
├── models/
│   └── Usuario.js           # Modelo de datos para Usuario
├── routes/
│   └── usuarios.js          # Definición de rutas REST
├── .env                     # Variables de entorno
├── package.json             # Dependencias y scripts
├── script.sql               # Script para crear la base de datos
└── server.js                # Punto de entrada del servidor
```

## Instalación y configuración

### 1. Instalar dependencias

```bash
cd backend
npm install
```

### 2. Configurar la base de datos

- Instala MySQL en tu sistema
- Crea una base de datos y ejecuta el script `script.sql`
- Actualiza las variables en `.env` con tus credenciales de MySQL

### 3. Ejecutar el servidor

```bash
npm start
```

El servidor se ejecutará en `http://localhost:3000`

## Endpoints de la API

- `GET /usuarios` - Obtener todos los usuarios
- `GET /usuarios/:id` - Obtener usuario por ID
- `POST /usuarios` - Crear nuevo usuario
- `PUT /usuarios/:id` - Actualizar usuario
- `DELETE /usuarios/:id` - Eliminar usuario

## Conexión con Flutter

### Configuración

1. Agrega el paquete `http` a tu `pubspec.yaml`:
   ```yaml
   dependencies:
     http: ^1.2.1
   ```

2. Ejecuta `flutter pub get`

### Ejemplo de uso

En tu aplicación Flutter, importa el paquete:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
```

Para hacer una petición GET:

```dart
final response = await http.get(Uri.parse('http://localhost:3000/usuarios'));
if (response.statusCode == 200) {
  final usuarios = json.decode(response.body);
  // Procesar los datos
}
```

### Consideraciones importantes

- **CORS**: El backend incluye configuración CORS para permitir conexiones desde Flutter
- **Puertos**: Asegúrate de que el puerto 3000 esté disponible
- **IP vs localhost**: Si pruebas en un dispositivo físico, usa la IP de tu máquina en lugar de localhost
- **HTTPS**: Para producción, considera usar HTTPS

## Desarrollo

Para desarrollo con recarga automática:

```bash
npm run dev
```

Esto requiere `nodemon` instalado como dependencia de desarrollo.