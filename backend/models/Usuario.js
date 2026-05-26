const { getConnection } = require('../config/database');

class Usuario {
  constructor(id, nombre, contrasena, genero, edad, lugarNacimiento, fotoRuta, isAdmin, isBlocked) {
    this.id = id;
    this.nombre = nombre;
    this.contrasena = contrasena;
    this.genero = genero;
    this.edad = edad;
    this.lugarNacimiento = lugarNacimiento;
    this.fotoRuta = fotoRuta;
    this.isAdmin = isAdmin;
    this.isBlocked = isBlocked;
  }

  static async getAll() {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute('SELECT * FROM usuarios');
      return rows.map(row => new Usuario(
        row.id,
        row.nombre,
        row.contrasena,
        row.genero,
        row.edad,
        row.lugarNacimiento,
        row.fotoRuta,
        row.isAdmin,
        row.isBlocked
      ));
    } finally {
      connection.release();
    }
  }

  static async getByNombre(nombre) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM usuarios WHERE nombre = ?',
        [nombre]
      );
      if (rows.length === 0) return null;

      const row = rows[0];
      return new Usuario(
        row.id,
        row.nombre,
        row.contrasena,
        row.genero,
        row.edad,
        row.lugarNacimiento,
        row.fotoRuta,
        row.isAdmin,
        row.isBlocked
      );
    } finally {
      connection.release();
    }
  }

  static async update(id, nombre, lugarNacimiento) {
    const connection = await getConnection();
    try {
      await connection.execute(
        'UPDATE usuarios SET nombre = ?, lugarNacimiento = ? WHERE id = ?',
        [nombre, lugarNacimiento, id]
      );
      return await Usuario.getById(id);
    } finally {
      connection.release();
    }
  }

  static async delete(id) {
    const connection = await getConnection();
    try {
      await connection.execute('DELETE FROM usuarios WHERE id = ?', [id]);
    } finally {
      connection.release();
    }
  }

  static async getById(id) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM usuarios WHERE id = ?',
        [id]
      );
      if (rows.length === 0) return null;

      const row = rows[0];
      return new Usuario(
        row.id,
        row.nombre,
        row.contrasena,
        row.genero,
        row.edad,
        row.lugarNacimiento,
        row.fotoRuta,
        row.isAdmin,
        row.isBlocked
      );
    } finally {
      connection.release();
    }
  }

  static async create(usuario) {
    const connection = await getConnection();
    try {
      const [result] = await connection.execute(
        'INSERT INTO usuarios (nombre, contrasena, genero, edad, lugarNacimiento, fotoRuta, isAdmin, isBlocked) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          usuario.nombre,
          usuario.contrasena,
          usuario.genero || null,
          usuario.edad || null,
          usuario.lugarNacimiento || null,
          usuario.fotoRuta || null,
          usuario.isAdmin ? 1 : 0,
          usuario.isBlocked ? 1 : 0
        ]
      );
      const insertId = result.insertId;
      return await Usuario.getById(insertId);
    } finally {
      connection.release();
    }
  }
}

module.exports = Usuario;