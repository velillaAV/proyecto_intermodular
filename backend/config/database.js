require('dotenv').config();
const mysql = require('mysql2/promise');

const DB_HOST = process.env.DB_HOST || 'localhost';
const DB_USER = process.env.DB_USER || 'root';
const DB_PASSWORD = process.env.DB_PASSWORD || '';
const DB_NAME = process.env.DB_NAME || 'mundial2026_app';
const DB_PORT = process.env.DB_PORT ? Number(process.env.DB_PORT) : 3306;

// Crear pool de conexiones
const pool = mysql.createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME,
  port: DB_PORT,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

console.log('DB_HOST:', DB_HOST);
console.log('DB_PORT:', DB_PORT);
console.log('DB_USER:', DB_USER);
console.log('DB_PASSWORD:', DB_PASSWORD ? 'YES' : 'NO');
console.log('DB_NAME:', DB_NAME);

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