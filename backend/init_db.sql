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
  fotoRutaJugador VARCHAR(255),
  posicion VARCHAR(10) NOT NULL
);

-- Insertar datos de jugadores
INSERT INTO jugadores (nombre, pais, valor_clausula, valor_venta, fotoRutaJugador, posicion) VALUES
('Nikola Vasijl', 'images/logoBosnia.png', 14000000, 4000000, 'images/nikolaVasijl.png', 'POR'),
('Martin Zlomislic', 'images/logoBosnia.png', 8000000, 1000000, 'images/martinZlomislic.png', 'POR'),
('Sead Kolasinac', 'images/logoBosnia.png', 18000000, 6000000, 'images/seadKolasinac.png', 'DEF'),
('Tarik Muharemovic', 'images/logoBosnia.png', 40000000, 20000000, 'images/tarikMuharemovic.png', 'DEF'),
('Amar Dedic', 'images/logoBosnia.png', 38000000, 18000000, 'images/amarDedic.png', 'DEF'),
('Nikola Katic', 'images/logoBosnia.png', 8000000, 2000000, 'images/nikolaKatic.png', 'DEF'),
('Marcos Senesi', 'images/logoArgentina.png', 22000000, 12000000, 'images/marcosSenesi.png', 'DEF'),
('Nathan Ngoy', 'images/logoBelgica.png', 22000000, 12000000, 'images/nathanNgoy.png', 'DEF'),
('Renato Veiga', 'images/logoPortugal.png', 22000000, 12000000, 'images/renatoVeiga.png', 'DEF'),
('Benjamin Tahirovic', 'images/logoBosnia.png', 12000000, 4000000, 'images/benjaminTahirovic.png', 'CEN'),
('Amar Memic', 'images/logoBosnia.png', 12000000, 4000000, 'images/amarMemic.png', 'CEN'),
('Amir Hadziahmetovic', 'images/logoBosnia.png', 12000000, 4000000, 'images/amirHadziahmetovic.png', 'CEN'),
('Pape Gueye', 'images/logoSenegal.png', 42000000, 22000000, 'images/papeGueye.png', 'CEN'),
('Sebastian Berhalter', 'images/logoUSA.png', 20000000, 10000000, 'images/sebastianBerhalter.png', 'CEN'),
('Ermedin Demirovic', 'images/logoBosnia.png', 42000000, 22000000, 'images/ermedinDemirovic.png', 'DEL'),
('Haris Tabakovic', 'images/logoBosnia.png', 11000000, 3000000, 'images/harisTabakovic.png', 'DEL'),
('Edin Dzeko', 'images/logoBosnia.png', 10000000, 2000000, 'images/edinDzeko.png', 'DEL'),
('Mikel Oyarzabal', 'images/logoEspana.png', 50000000, 30000000, 'images/mikelOyarzabal.png', 'DEL'),
('Alberto Moleiro', 'images/logoEspana.png', 50000000, 30000000, 'images/albertoMoleiro.png', 'DEL'),
('Mika Godts', 'images/logoBelgica.png', 40000000, 20000000, 'images/mikaGodts.png', 'DEL');