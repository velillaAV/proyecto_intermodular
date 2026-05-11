# 🚀 Despliegue del Backend

## ❌ Railway - Límite excedido

Si ves "Free plan resource provision limit exceeded", significa que has alcanzado el límite gratuito de Railway.

### 🔄 Alternativas gratuitas:

#### Opción 1: Heroku (Más generoso plan gratuito)
```bash
# Instalar Heroku CLI
npm install -g heroku

# Login
heroku login

# Crear app
cd backend
heroku create tu-app-mundial2026

# Configurar base de datos gratuita
heroku addons:create jawsdb:kitefin

# Desplegar
git push heroku main
```

#### Opción 2: Render (Gratuito)
```bash
# Crear cuenta en render.com
# Conectar tu repo de GitHub
# Seleccionar "Web Service"
# Configurar con Node.js
```

#### Opción 3: Railway con plan pago ($5/mes)
- Ve a railway.app → Settings → Billing
- Actualiza a plan Developer ($5/mes)
- Obtienes 512MB RAM, 1GB disco, dominios personalizados

## Opción 1: Railway (Recomendado - Fácil)

### Paso 1: Crear cuenta en Railway
Ve a [railway.app](https://railway.app) y crea una cuenta gratuita.

### Paso 2: Instalar Railway CLI
```bash
npm install -g @railway/cli
railway login
```

### Paso 3: Desplegar

#### ⚠️ **IMPORTANTE:** Solo se sube el backend

Cuando ejecutas `railway up` desde la carpeta `backend`, **solo se sube el código del backend**, no toda tu aplicación Flutter.

```bash
cd backend  # ← Estás aquí cuando ejecutas railway up
railway init --name "proyecto-intermodular-backend"
railway up  # ← Solo sube: server.js, controllers/, models/, routes/, package.json, etc.
```

#### Opción A: Desde cero (sin GitHub)
```bash
cd backend
railway init --name "mundial2026-backend"
railway up
```

#### Opción B: Conectar tu repo de GitHub
Si tienes el proyecto en GitHub en `tu-usuario/proyecto_intermodular`:

```bash
cd backend
railway init --name "proyecto-intermodular-backend"
railway up
```

**Nota:** Si conectas el repo completo de GitHub, Railway puede detectar automáticamente que es un proyecto Node.js dentro de la carpeta `backend/`.

### Paso 4: Conectar a GitHub (Opcional pero recomendado)
En el dashboard de Railway:
1. Ve a tu proyecto
2. Click en "Connect Repo"
3. Selecciona tu repo `proyecto_intermodular`
4. Railway se actualizará automáticamente cuando hagas push a GitHub

### Paso 4: Configurar Base de Datos
En el dashboard de Railway:
1. Agrega un plugin de MySQL
2. Copia las credenciales generadas
3. Configura las variables de entorno en Railway

### Paso 5: Actualizar tu app Flutter
Cambia en `lib/services/LogicaJugadores.dart`:
```dart
final String baseUrl = 'https://tu-proyecto-railway.up.railway.app';
```

## Opción 2: Heroku

### Paso 1: Instalar Heroku CLI
```bash
npm install -g heroku
heroku login
```

### Paso 2: Crear app
```bash
cd backend
heroku create tu-app-mundial2026
```

### Paso 3: Configurar base de datos
```bash
heroku addons:create jawsdb:kitefin
```

### Paso 4: Desplegar
```bash
git push heroku main
```

## Opción 3: VPS (DigitalOcean, AWS, etc.)

Para un control total, puedes usar un VPS:
1. Instalar Node.js y MySQL en el servidor
2. Subir tu código
3. Configurar nginx como proxy reverso
4. Obtener certificado SSL con Let's Encrypt

## 🔧 Configuración de Variables de Entorno

Para producción, configura estas variables:

```
DB_HOST=tu-host-de-bd
DB_USER=tu-usuario
DB_PASSWORD=tu-password
DB_NAME=tu-base-datos
DB_PORT=3306
```

## 📱 Actualizar App Flutter

Después de desplegar, actualiza la URL base en:
- `lib/services/LogicaJugadores.dart`
- `lib/services/LogicaLigas.dart`
- `lib/services/LogicaUsuarios.dart`

Cambia:
```dart
final String baseUrl = 'http://localhost:3000';
```

Por:
```dart
final String baseUrl = 'https://tu-dominio.com';
```