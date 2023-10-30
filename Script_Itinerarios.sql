/*
Base de datos para planificar viajes y armar itinerarios en base a un presupuesto
*/

-- Create database 
DROP SCHEMA IF EXISTS itinerarios;
CREATE DATABASE itinerarios;
USE itinerarios;
-- Usuarios que planifican sus viajes
DROP TABLE if exists usuario;
CREATE TABLE IF NOT EXISTS usuario (
  ID_usuario INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  nombre VARCHAR(50) NOT NULL COMMENT 'nombre del usuario',
  apellido VARCHAR(50)  NULL COMMENT 'apellido del usuario',
  ID_ciudad INT NOT NULL COMMENT 'Codigo de la ciudad en la que reside el usuario', 
  email VARCHAR(50) NOT NULL COMMENT 'correo del usuario'
  -- , FOREIGN KEY (ID_ciudad) REFERENCES ciudad(ID_ciudad)
);
ALTER TABLE usuario
ADD FOREIGN KEY (ID_ciudad) REFERENCES ciudad(ID_ciudad);
-- armado del viaje
DROP TABLE if exists viaje;
CREATE TABLE IF NOT EXISTS viaje (
  ID_viaje INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria', 
  presupuesto_tope INT NOT NULL COMMENT 'valor tope que se desea gastar en el viaje',
  ID_pres_rango INT COMMENT 'Codigo del rango del presupuesto seleccionado',
  ID_temporada INT COMMENT 'Tipo de temporada',
  ID_ciudad_origen INT COMMENT 'Codigo ciudad de origen',
  fecha_inicio DATE NOT NULL COMMENT 'fecha de inicio del viaje', 
  ID_ciudad_destino INT COMMENT 'Codigo ciudad de destino', 
  fecha_fin DATE NOT NULL COMMENT 'fecha de fin del viaje',
  ID_usuario INT COMMENT 'Referencia al usuario'
  -- , FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto) ,
  -- , FOREIGN KEY (ID_temporada) REFERENCES temporada(ID_temporada),
  -- , FOREIGN KEY (ID_ciudad_origen) REFERENCES ciudad(ID_ciudad),
  -- , FOREIGN KEY (ID_ciudad_destino) REFERENCES ciudad(ID_ciudad),
  -- , FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario)
);
ALTER TABLE viaje
ADD FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto) ,
ADD FOREIGN KEY (ID_temporada) REFERENCES temporada(ID_temporada),
ADD FOREIGN KEY (ID_ciudad_origen) REFERENCES ciudad(ID_ciudad), 
ADD FOREIGN KEY (ID_ciudad_destino) REFERENCES ciudad(ID_ciudad),
ADD FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario);
-- itinerario del viaje
DROP TABLE IF EXISTS itinerario;
CREATE TABLE IF NOT EXISTS itinerario (
  ID_itinerario INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria que identifica el dia de orden del viaje',
  ID_viaje INT COMMENT 'Referencia al viaje',
  fecha_desde DATE NOT NULL COMMENT 'fecha de inicio del itinerario',
  fecha_hasta DATE NOT NULL COMMENT 'fecha de fin del itinerario', 
  ID_transporte INT COMMENT 'identifica si hubo movimiento de transporte',
  ID_ciudad INT COMMENT 'identifica si hubo movimiento de ciudad', 
  ID_alojamiento INT COMMENT 'identifica si hubo movimiento de alojamiento',
  ID_actividad INT COMMENT 'identifica si hubo movimiento de actividad'
  -- , FOREIGN KEY (ID_viaje) REFERENCES viaje(ID_viaje),
  -- , FOREIGN KEY (ID_transporte) REFERENCES transporte(ID_transporte),
  -- , FOREIGN KEY (ID_ciudad) REFERENCES ciudad(ID_ciudad),
  -- , FOREIGN KEY (ID_alojamiento) REFERENCES alojamiento(ID_alojamiento),
  -- , FOREIGN KEY (ID_actividad) REFERENCES actividad(ID_actividad);
);
ALTER TABLE itinerario
ADD FOREIGN KEY (ID_viaje) REFERENCES viaje(ID_viaje),
ADD FOREIGN KEY (ID_transporte) REFERENCES mov_transporte(ID_mov_transporte),
ADD FOREIGN KEY (ID_alojamiento) REFERENCES mov_alojamiento(ID_mov_alojamiento),
ADD FOREIGN KEY (ID_actividad) REFERENCES mov_actividad(ID_mov_actividad),
ADD FOREIGN KEY (ID_ciudad) REFERENCES mov_ciudad(ID_mov_ciudad);

