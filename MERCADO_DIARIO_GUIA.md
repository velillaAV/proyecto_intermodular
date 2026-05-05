# Sistema de Mercado Diario - Guía de Instalación

## Cambios Realizados

### 1. **Backend (Node.js/Express)**

#### Nuevos modelos:
- `backend/models/MercadoDiario.js` - Modelo para gestionar mercados diarios

#### Nuevos controladores:
- `backend/controllers/mercadoController.js` - Lógica de mercado diario

#### Nuevas rutas:
- `backend/routes/mercado.js` - Endpoints del mercado

#### Actualizaciones en `backend/server.js`:
- Servidor ahora sirve archivos estáticos en `/assets`
- Incluye scheduler automático para actualizar mercados a las 00:00
- Importa rutas de mercado

#### Actualización en `backend/package.json`:
- Agregada dependencia: `node-schedule` para tareas automáticas

### 2. **Base de Datos (MySQL)**

Ejecutar el siguiente SQL para crear la tabla de mercado:

```sql
CREATE TABLE IF NOT EXISTS mercado_diario (
  id_mercado INT AUTO_INCREMENT PRIMARY KEY,
  id_liga INT NOT NULL UNIQUE,
  jugadores_json JSON NOT NULL,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_proximo_cambio DATETIME NOT NULL,
  FOREIGN KEY (id_liga) REFERENCES ligas(id_liga) ON DELETE CASCADE,
  INDEX idx_liga (id_liga)
);
```

O ejecutar el archivo: `backend/mercado_diario.sql`

### 3. **Frontend (Flutter)**

#### Nuevos modelos:
- `lib/models/ModeloMercadoDiario.dart` - Modelos para mercado diario

#### Nuevos servicios:
- `lib/services/ServicioMercadoDiario.dart` - Servicio API de mercado

#### Nuevos widgets:
- `lib/widgets/WidgetMercadoDiario.dart` - Widget independiente de mercado diario

#### Actualización en `lib/widgets/Mercado.dart`:
- Integrado nuevo sistema de mercado diario
- Cuenta atrás en tiempo real
- Fallback a mercado local si la API falla
- Carga de imágenes desde servidor

#### Actualización en `lib/services/LogicaJugadores.dart`:
- Rutas de imágenes convertidas a URLs del servidor

---

## Instrucciones de Instalación

### Backend:

1. **Instalar dependencias:**
   ```bash
   cd backend
   npm install
   ```

2. **Crear tabla en BD:**
   - Ejecutar el archivo `mercado_diario.sql` en tu base de datos MySQL
   - O ejecutar manualmente el SQL incluido arriba

3. **Iniciar servidor:**
   ```bash
   npm run dev
   ```
   O en producción:
   ```bash
   npm start
   ```

### Frontend:

1. **El código Flutter se actualiza automáticamente**
   - Los servicios y widgets ya están integrados
   - Las imágenes se cargarán desde `http://localhost:3000/assets/images/...`

2. **Cambiar IP del servidor (para móvil):**
   - En `lib/services/LogicaJugadores.dart`, cambiar `localhost` por tu IP
   - En `lib/services/ServicioMercadoDiario.dart`, cambiar `localhost` por tu IP

---

## Características Implementadas

### ✅ Actualización Automática a las 00:00
- Usa `node-schedule` para ejecutar tareas a las 00:00
- Todos los mercados de todas las ligas se actualizan automáticamente
- Se pueden actualizar manualmente desde el endpoint `/mercado/actualizar-todos`

### ✅ Mercado por Liga
- Cada liga tiene su propio mercado independiente
- Solo jugadores no asignados a ninguna plantilla de la liga
- Se guardan en la tabla `mercado_diario`

### ✅ Disponibilidad de Jugadores
- Query SQL filtra jugadores que NO están en ningún equipo de la liga
- Si hay menos de 11 jugadores disponibles, usa todos los disponibles

### ✅ Jugadores Aleatorios sin Repetición
- Cada día selecciona 11 jugadores aleatorios
- Guarda el mercado anterior para evitar repeticiones
- Si quedan pocos jugadores nuevos, usa todos

### ✅ Cuenta Atrás Diaria
- Calcula tiempo hasta la próxima actualización (mañana a las 00:00)
- Se actualiza cada segundo
- Formato: HH:MM:SS

### ✅ Imágenes Cargan en Móvil
- Servidor ahora sirve archivos estáticos en `/assets`
- Las imágenes se cargan como URLs HTTP
- Compatible con móvil (cambiar `localhost` por IP)

