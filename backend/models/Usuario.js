const { getConnection } = require('../config/database');

class Usuario {
  constructor(id, nombre, email) {
    this.id = id;
    this.nombre = nombre;
    this.email = email;
  }

  // Obtener todos los usuarios
  static async getAll() {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute('SELECT * FROM usuarios');
      return rows.map(row => new Usuario(row.id, row.nombre, row.email));
    } finally {
      connection.release();
    }
  }

  // Obtener usuario por ID
  static async getById(id) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute('SELECT * FROM usuarios WHERE id = ?', [id]);
      if (rows.length === 0) return null;
      const row = rows[0];
      return new Usuario(row.id, row.nombre, row.email);
    } finally {
      connection.release();
    }
  }

  // Crear nuevo usuario
  static async create(nombre, email) {
    const connection = await getConnection();
    try {
      const [result] = await connection.execute(
        'INSERT INTO usuarios (nombre, email) VALUES (?, ?)',
        [nombre, email]
      );
      return new Usuario(result.insertId, nombre, email);
    } finally {
      connection.release();
    }
  }

  // Actualizar usuario
  static async update(id, nombre, email) {
    const connection = await getConnection();
    try {
      await connection.execute(
        'UPDATE usuarios SET nombre = ?, email = ? WHERE id = ?',
        [nombre, email, id]
      );
      return new Usuario(id, nombre, email);
    } finally {
      connection.release();
    }
  }

  // Eliminar usuario
  static async delete(id) {
    const connection = await getConnection();
    try {
      await connection.execute('DELETE FROM usuarios WHERE id = ?', [id]);
      return true;
    } finally {
      connection.release();
    }
  }
}

module.exports = Usuario;