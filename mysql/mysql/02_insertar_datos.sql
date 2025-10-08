USE ecommerce_tp3;

-- Clientes
INSERT INTO clientes (nombre, apellido, direccion, email) VALUES
('Ana',  'Pérez',  'Av. Siempre Viva 123', 'ana@example.com'),
('Juan', 'López',  'Calle Falsa 456',      'juan@example.com'),
('Mara', 'Suárez', 'Ruta 2 Km 10',         'mara@example.com');

-- Empleados
INSERT INTO empleados (nombre, apellido, puesto) VALUES
('Carla', 'Gómez', 'Vendedora'),
('Luis',  'Ramos', 'Cajero');

-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Periféricos', 'Teclados, mouse, auriculares, etc.'),
('Monitores',   'Monitores de distintas pulgadas'),
('Almacenamiento', 'Discos, SSD, memorias');

-- Productos
INSERT INTO productos (nombre, descripcion, precio) VALUES
('Teclado mecánico', 'Switches rojos', 45.99),
('Mouse inalámbrico', '2.4G + BT',     18.50),
('Monitor 24"',       'IPS 75Hz',      129.90),
('SSD 1TB',           'NVMe gen3',     69.00);

-- Relación productos <-> categorías (N:M)
INSERT INTO productos_categorias (id_producto, id_categoria) VALUES
(1, 1), -- Teclado -> Periféricos
(2, 1), -- Mouse   -> Periféricos
(3, 2), -- Monitor -> Monitores
(4, 3); -- SSD     -> Almacenamiento

-- Pedido 1 (cliente Ana)
INSERT INTO pedidos (id_cliente, fecha_pedido, estado_pedido)
VALUES (1, '2025-10-01', 'Pendiente');
SET @p1 := LAST_INSERT_ID();

INSERT INTO detalles_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@p1, 1, 1, 45.99),   -- 1 Teclado
(@p1, 2, 2, 18.50);   -- 2 Mouse

-- Comentario de Ana
INSERT INTO comentarios (id_cliente, id_producto, texto, fecha_comentario)
VALUES (1, 1, 'Excelente teclado para escribir', '2025-10-02');

-- Venta asociada al pedido 1 (empleado Carla)
INSERT INTO ventas (id_empleado, id_pedido, fecha_venta, total)
VALUES (1, @p1, '2025-10-02',
  (SELECT SUM(cantidad * precio_unitario) FROM detalles_pedido WHERE id_pedido = @p1)
);

-- Pedido 2 (cliente Juan)
INSERT INTO pedidos (id_cliente, fecha_pedido, estado_pedido)
VALUES (2, '2025-10-03', 'En preparación');
SET @p2 := LAST_INSERT_ID();

INSERT INTO detalles_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(@p2, 3, 1, 129.90),  -- 1 Monitor
(@p2, 4, 1, 69.00);   -- 1 SSD

-- Comentario de Juan
INSERT INTO comentarios (id_cliente, id_producto, texto, fecha_comentario)
VALUES (2, 3, 'Muy buena calidad de imagen', '2025-10-04');

-- Venta asociada al pedido 2 (empleado Luis)
INSERT INTO ventas (id_empleado, id_pedido, fecha_venta, total)
VALUES (2, @p2, '2025-10-04',
  (SELECT SUM(cantidad * precio_unitario) FROM detalles_pedido WHERE id_pedido = @p2)
);
