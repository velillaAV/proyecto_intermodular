const mysql = require('mysql2/promise');

// Log de variables de base de datos para depuración
console.log('DB_HOST:', process.env.DB_HOST);
console.log('DB_PORT:', process.env.DB_PORT);
console.log('DB_NAME:', process.env.DB_NAME);
console.log('DB_USER:', process.env.DB_USER);
console.log('DB_PASSWORD:', process.env.DB_PASSWORD ? '***' : undefined);

// Crear pool de conexiones
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Función para obtener una conexión
const getConnection = async () => {
  try {
    const connection = await pool.getConnection();
    return connection;
    console.log("Conexión correcta a la base de datos")
  } catch (error) {
    console.error('Error al conectar a la base de datos:', error);
    throw error;
  }
};

module.exports = { getConnection };