-- Transportes programados en el itinerario de viaje
DROP TABLE IF EXISTS mov_transporte;
CREATE TABLE IF NOT EXISTS mov_transporte ( 
  ID_mov_transporte INT NOT NULL COMMENT 'Clave que identifica al movimiento de transporte realizado',
  fecha_salida DATE NOT NULL COMMENT 'Fecha de salida del transporte',
  fecha_llegada DATE NOT NULL COMMENT 'Fecha de llegada del transporte',
  ID_pres_rango INT COMMENT 'Codigo del rango del presupuesto seleccionado' 
  -- , FOREIGN KEY (ID_mov_transporte) REFERENCES transportes(ID_transportes),
  -- , FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto),
);
ALTER TABLE mov_transporte
ADD FOREIGN KEY (ID_mov_transporte) REFERENCES transportes(ID_transportes),
ADD FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto);

-- Transportes
DROP TABLE IF EXISTS transportes;
CREATE TABLE IF NOT EXISTS transportes (
  ID_transportes INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  ID_tipo_transporte INT NOT NULL COMMENT 'Tipo de transporte seleccionado',
  ID_ciudad_origen INT NOT NULL COMMENT 'Codigo ciudad de origen del transporte', 
  ID_ciudad_destino INT NOT NULL COMMENT 'Codigo ciudad destino del transporte',
  horario_salida TIME NOT NULL COMMENT'hora de salida del transporte',
  valor INT NOT NULL COMMENT 'valor del transporte'
  -- , FOREIGN KEY (ID_tipo_transporte) REFERENCES tipo_transporte(ID_tipo_transporte) 
  -- , FOREIGN KEY (cod_ciudad_origen) REFERENCES ciudad(ID_ciudad),
  -- , FOREIGN KEY (cod_ciudad_destino) REFERENCES ciudad(ID_ciudad),
);
ALTER TABLE transportes
ADD FOREIGN KEY (ID_tipo_transporte) REFERENCES tipo_transporte(ID_tipo_transporte), 
ADD FOREIGN KEY (ID_ciudad_origen) REFERENCES ciudad(ID_ciudad),
ADD FOREIGN KEY (ID_ciudad_destino) REFERENCES ciudad(ID_ciudad);

-- Tipo de transporte
DROP TABLE IF EXISTS tipo_transporte;
CREATE TABLE IF NOT EXISTS tipo_transporte (
  ID_tipo_transporte INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  descripcion VARCHAR(50) NOT NULL COMMENT 'Descripcion del tipo de trasporte'
);

-- Alojamiento definidos en el itinerario de viaje
DROP TABLE IF EXISTS mov_alojamiento;
CREATE TABLE IF NOT EXISTS mov_alojamiento (
  ID_mov_alojamiento INT COMMENT 'Tipo de alojamiento ', 
  fecha_entrada DATE COMMENT 'fecha de ingreso al alojamiento',
  fecha_salida DATE COMMENT 'fecha de salida del alojamiento',
  valor_estadia INT NOT NULL COMMENT 'valor total estadia',
  ID_pres_rango INT COMMENT 'Codigo del rango del presupuesto seleccionado'
  -- , FOREIGN KEY (ID_mov_alojamiento) REFERENCES alojamientos(ID_alojamiento),
  -- , FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto); 
);
ALTER TABLE mov_alojamiento
ADD FOREIGN KEY (ID_mov_alojamiento) REFERENCES alojamientos(ID_alojamiento),
ADD FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto);
-- Alojamientos
DROP TABLE IF EXISTS alojamientos;
CREATE TABLE IF NOT EXISTS alojamientos (
  ID_alojamiento INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  ID_tipo_alojamiento INT COMMENT 'tipo de alojamiento', 
  ID_ciudad INT COMMENT 'Ciudad de alojamiento',
  valor_noche INT NOT NULL COMMENT 'valor por noche'
  -- , FOREIGN KEY (ID_tipo_alojamiento) REFERENCES tipo_alojamiento (ID_tipo_alojamiento),
  -- , FOREIGN KEY (ID_ciudad) REFERENCES ciudad (ID_ciudad)
);
ALTER TABLE alojamientos
ADD FOREIGN KEY (ID_tipo_alojamiento) REFERENCES tipo_alojamiento (ID_tipo_alojamiento),
ADD FOREIGN KEY (ID_ciudad) REFERENCES ciudad (ID_ciudad);
-- Tipo de alojamiento
DROP TABLE IF EXISTS tipo_alojamiento;
CREATE TABLE IF NOT EXISTS tipo_alojamiento (
  ID_tipo_alojamiento INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  descripcion VARCHAR(50) NOT NULL COMMENT 'Descripcion del tipo de alojamiento'
);

