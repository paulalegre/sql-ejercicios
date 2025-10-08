USE ecommerce_tp3;

SELECT
  p.id_producto,
  p.nombre AS producto,
  p.precio,
  GROUP_CONCAT(c.nombre ORDER BY c.nombre SEPARATOR ', ') AS categorias
FROM productos p
LEFT JOIN productos_categorias pc ON pc.id_producto = p.id_producto
LEFT JOIN categorias c           ON c.id_categoria = pc.id_categoria
GROUP BY p.id_producto, p.nombre, p.precio
ORDER BY p.id_producto;

-- 2) Detalle de un pedido con subtotales
-- Cambiá el id del pedido si querés ver otro (ej: 1 o 2)
SET @pedido := 1;
SELECT
  d.id_pedido,
  pr.nombre AS producto,
  d.cantidad,
  d.precio_unitario,
  (d.cantidad * d.precio_unitario) AS subtotal
FROM detalles_pedido d
JOIN productos pr ON pr.id_producto = d.id_producto
WHERE d.id_pedido = @pedido;

-- Total del pedido
SELECT
  p.id_pedido,
  c.nombre AS cliente,
  c.apellido,
  SUM(d.cantidad * d.precio_unitario) AS total_pedido
FROM pedidos p
JOIN clientes c        ON c.id_cliente = p.id_cliente
JOIN detalles_pedido d ON d.id_pedido = p.id_pedido
WHERE p.id_pedido = @pedido
GROUP BY p.id_pedido, c.nombre, c.apellido;

-- 3) Ventas por cliente
SELECT
  cl.id_cliente,
  CONCAT(cl.nombre, ' ', COALESCE(cl.apellido,'')) AS cliente,
  SUM(v.total) AS total_comprado
FROM ventas v
JOIN pedidos p ON p.id_pedido = v.id_pedido
JOIN clientes cl ON cl.id_cliente = p.id_cliente
GROUP BY cl.id_cliente, cliente
ORDER BY total_comprado DESC;

-- 4) Top productos más vendidos (por cantidad)
SELECT
  pr.id_producto,
  pr.nombre,
  SUM(d.cantidad) AS unidades_vendidas
FROM detalles_pedido d
JOIN productos pr ON pr.id_producto = d.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY unidades_vendidas DESC;

-- 5) Comentarios por producto
SELECT
  pr.id_producto,
  pr.nombre AS producto,
  COUNT(co.id_comentario) AS cantidad_comentarios
FROM productos pr
LEFT JOIN comentarios co ON co.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY cantidad_comentarios DESC;

-- 6) Empleado con mayor monto vendido
SELECT
  e.id_empleado,
  CONCAT(e.nombre, ' ', COALESCE(e.apellido,'')) AS empleado,
  SUM(v.total) AS total_vendido
FROM ventas v
JOIN empleados e ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, empleado
ORDER BY total_vendido DESC;

-- 7) Pedidos con estado y cliente
SELECT
  p.id_pedido,
  p.fecha_pedido,
  p.estado_pedido,
  CONCAT(c.nombre, ' ', COALESCE(c.apellido,'')) AS cliente
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
ORDER BY p.id_pedido DESC;
