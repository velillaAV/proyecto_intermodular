#!/bin/bash

# Script de despliegue para Railway
# Ejecutar: bash deploy.sh

echo "🚀 Desplegando backend a Railway..."

# Verificar que Railway CLI esté instalado
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI no está instalado."
    echo "Instálalo con: npm install -g @railway/cli"
    exit 1
fi

# Login en Railway (si no está logueado)
railway login

# Crear nuevo proyecto
echo "📦 Creando proyecto en Railway..."
echo "¿Qué nombre quieres para tu proyecto? (presiona Enter para usar 'proyecto-intermodular-backend')"
read -r project_name
project_name=${project_name:-"proyecto-intermodular-backend"}

railway init --name "$project_name"

# Configurar variables de entorno
echo "⚙️  Configurando variables de entorno..."
railway variables set DB_HOST="containers-us-west-XXX.railway.app"
railway variables set DB_USER="root"
railway variables set DB_PASSWORD="tu_password_segura"
railway variables set DB_NAME="railway"
railway variables set DB_PORT="XXXX"

# Desplegar
echo "🚀 Desplegando..."
railway up

echo "✅ Despliegue completado!"
echo "📋 Revisa el dashboard de Railway para obtener la URL de tu backend"
echo "🔗 Conecta tu repo de GitHub desde el dashboard para actualizaciones automáticas"