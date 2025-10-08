DROP DATABASE IF EXISTS ecommerce_tp3;
CREATE DATABASE ecommerce_tp3;
USE ecommerce_tp3;

-- Maestras
CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre     VARCHAR(50)  NOT NULL,
  apellido   VARCHAR(100),
  direccion  VARCHAR(100),
  email      VARCHAR(100)
);

CREATE TABLE empleados (
  id_empleado INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(50)  NOT NULL,
  apellido    VARCHAR(100),
  puesto      VARCHAR(50)
);

CREATE TABLE categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  descripcion  VARCHAR(200)
);

CREATE TABLE productos (
  id_producto  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  descripcion  VARCHAR(200),
  precio       DECIMAL(10,2) NOT NULL
);

-- N:M productos-categorias
CREATE TABLE productos_categorias (
  id_producto  INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_producto, id_categoria),
  FOREIGN KEY (id_producto)  REFERENCES productos(id_producto),
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Pedido / detalle / comentarios / ventas
CREATE TABLE pedidos (
  id_pedido     INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente    INT NOT NULL,
  fecha_pedido  DATE,
  estado_pedido VARCHAR(30),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalles_pedido (
  id_detalle      INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido       INT NOT NULL,
  id_producto     INT NOT NULL,
  cantidad        INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_pedido)   REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE comentarios (
  id_comentario    INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente       INT NOT NULL,
  id_producto      INT NOT NULL,
  texto            TEXT,
  fecha_comentario DATE,
  FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE ventas (
  id_venta    INT AUTO_INCREMENT PRIMARY KEY,
  id_empleado INT NOT NULL,
  id_pedido   INT NOT NULL,
  fecha_venta DATE,
  total       DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
  FOREIGN KEY (id_pedido)   REFERENCES pedidos(id_pedido)
);
