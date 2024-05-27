CREATE DATABASE IF NOT EXISTS CKTES; 
USE CKTES; 

/*CARGOS Y PERMISOS DE LOS EMPLEADOS*/
CREATE TABLE cargos(
id_cargo INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
cargo VARCHAR(50) NOT NULL, 
descripcion_cargo VARCHAR(50) NOT NULL
);


CREATE TABLE permisos(
id_permiso INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
leer BOOLEAN NOT NULL, 
actualizar BOOLEAN NOT NULL, 
insertar BOOLEAN NOT NULL, 
eliminar  BOOLEAN NOT NULL, 
id_cargo INT NOT NULL /*Lláve foránea que conectará los permisos con los distintos roles
ya que en lugar de crear permisos para cada usuario, se crean roles, 
los roles se le asignan a los empleados sin tener que crear permisos para
un solo empleado y no ayudará a gestionar y optimizar mejor la base de datos*/
);

/*APARTADO DE ZONAS*/
CREATE TABLE areas(
id_area INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
area VARCHAR(50) NOT NULL, 
descripcion_area VARCHAR(50) NOT NULL
);

CREATE TABLE tipo_zona(
id_tipo_zona INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
tipo_zona VARCHAR(50) NOT NULL
);

CREATE TABLE zonas(
id_zona INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
zona  VARCHAR(50) NOT NULL, 
descripcion_zona VARCHAR(50) NOT NULL, 
id_tipo_zona INT NOT NULL
);

CREATE TABLE sectores(
id_sectores INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
sector  VARCHAR(50) NOT NULL, 
descripcion_zona VARCHAR(50),
id_area INT NOT NULL, 
id_zona INT NOT NULL 
);


/*APARTADO DE EMPLEADOS*/
CREATE TABLE empleados(
id_empleado INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
nombre_empleado VARCHAR(70) NOT NULL,  
apellido_empleado VARCHAR(70) NOT NULL,  
direccion VARCHAR(70) NOT NULL,  
email varchar(100) NOT NULL, 
id_sector INT NOT NULL, 
CHECK (email LIKE '%@%')
);

CREATE TABLE usuarios(
id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
id_cargo INT NOT NULL, 
id_empleado INT NOT NULL, 
username VARCHAR(50) NOT NULL, 
passwd VARCHAR(100) NOT NULL
);

/*APARTADO DE ALERGIAS Y ENFERMEDADES*/
CREATE TABLE enfermedades(
id_enfermedad INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
enfermedad VARCHAR(50) NOT NULL,
descripcion_enfermedad VARCHAR(50) NOT NULL
);

CREATE TABLE medicamentos(
id_medicamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
medicamento VARCHAR(50) NOT NULL,
descripcion_medicamento VARCHAR(50) NOT NULL
);

CREATE TABLE alergias(
id_alergia INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
alergia VARCHAR(50) NOT NULL,
descripcion_alergia VARCHAR(50) NOT NULL
);

CREATE TABLE detalle_alergias(
id_detalle_alergia INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
id_alergia INT NOT NULL,
id_empleado INT NOT NULL
);

CREATE TABLE detalle_enfermedades(
id_detalle_enfermedad INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
id_enfermedad INT NOT NULL,
id_empleado INT NOT NULL, 
id_mediamento_enfermedad INT NOT NULL
);


/*APARTADO DE ACCIDENTES*/
CREATE TABLE jefes_inmediatos (
    id_jefe INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL, 
    id_zona INT NOT NULL
);

CREATE TABLE partes_cuerpo (
    id_parte INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    parte VARCHAR(50) NOT NULL
);

CREATE TABLE tipos_accidente (
    id_tipo_accidente INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    tipo_accidente VARCHAR(50) NOT NULL
);

CREATE TABLE evidencias (
    id_evidencia INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    id_accidente INT NOT NULL,
    ruta_imagen VARCHAR(255) NOT NULL
);

CREATE TABLE partes_cuerpo_accidente(
id_parte_cuerpo_accidente INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
id_accidente INT NOT NULL,
id_parte_cuerpo INT NOT NULL
);

CREATE TABLE accidentes (
    id_accidente INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    id_jefe INT NOT NULL,
    id_partes_cuerpo INT NOT NULL,
    id_tipo_accidente INT NOT NULL,
    recomendaciones VARCHAR(100) NOT NULL,
    fecha_accidente DATE NOT NULL,
    descripcion TEXT
);

/*RESTRICCION ENTRE Permisos que se le asignaran a los cargos*/
ALTER TABLE permisos
ADD CONSTRAINT fk_permisos_cargos
FOREIGN KEY (id_cargo)
REFERENCES cargos(id_cargo);

/*RESTRICCION ENTRE tipo zona que se le asignaran a las zonas*/
ALTER TABLE zonas
ADD CONSTRAINT fk_tipo_zonas_zonas
FOREIGN KEY (id_tipo_zona)
REFERENCES tipo_zona(id_tipo_zona);

/*RESTRICCION ENTRE areas que se le asignaran a los sectores*/
ALTER TABLE sectores
ADD CONSTRAINT fk_sectores_areas
FOREIGN KEY (id_area)
REFERENCES areas(id_area);

/*RESTRICCION ENTRE zonas que se le asignaran a los sectores*/
ALTER TABLE sectores
ADD CONSTRAINT fk_sectores_zonas
FOREIGN KEY (id_zona)
REFERENCES zonas(id_zona);

/*RESTRICCION ENTRE usuarios que se le asignaran a los empleados*/
ALTER TABLE usuarios
ADD CONSTRAINT fk_usuario_empleados
FOREIGN KEY (id_empleado)
REFERENCES empleados(id_empleado);

/*RESTRICCION ENTRE cargos que se le asignaran a los usuario que pertenecen a los empleados*/
ALTER TABLE usuarios
ADD CONSTRAINT fk_usuario_cargos
FOREIGN KEY (id_cargo)
REFERENCES cargos(id_cargo);
 