-- Actividades organizadas en el itinerario de viaje
DROP TABLE IF EXISTS mov_actividad;
CREATE TABLE IF NOT EXISTS mov_actividad (
  ID_mov_actividad INT COMMENT 'Codigo de la actividad',
  fecha_inicio_act DATE NOT NULL COMMENT 'fecha de inicio de la actividad seleccionada',
  ID_pres_rango INT COMMENT 'Codigo del rango del presupuesto seleccionado'
  -- , FOREIGN KEY (ID_mov_actividad) REFERENCES actividades(ID_actividad), 
  -- , FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto); 
);
ALTER TABLE mov_actividad
ADD FOREIGN KEY (ID_mov_actividad) REFERENCES actividades(ID_actividad), 
ADD FOREIGN KEY (ID_pres_rango) REFERENCES tipo_presupuesto(ID_tipo_presupuesto); 
-- Actividades
DROP TABLE IF EXISTS actividades;
CREATE TABLE IF NOT EXISTS actividades(
  ID_actividad INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  ID_tipo_actividad INT COMMENT 'tipo de actividad',
  ID_ciudad INT COMMENT 'ciudad donde se realiza la actividad',
  horario TIME COMMENT 'horario de inicio de la actividad',
  valor INT COMMENT 'valor de la actividad'
  -- , FOREIGN KEY (ID_tipo_actividad) REFERENCES tipo_actividad (ID_tipo_actividad),
  -- , FOREIGN KEY (ID_ciudad) REFERENCES ciudad(ID_ciudad)
);
ALTER TABLE actividades
ADD FOREIGN KEY (ID_tipo_actividad) REFERENCES tipo_actividad (ID_tipo_actividad),
ADD FOREIGN KEY (ID_ciudad) REFERENCES ciudad(ID_ciudad);
-- Tipo de actividades
DROP TABLE IF EXISTS tipo_actividad;
CREATE TABLE IF NOT EXISTS tipo_actividad (
  ID_tipo_actividad INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  descripcion VARCHAR(50) NOT NULL COMMENT 'Descripcion del tipo de actividad'
);
-- Ciudades en el itinerario de viaje 
DROP TABLE IF EXISTS mov_ciudad;
CREATE TABLE IF NOT EXISTS mov_ciudad (
  ID_mov_ciudad INT  COMMENT 'Clave de ciudad dentro del itinerario',
  fecha_entrada DATE NOT NULL COMMENT 'fecha de llegada a la ciudad'
  -- , FOREIGN KEY (ID_mov_ciudad) REFERENCES ciudad(ID_ciudad)
);
ALTER TABLE mov_ciudad
ADD FOREIGN KEY (ID_mov_ciudad) REFERENCES ciudad(ID_ciudad);
-- Ciudades
DROP TABLE IF EXISTS ciudad;
CREATE TABLE IF NOT EXISTS ciudad (
  ID_ciudad INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria',
  nombre VARCHAR(30) NOT NULL COMMENT 'Nombre de la ciudad',
  pais VARCHAR(30) NOT NULL COMMENT 'Pais de la ciudad'
  
);


-- Rango de presupuestos segun temporada
DROP TABLE IF EXISTS tipo_presupuesto;
CREATE TABLE IF NOT EXISTS tipo_presupuesto (
  ID_tipo_presupuesto INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave Primaria',
  ID_temporada INT COMMENT 'Tipo de temporada',
  descripcion VARCHAR(50) NOT NULL COMMENT 'tipo de presupuesto bajo/medio/alto',
  valor INT NOT NULL COMMENT 'Rango de valor estimado'
  -- , FOREIGN KEY (ID_temporada) REFERENCES temporada(ID_temporada)
);
ALTER TABLE tipo_presupuesto
ADD FOREIGN KEY (ID_temporada) REFERENCES temporada(ID_temporada);
-- Temporada del viaje  
DROP TABLE IF EXISTS temporada;
CREATE TABLE IF NOT EXISTS temporada (
  ID_temporada INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Clave primaria de temporada',
  descripcion VARCHAR(50) NOT NULL COMMENT 'Descripcion de la temporada'
);



