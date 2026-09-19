--Consulta 1 — Vista base del proyecto (INNER JOIN)
SELECT 
    v.fecha_venta,
    v.id_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS ubicacion_cliente,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN  clientes c ON v.id_cliente = c.id_cliente
INNER JOIN  productos p ON v.id_producto = p.id_producto
INNER JOIN  categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY   v.fecha_venta ASC;

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM  clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE  v.id_venta IS NULL;

-- Consulta 3: Productos sin ventas (LEFT JOIN)
SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM  productos p
INNER JOIN  categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN  ventas v ON p.id_producto = v.id_producto
WHERE  v.id_venta IS NULL;

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Ventas canal Online (primer período: 1 al 10 de marzo)
WITH ventas_por_canal AS (
SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM  ventas
    WHERE  fecha_venta <= '2024-03-10'
    
    UNION ALL
    
    -- Ventas canal Presencial (segundo periodo: posterior al 10 de marzo)
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM   ventas
    WHERE  fecha_venta > '2024-03-10')
SELECT 
    canal,
    COUNT(*) AS cantidad_pedidos,
    SUM(total) AS total_facturado,
    AVG(total) AS ticket_promedio
FROM  ventas_por_canal
GROUP BY canal
ORDER BY total_facturado DESC;
