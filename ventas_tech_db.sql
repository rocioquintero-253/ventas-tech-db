--CREATE DATABASE Ventas_Tech_DB;
DROP TABLE IF EXISTS fact_ventas;
DROP TABLE IF EXISTS dim_productos;
DROP TABLE IF EXISTS dim_clientes;
DROP TABLE IF EXISTS dim_categorias;

CREATE TABLE dim_categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);
CREATE TABLE dim_clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

CREATE TABLE dim_productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo TINYINT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES dim_categorias(id_categoria)
);

CREATE TABLE fact_ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES dim_clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES dim_productos(id_producto)
);

INSERT INTO dim_categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO dim_categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO dim_categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO dim_categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

INSERT INTO dim_clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO dim_clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO dim_clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO dim_clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO dim_clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

INSERT INTO dim_productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO dim_productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO dim_productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO dim_productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO dim_productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO dim_productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);

INSERT INTO fact_ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO fact_ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO fact_ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO fact_ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO fact_ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO fact_ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO fact_ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO fact_ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO fact_ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO fact_ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');


-- Confirmá que cada tabla se cargó correctamente
SELECT * FROM dim_categorias;
SELECT * FROM dim_clientes;
SELECT * FROM dim_productos;
SELECT * FROM fact_ventas;

