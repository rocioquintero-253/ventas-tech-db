RetailPro — Ventas Tech DB
Descripción del proyecto
Este repositorio alberga la base de datos relacional y el conjunto de consultas analíticas desarrolladas en SQL para el caso de negocio RetailPro (empresa distribuidora de tecnología. El proyecto comprende el ciclo inicial de la base de datos: definición de la arquitectura relacional normalizada en 3NF (DDL), carga de datos iniciales (DML), extracción de métricas ejecutivas de ventas y construcción de vistas combinadas mediante uniones relacionales (JOINs y UNION ALL)

Estructura del Repositorio
El repositorio organiza los scripts del proyecto en tres etapas clave

* `ventas_tech_db.sql`: Script de definición estructural y poblado de datos. Crea la base de datos `Ventas_Tech_DB`, define las tablas normalizadas con claves primarias y foráneas (`categorias`, `clientes`, `productos` y `ventas`), y realiza la inserción de los registros de prueba.
* `m4_consultas_negocio.sql`: Script de consultas de agregación y análisis de negocio sobre la tabla de hechos. Responde a requerimientos comerciales sobre facturación mensual, rankings de productos, clientes recurrentes y evaluación frente al promedio.
* `m5_consultas_joins.sql`: Script de consultas relacionales multidimensionales. Implementa la vista base del modelo mediante `INNER JOIN`, detecta registros huérfanos o sin actividad con `LEFT JOIN` / `IS NULL`, y realiza la consolidación de canales de venta con `UNION ALL`.

Modelo de datos
La base de datos está formada por cuatro tablas principales:
•	categorias: contiene las categorías de los productos. (`id_categoria` [PK], `nombre_categoria`, `descripcion`)
•	clientes: contiene los datos de los clientes registrados. (`id_cliente` [PK], `nombre`, `email`, `ciudad`, `fecha_registro`)[
•	productos: contiene el catálogo de productos tecnológicos. tecnológicos (`id_producto` [PK], `nombre_producto`, `id_categoria` [FK], `precio`, `stock`, `activo`)[
•	ventas: contiene la información de las operaciones realizadas. (`id_venta` [PK], `id_cliente` [FK], `id_producto` [FK], `cantidad`, `precio_unitario`, `fecha_venta`)
Las tablas se encuentran relacionadas mediante claves primarias y foráneas.

Herramientas utilizadas
Motor de Base de Datos: SQL Server / PostgreSQL (sintaxis compatible con SQL ANSI estándar)
Entornos de Consulta y Gestión: SQL Server Management Studio (SSMS) o DBeaver.
Lenguaje SQL y Cláusulas Clave
 DDL: `CREATE DATABASE`, `DROP TABLE IF EXISTS`, `CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY’
 DML y Consultas: `INSERT INTO`, `SELECT`, `WHERE`, `ORDER BY`
 Agregaciones: `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`
Operaciones Avanzadas y de Conjuntos: `INNER JOIN`, `LEFT JOIN`, `UNION ALL`, `CASE WHEN`, CTEs (`WITH`)

Cómo ejecutar el proyecto
Para ejecutar el proyecto, se recomienda seguir este orden:
1. Crear y cargar la base de datos
Ejecutar el archivo:
ventas_tech_db.sql
Este script crea la base de datos, las tablas correspondientes e inserta los datos iniciales.
Una vez ejecutado, se puede comprobar la carga de datos utilizando:
SELECT * FROM ventas;
2. Ejecutar las consultas de negocio
Ejecutar:
m4_consultas_negocio.sql
Este archivo permite obtener información sobre:
•	Facturación mensual.
•	Ranking de productos.
•	Unidades vendidas.
•	Clientes recurrentes.
•	Comparación de ventas con el promedio mensual.
3. Ejecutar las consultas con JOIN
Ejecutar:
m5_consultas_joins.sql
Este archivo permite:
•	Obtener una vista enriquecida de las ventas mediante INNER JOIN.
•	Identificar clientes sin ventas mediante LEFT JOIN.
•	Identificar productos sin ventas.
•	Comparar los canales de venta mediante UNION ALL.



Objetivo del proyecto
El objetivo es utilizar SQL para organizar, consultar y analizar los datos de RetailPro, obteniendo información que pueda servir como base para el análisis del negocio y la toma de decisiones comerciales.
