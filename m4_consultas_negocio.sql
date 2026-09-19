--Consulta 1 — Resumen ejecutivo mensual 
SELECT
   EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM   ventas
GROUP BY EXTRACT MONTH FROM fecha_venta)
ORDER BY mes ASC;

 --Consulta 2 - Ranking de productos
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

--Consulta 3 — Clientes recurrentes 
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM  ventas
GROUP BY  id_cliente
HAVING  COUNT(*) > 1
ORDER BY cantidad_pedidos DESC,
    total_gastado DESC;

--Consulta 4 — Meses por encima/por debajo del promedio

   WITH ventas_mensuales AS(
    SELECT 
        EXTRACT MONTH FROM fecha_venta AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM  ventas
    GROUP BY MONTH (fecha_venta) ),

    promedio_mensual AS(
    SELECT
        AVG(total_facturado) AS promedio_mensual
    FROM ventas_mensuales 
    )

    SELECT 
    mes,
    total_facturado,
    CASE 
       WHEN total_facturado > (SELECT promedio_mensual FROM promedio_mensual)THEN 'Por encima'
       WHEN total_facturado < ( SELECT promedio_mensual FROM promedio_mensual) THEN 'Por debajo'
       ELSE 'Igual al promedio'
       END AS rendimiento_vs_promedio
FROM ventas_mensuales 
       CROSS JOIN promedio_mensual
ORDER BY mes ASC;

--Bloque de cierre: Hallazgos
-- 1. Concentración de ingresos por productos: El producto 1 “Laptop Pro 15 “ muestra $3600 del total facturado, concentrando el 55% de los ingresos con solo 3 unidades vendidas, muy por encima del resto del Top 5. Demostrando que la importancia de los ingresos dependen del precio unitario y no en el volumen de transacciones.
-- 2. Comportamiento temporal y volúmen: El 100% de las transacciones registradas corresponden al mes 3 (marzo) con 10 órdenes de compra y una facturación total de $6444. Debido a que la totalidad de los datos analizados pertenecen a un único mes, 
la comparativa de rendimiento clasifica este período exactamente como 'Igual al promedio'.
-- 3.Fidelización y concurrencia: Los clientes registrados son recurrentes, ya que cuentan con 2 pedidos cada uno.Sin embargo, se observa una fuerte disparidad en el gasto: el id_cliente 1 aportó $2.640,00 (40,97% del total global) y el id_cliente 5 aportó $2.100,00 (32,59%), mientras que los id_cliente 2, 3 y 4 acumulan en conjunto apenas $1.704,00 (26,44%).

