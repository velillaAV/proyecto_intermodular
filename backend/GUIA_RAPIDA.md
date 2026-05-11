# 🚀 Guía Rápida: Despliegue en Railway

## Paso 1: Preparación
```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Login
railway login
```

## Paso 2: Desplegar tu proyecto

#### 📁 **Importante:** Solo se sube el backend
Cuando ejecutas `railway up` desde `backend/`, **solo se despliega el código del servidor**, no tu app Flutter.

```bash
cd backend  # ← Ejecuta desde aquí

# Opción 1: Nombre personalizado
railway init --name "proyecto-intermodular-backend"

# Opción 2: Dejar que Railway elija el nombre
railway init

# Desplegar SOLO el backend
railway up
```

## Paso 3: Configurar Base de Datos
1. Ve al dashboard de Railway
2. En tu proyecto, agrega el plugin "MySQL"
3. Railway creará automáticamente la base de datos
4. Copia las credenciales que te da Railway

## Paso 4: Configurar Variables de Entorno
En el dashboard de Railway, ve a "Variables" y configura:
- `DB_HOST` = (el host que te dio Railway)
- `DB_USER` = (el usuario que te dio Railway)
- `DB_PASSWORD` = (la password que te dio Railway)
- `DB_NAME` = (el nombre que te dio Railway)
- `DB_PORT` = (el puerto que te dio Railway)

## Paso 5: Inicializar la Base de Datos
Una vez desplegado, ejecuta:
```bash
railway run node init_db.js
```

## Paso 6: Obtener la URL de tu API
En el dashboard de Railway, ve a "Settings" > "Domains" para ver la URL pública de tu backend.

## Paso 7: Actualizar tu App Flutter
Edita `lib/config/api_config.dart`:
```dart
static const String baseUrl = 'https://tu-proyecto-railway.up.railway.app';
```

¡Listo! Ahora tu app funcionará desde cualquier dispositivo y los datos se guardarán permanentemente.