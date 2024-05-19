CREATE DATABASE IF NOT EXISTS CKTES; 
USE CKTES; 

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

CREATE TABLE areas(
id_area INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
area VARCHAR(50) NOT NULL, 
descripcion_area VARCHAR(50) NOT NULL
);

CREATE TABLE zonas(
id_zona INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
zona  VARCHAR(50) NOT NULL, 
descripcion_zona VARCHAR(50) NOT NULL
);

CREATE TABLE sectores(
id_sectores INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
sector  VARCHAR(50) NOT NULL, 
descripcion_zona VARCHAR(50),
id_area INT NOT NULL, 
id_zona INT NOT NULL 
);

CREATE TABLE empleados(
id_permiso INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
nombre_empleado VARCHAR(70) NOT NULL,  
apellido_empleado VARCHAR(70) NOT NULL,  
direccion VARCHAR(70) NOT NULL,  
email varchar(100) NOT NULL, 
id_sector INT NOT NULL, 
CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE usuarios(
id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE, 
id_rol INT NOT NULL, 
id_empleado INT NOT NULL, 
username VARCHAR(50) NOT NULL, 
passwd VARCHAR(100) NOT NULL
);

DELIMITER //

CREATE PROCEDURE obtener_informacion_empleado(IN p_id_usuario INT)
BEGIN
    SELECT 
        u.id_usuario,
        e.nombre_empleado,
        e.apellido_empleado,
        e.email,
        c.cargo
    FROM 
        usuarios u
    INNER JOIN 
        empleados e ON u.id_empleado = e.id_empleado
    INNER JOIN 
        cargos c ON u.id_rol = c.id_cargo
    WHERE 
        u.id_usuario = p_id_usuario;
END //

DELIMITER ;

