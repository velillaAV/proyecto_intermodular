const fs = require('fs');
const path = require('path');
const { getConnection } = require('./config/database');

async function initDatabase() {
  try {
    const connection = await getConnection();

    // Leer el archivo SQL
    const sqlFilePath = path.join(__dirname, 'init_db.sql');
    const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');

    // Dividir el contenido en declaraciones SQL individuales
    const statements = sqlContent.split(';').filter(stmt => stmt.trim().length > 0);

    // Ejecutar cada declaración
    for (const statement of statements) {
      if (statement.trim()) {
        await connection.execute(statement.trim());
        console.log('Ejecutado:', statement.trim().substring(0, 50) + '...');
      }
    }

    console.log('Base de datos inicializada correctamente.');
    connection.release();
    process.exit(0);
  } catch (error) {
    console.error('Error al inicializar la base de datos:', error);
    process.exit(1);
  }
}

initDatabase();