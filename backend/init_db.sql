-- Crear tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL UNIQUE,
  contrasena VARCHAR(255) NOT NULL,
  genero VARCHAR(50),
  edad INT,
  lugarNacimiento VARCHAR(255),
  fotoRuta VARCHAR(255),
  isAdmin BOOLEAN DEFAULT FALSE,
  isBlocked BOOLEAN DEFAULT FALSE
);

-- Insertar usuarios fijos
INSERT INTO usuarios (nombre, contrasena, genero, edad, lugarNacimiento, fotoRuta, isAdmin, isBlocked) VALUES
('Alvaro', 'Alvaro', 'Masculino', 25, 'Desconocido', '', FALSE, FALSE),
('Dario', 'Dario', 'Masculino', 25, 'Desconocido', '', FALSE, FALSE),
('Edgar', 'Edgar', 'Masculino', 25, 'Desconocido', '', FALSE, FALSE),
('admin', 'admin', 'Masculino', 30, 'Desconocido', '', TRUE, FALSE);

-- Crear tabla de jugadores
CREATE TABLE IF NOT EXISTS jugadores (
  id_jugador INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  pais VARCHAR(255),
  valor_clausula BIGINT,
  valor_venta BIGINT,
  posicion VARCHAR(10) NOT NULL
);

-- Insertar datos de jugadores
INSERT INTO jugadores (nombre, pais, valor_clausula, valor_venta, posicion) VALUES
('Nikola Vasijl', 'images/logoBosnia.png', 14000000, 4000000, 'POR'),
('Martin Zlomislic', 'images/logoBosnia.png', 8000000, 1000000, 'POR'),
('Sead Kolasinac', 'images/logoBosnia.png', 18000000, 6000000, 'DEF'),
('Tarik Muharemovic', 'images/logoBosnia.png', 40000000, 20000000, 'DEF'),
('Amar Dedic', 'images/logoBosnia.png', 38000000, 18000000, 'DEF'),
('Nikola Katic', 'images/logoBosnia.png', 8000000, 2000000, 'DEF'),
('Marcos Senesi', 'images/logoArgentina.png', 22000000, 12000000, 'DEF'),
('Nathan Ngoy', 'images/logoBelgica.png', 22000000, 12000000, 'DEF'),
('Renato Veiga', 'images/logoPortugal.png', 22000000, 12000000, 'DEF'),
('Benjamin Tahirovic', 'images/logoBosnia.png', 12000000, 4000000, 'CEN'),
('Amar Memic', 'images/logoBosnia.png', 12000000, 4000000, 'CEN'),
('Amir Hadziahmetovic', 'images/logoBosnia.png', 12000000, 4000000, 'CEN'),
('Pape Gueye', 'images/logoSenegal.png', 42000000, 22000000, 'CEN'),
('Sebastian Berhalter', 'images/logoUSA.png', 20000000, 10000000, 'CEN'),
('Ermedin Demirovic', 'images/logoBosnia.png', 42000000, 22000000, 'DEL'),
('Haris Tabakovic', 'images/logoBosnia.png', 11000000, 3000000, 'DEL'),
('Edin Dzeko', 'images/logoBosnia.png', 10000000, 2000000, 'DEL'),
('Mikel Oyarzabal', 'images/logoEspana.png', 50000000, 30000000, 'DEL'),
('Alberto Moleiro', 'images/logoEspana.png', 50000000, 30000000, 'DEL'),
('Mika Godts', 'images/logoBelgica.png', 40000000, 20000000, 'DEL');