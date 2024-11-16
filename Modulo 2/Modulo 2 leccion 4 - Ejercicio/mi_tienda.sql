CREATE SCHEMA ejercicios_2;
USE ejercicios_2;

CREATE TABLE empleadas (
	id_empleada INT, 
	salario FLOAT,
	nombre varchar(30),
	apellido varchar(30),
	pais varchar(30)
);

CREATE TABLE personas (
	id INT NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	nombre VARCHAR(255),
	edad INT,
	ciudad VARCHAR (255) DEFAULT "Madrid",
CONSTRAINT personas_2 CHECK (edad > 16)	
);

CREATE TABLE Empleadass (
	id_empleada INT NOT NULL auto_increment,
	salario FLOAT,
	nombre varchar(30),
	apellidos varchar(30),
	país varchar(30),
primary key (id_empleada)
);

CREATE TABLE empleadas_en_proyectos (
	id_empleada INT NOT NULL auto_increment,
	id_proyecto INT NOT NULL,
PRIMARY KEY (id_empleada, id_proyecto),
CONSTRAINT fk_empleadas_en_proyectos_Empleadass
	foreign key (id_empleada)
    references Empleadass (id_empleada) ON DELETE CASCADE 
    );

CREATE TABLE enployees (
	employee_number int not null,
	last_name varchar (50),
	first_name varchar (50),
	extension varchar (50),
	email varchar (20),
	office_code int,
	reports_to varchar (50),
	job_title varchar (50)
);

CREATE TABLE customers1 AS
	SELECT *
	FROM customers;

CREATE SCHEMA mi_tienda;
USE mi_tienda;

CREATE TABLE clientes (
	id_cliente int not null auto_increment,
	nombre_cliente varchar(50) not null,
	apellido_cliente varchar (50) not null,
PRIMARY KEY (id_cliente)
);

CREATE TABLE marcas (
	marca_articulo char(1),
	nombre_marca varchar (40),
PRIMARY KEY (marca_articulo)
);

CREATE TABLE articulos (
	id_articulo int not null auto_increment,
	articulo varchar (200),
	marca_articulo char(1),
	precio_unitario float,
PRIMARY KEY (id_articulo),
CONSTRAINT fk_articulos_marcas
	FOREIGN KEY (marca_articulo)
    REFERENCES marcas (marca_articulo)
);

CREATE TABLE pedidos (
	id_pedido int not null auto_increment,
	id_articulo int,
	id_cliente int,
	cantidad int,
PRIMARY KEY (id_pedido, id_articulo),	
CONSTRAINT fk_pedidos_articulos
	FOREIGN KEY (id_articulo)
    REFERENCES articulos (id_articulo),
CONSTRAINT fk_pedidos_clientes
	FOREIGN KEY (id_cliente)
    REFERENCES clientes (id_cliente)
);

	






 














