# 🚀 Despliegue Alternativo: Heroku (Gratuito)

## Paso 1: Instalar Heroku CLI
```bash
npm install -g heroku
heroku login
```

## Paso 2: Preparar el proyecto
```bash
cd backend

# Crear archivo para Heroku
echo 'web: node server.js' > Procfile
echo 'node_modules' > .gitignore
```

## Paso 3: Crear app en Heroku
```bash
heroku create tu-app-mundial2026
```

## Paso 4: Configurar base de datos gratuita
```bash
# Agregar base de datos MySQL gratuita
heroku addons:create jawsdb:kitefin

# Ver las credenciales
heroku config:get JAWSDB_URL
```

## Paso 5: Configurar variables de entorno
```bash
# Heroku detectará automáticamente las variables de .env
# Pero puedes configurar manualmente:
heroku config:set NODE_ENV=production
```

## Paso 6: Desplegar
```bash
git add .
git commit -m "Deploy to Heroku"
git push heroku main
```

## Paso 7: Inicializar base de datos
```bash
heroku run node init_db.js
```

## Paso 8: Obtener la URL
```bash
heroku domains
# O ve a dashboard.heroku.com
```

## Paso 9: Actualizar tu app Flutter
En `lib/config/api_config.dart`:
```dart
static const String baseUrl = 'https://tu-app-mundial2026.herokuapp.com';
```

## ✅ Ventajas de Heroku:
- ✅ 550 horas gratuitas/mes
- ✅ Base de datos MySQL gratuita
- ✅ Despliegue automático desde Git
- ✅ Sin límites de Railway