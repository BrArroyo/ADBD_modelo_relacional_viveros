/**
 * Commands used to create 5 tables in the database: vivero, zona. empleado, producto, cliente.
 * usage:
 *  sudo su postgres
 *  psql
 *  \i vivero.sql
 */

/* Remove all the tables in 'public' schema and create the schema 'public' */ 
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

/* --DROP TABLES-- */
DROP TABLE IF EXISTS vivero;
DROP TABLE IF EXISTS zona;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS tiene;

/* -- CREATE TABLES -- */
/* Create the table 'vivero' */
CREATE TABLE vivero (
  id_vivero INT GENERATED ALWAYS AS IDENTIFY,
  ubicacion VARCHAR(100) NOT NULL,
  PRIMARY KEY(id_vivero)
);

/* Create the table 'zona' */
CREATE TABLE zona (
  id_zona INT GENERATED ALWAYS AS IDENTIFY,
  id_vivero INT,
  nombre_zona VARCHAR(20) NOT NULL,
  numero_ventas INT, --- atributo derivado, se le tiene que añadir un disparador
  PRIMARY KEY(id_zona)
  CONSTRAINT fk_id_vivero 
    FOREIGN KEY(id_vivero) 
      REFERENCES vivero(id_vivero) 
        ON DELETE CASCADE
);

/* Create the table 'producto' */
CREATE TABLE producto (
  id_producto INT GENERATED ALWAYS AS IDENTIFY,
  nombre_producto VARCHAR(255) NOT NULL,
  precio FLOAT,
  numero_stock INT, --- atributo derivado, se le tiene que añadir un disparador
  PRIMARY KEY(id_producto)
);

/* Create the table 'tiene' */
CREATE TABLE tiene (
  id_zona INT NOT NULL,
  id_producto INT NOT NULL,
  stock INT,
  PRIMARY KEY(id_zona, id_producto)
  CONSTRAINT fk_id_zona 
    FOREIGN KEY(id_zona) 
      REFERENCES zona(id_zona) 
        ON DELETE CASCADE
  CONSTRAINT fk_id_producto 
    FOREIGN KEY(id_producto) 
      REFERENCES producto(id_producto) 
        ON DELETE CASCADE
);

/* Create the table 'empleado' */
CREATE TABLE empleado (
  dni_empleado INT GENERATED ALWAYS AS IDENTIFY,
  id_zona INT,
  nombre_empleado VARCHAR(255) NOT NULL,
  historico VARCHAR(255) NOT NULL, --- atributo derivado, se le tiene que añadir un disparador
  puesto VARCHAR(255) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  PRIMARY KEY(dni_empleado)
  CONSTRAINT fk_id_zona 
    FOREIGN KEY(id_zona) 
      REFERENCES zona(id_zona) 
        ON DELETE CASCADE
);

/* Create the table 'cliente' */
CREATE TABLE cliente (
  dni_cliente VARCHAR(9) NOT NULL,
  tipo_cliente VARCHAR(10) NOT NULL,
  bonificacion,
  fecha_ingreso VARCHAR(6) NOT NULL,
  total_mensual FLOAT, --- atributo derivado, se le tiene que añadir un disparador
  PRIMARY KEY(dni_cliente)
);


/* -- INSERT DATA -- */
/* Insert data into the table 'vivero' */
INSERT INTO vivero VALUES (id_vivero, ubicacion)
VALUES
  (1, 'Calle Los Sueños, 19'),
  (2, 'Calle Ramón y Cajal, 2'),
  (3, 'Calle La Trinidad, 3'),
  (4, 'Calle España, 27'),
  (5, 'Calle El Hidalgo, 8');

/* Insert data into the table 'zona' */
INSERT INTO zona VALUES (id_zona, id_vivero, nombre_zona, numero_ventas)
VALUES
  (1, 1, 'Zona exterior', 39),
  (2, 1, 'Almacén', 23),
  (3, 2, 'Cajas', 17),
  (4, 3, 'Zona exterior', 29),
  (5, 3, 'Cajas', 40);
  
/* Insert data into the table 'producto' */
INSERT INTO producto VALUES (id_producto, nombre_producto, precio, numero_stock)
VALUES
  (1, 'Producto 1', 61.65, 37),
  (2, 'Producto 2', 10.3, 42),
  (3, 'Producto 3', 19.15, 75),
  (4, 'Producto 4', 11.21, 39),
  (5, 'Producto 5', 26.88, 80);

/* Insert data into the table 'tiene' */
INSERT INTO tiene VALUES (id_zona, id_producto, stock)
VALUES
  (1, 1, 10),
  (1, 2, 20),
  (1, 3, 30),
  (1, 4, 40),
  (1, 5, 50),
  (2, 1, 10),
  (2, 2, 20),
  (2, 3, 30),
  (2, 4, 40),
  (2, 5, 50),
  (3, 1, 10),
  (3, 2, 20),
  (3, 3, 30),
  (3, 4, 40),
  (3, 5, 50),
  (4, 1, 10),
  (4, 2, 20),
  (4, 3, 30),
  (4, 4, 40),
  (4, 5, 50),
  (5, 1, 10),
  (5, 2, 20),
  (5, 3, 30),
  (5, 4, 40),
  (5, 5, 50);
  
/* Insert data into the table 'empleado' */
INSERT INTO empleado VALUES (dni_empleado, nombre_empleado, historico)
VALUES
  ('14769497W', 'Salma Blasco', '0'),
  ('30094494Y', 'Ismail Salvador', '0'),
  ('41603427S', 'Jose Antonio Megias', '0'),
  ('86537048P', 'Angeles Cabello', '0'),
  ('20891673Z', 'Jess Duque', '0');
  
/* Insert data into the table 'cliente' */
INSERT INTO cliente VALUES (dni_cliente, tipo_cliente, bonificacion, fecha_ingreso, total_mensual)
VALUES
  ('45714294T', 'Salah Figueras', 49.30, '01/01/2000', 9094.68),
  ('53059518J', 'Ramiro Navarrete', 73.15, '02/02/2000', 6022.42),
  ('56490217D', 'Ezequiel Cabeza', 40.8, '03/03/2000', 6380.35),
  ('51673145B', 'Aquilino Criado', 20.62, '04/04/2000', 6544.13),
  ('82367086S', 'Jan Puerta', 54.36, '05/05/2000',  5246.95);

/* -- SELECT DATA FROM TABLES -- */
/* select all the data from the table 'vivero' */
SELECT * FROM vivero;

/* select all the data from the table 'zona' */
SELECT * FROM zona;

/* select all the data from the table 'producto' */
SELECT * FROM producto;

/* select all the data from the table 'tiene' */
SELECT * FROM tiene;

/* select all the data from the table 'empleado' */
SELECT * FROM empleado;

/* select all the data from the table 'cliente' */
SELECT * FROM cliente;