---

## Configuración de IP para Móvil

Para que las imágenes y datos carguen en el móvil:

1. **En la máquina donde corre el servidor:**
   - Obtener IP: `ipconfig` (Windows) o `ifconfig` (Linux/Mac)
   - Ejemplo: `192.168.1.100`

2. **En Flutter (`lib/services/ServicioMercadoDiario.dart`):**
   ```dart
   final String baseUrl = 'http://192.168.1.100:3000';
   ```

3. **En Flutter (`lib/services/LogicaJugadores.dart`):**
   ```dart
   final String baseUrl = 'http://192.168.1.100:3000';
   ```

4. **Asegurar que firewall permite puerto 3000**

---

## Endpoints API

### Obtener Mercado de una Liga
```
GET /mercado/:id_liga
Respuesta:
{
  "mercado": {
    "id_liga": 1,
    "fecha_actualizacion": "2024-01-15T10:30:00",
    "fecha_proximo_cambio": "2024-01-16T00:00:00",
    "tiempoRestante": 39600000
  },
  "jugadores": [
    {
      "id_jugador": 1,
      "nombre": "Jugador",
      "posicion": "POR",
      "pais": "España",
      "valor_clausula": 10000000,
      "valor_venta": 5000000,
      "foto": "/assets/images/jugadores/1.png"
    }
  ]
}
```

### Actualizar Todos los Mercados
```
POST /mercado/actualizar-todos
Respuesta:
{
  "message": "Todos los mercados han sido actualizados"
}
```

---

## Estructura de Carpetas

```
proyecto_intermodular/
├── backend/
│   ├── models/
│   │   └── MercadoDiario.js (NUEVO)
│   ├── controllers/
│   │   └── mercadoController.js (NUEVO)
│   ├── routes/
│   │   └── mercado.js (NUEVO)
│   ├── server.js (ACTUALIZADO)
│   ├── package.json (ACTUALIZADO)
│   └── mercado_diario.sql (NUEVO)
│
├── lib/
│   ├── models/
│   │   └── ModeloMercadoDiario.dart (NUEVO)
│   ├── services/
│   │   ├── ServicioMercadoDiario.dart (NUEVO)
│   │   └── LogicaJugadores.dart (ACTUALIZADO)
│   └── widgets/
│       ├── WidgetMercadoDiario.dart (NUEVO - opcional)
│       └── Mercado.dart (ACTUALIZADO)
│
└── assets/
    └── images/
        ├── (imágenes existentes)
        ├── jugadores/
        │   └── (imágenes de jugadores con IDs como nombres)
        └── (logos de países)
```

---

## Notas Importantes

1. **Imágenes de Jugadores:**
   - Las imágenes deben estar en `assets/images/jugadores/`
   - Nombres: `{id_jugador}.png` (ej: `1.png`, `2.png`)
   - El servidor las sirve en `/assets/images/jugadores/1.png`

2. **Zona Horaria:**
   - El scheduler usa la zona horaria del servidor
   - Para cambiar zona horaria, modificar `schedule.scheduleJob()` en `server.js`

3. **Testing Manual:**
   - Acceder a `http://localhost:3000/mercado/1` para ver mercado de liga 1
   - Las imágenes cargarán desde `http://localhost:3000/assets/images/...`

4. **Producción:**
   - Cambiar `localhost:3000` por dominio/IP real
   - Usar HTTPS en producción
   - Considerar CDN para imágenes

---

## Problemas Comunes

### Las imágenes no cargan en móvil:
- Cambiar `localhost` por IP real del servidor
- Verificar que el firewall permita puerto 3000
- Verificar que el móvil esté en la misma red

### El mercado no se actualiza automáticamente:
- Verificar que `node-schedule` esté instalado
- Ver logs del servidor: `npm run dev`
- Probar endpoint manual: `POST /mercado/actualizar-todos`

### No se encuentran jugadores disponibles:
- Verificar que hay jugadores en la BD que NO están en plantillas
- Ver la query SQL en `mercadoController.js`
- Probar manualmente: `SELECT * FROM jugadores WHERE id_jugador NOT IN (...)`

---

## Próximas Mejoras (Opcional)

- [ ] Notificaciones cuando mercado se actualiza
- [ ] Historial de mercados anteriores
- [ ] Estadísticas de jugadores en mercado
- [ ] Precio dinámico basado en oferta/demanda
- [ ] Interfaz web para administrar mercados
