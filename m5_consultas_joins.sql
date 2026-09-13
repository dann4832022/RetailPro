-- ════════════════════════════════════════════════════════════════════════════
-- RETAILPRO — 
-- Alumno: Daniel Cespedes
-- Titulo - Cruzando tablas para enriquecer el análisis
-- ════════════════════════════════════════════════════════════════════════════
--Consulta 1 — Vista base del proyecto (INNER JOIN)

--Trabajás sobre el esquema que creaste en el Checkpoint del Módulo 3. 
-- Combiná con INNER JOIN tu tabla de ventas con las tablas descriptivas que hayas modelado 
--(clientes, productos y cualquier otra dimensión de tu caso de negocio) para obtener en una sola fila, 
--como mínimo: fecha, identificación del cliente, descripción del producto, cantidad, precio unitario y total de venta.

--Sumá además las columnas descriptivas que existan en tu propio esquema (por ejemplo segmento de cliente, categoría de producto o región, 
--si las modelaste). No es necesario que estén todas: la consulta se evalúa sobre las tablas que vos diseñaste, no sobre una lista fija.

-- Si tu esquema no tiene ninguna dimensión geográfica ni de segmentación, agregala ahora al script del 
-- Módulo 3 con dos o tres registros de ejemplo. Esta consulta va a ser la fuente de datos principal en Power BI, así que conviene que 
-- tenga al menos una columna para agrupar y una para filtrar.
CREATE DATABASE RetailPro;
GO
USE RetailPro;
GO
-- Corroboración de existencias de tablas previo a crearlas
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- Creación de tabla categorias
CREATE TABLE Categorias (
	id_categoria INT PRIMARY KEY,
	nombre_categoria VARCHAR(50) NOT NULL,
	descripcion VARCHAR(200)
);
GO

-- Creación de tabla clientes
CREATE TABLE Clientes (
	id_cliente INT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	ciudad VARCHAR(50),
	fecha_registro DATE NOT NULL
);
GO

-- Creación de tabla producos
CREATE TABLE Productos (
	id_producto INT PRIMARY KEY,
	nombre_producto VARCHAR(100) NOT NULL,
	id_categoria INT,
	precio DECIMAL(10,2) NOT NULL,
	stock INT DEFAULT 0,
	activo TINYINT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);
GO

-- Creación de tabla ventas, tabla de hechos
CREATE TABLE Ventas(
	id_venta INT PRIMARY KEY,
	id_cliente INT,
	id_producto INT,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL (10,2) NOT NULL,
	fecha_venta DATE NOT NULL,
	FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
	FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);
GO

-- DML--
-- Carga de datos en tabla categorias

INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');
GO

-- Carga de datos en tabla clientes
INSERT INTO clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');
GO

-- Carga de datos en tabla productos
INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);
GO

-- Carga de datos en tabla ventas
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');
GO

-- Confirmación final
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;

-- ════════════════════════════════════════════════════════════════════════════
-- CONSULTA 1: VISTA BASE DEL PROYECTO (INNER JOIN)
-- Reporte unificado de ventas con datos de cliente, producto, categoría y ciudad
-- ════════════════════════════════════════════════════════════════════════════

SELECT 
    v.id_venta,
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    v.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM Ventas v
INNER JOIN Clientes c 
    ON v.id_cliente = c.id_cliente
INNER JOIN Productos p 
    ON v.id_producto = p.id_producto
INNER JOIN Categorias cat 
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC;

-- ════════════════════════════════════════════════════════════════════════════
-- PREPARACIÓN DE DATOS PARA CONSULTAS 2 Y 3 (CLIENTES Y PRODUCTOS SIN VENTAS)
-- Agregamos clientes sin compras y productos sin movimiento para probar los JOINs
-- ════════════════════════════════════════════════════════════════════════════

INSERT INTO Clientes VALUES (6, 'Roberto Gómez', 'roberto@mail.com', 'Mendoza', '2024-03-20');
INSERT INTO Clientes VALUES (7, 'Lucía Fernández', 'lucia@mail.com', 'Rosario', '2024-03-22');
GO

-- ════════════════════════════════════════════════════════════════════════════
-- CONSULTA 2: CLIENTES SIN VENTAS (LEFT JOIN)
-- Pregunta de negocio: ¿Qué clientes registrados aún no han realizado ninguna compra?
-- ════════════════════════════════════════════════════════════════════════════

SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM Clientes c
LEFT JOIN Ventas v 
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- ════════════════════════════════════════════════════════════════════════════
-- PREPARACIÓN DE DATOS PARA PRODUCTOS SIN VENTAS
-- Agregamos productos al catálogo que aún no registraron ventas
-- ════════════════════════════════════════════════════════════════════════════

INSERT INTO Productos VALUES (7, 'Silla Gamer Ergonomica', 2, 250.00, 10, 1);
INSERT INTO Productos VALUES (8, 'Parlante Smart Echo',     3,  85.00, 25, 1);
GO

-- ════════════════════════════════════════════════════════════════════════════
-- CONSULTA 3: PRODUCTOS SIN VENTAS (LEFT JOIN)
-- Pregunta de negocio: ¿Qué artículos del catálogo no tienen movimiento registrado?
-- ════════════════════════════════════════════════════════════════════════════

SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM Productos p
INNER JOIN Categorias cat 
    ON p.id_categoria = cat.id_categoria
LEFT JOIN Ventas v 
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- ════════════════════════════════════════════════════════════════════════════
-- CONSULTA 4: CONSOLIDADO POR CANAL (UNION ALL + GROUP BY)
-- Pregunta de negocio: ¿Cuál es el total facturado según el canal de origen de la venta?
-- ════════════════════════════════════════════════════════════════════════════

-- Subconsulta con UNION ALL para etiquetar el origen y posterior agrupamiento general:
SELECT 
    v_canal.canal,
    COUNT(v_canal.id_venta) AS cantidad_operaciones,
    SUM(v_canal.total_venta) AS total_facturado
FROM (
    -- Bloque 1: Ventas asignadas al canal 'Online' (Ciudades principales)
    SELECT 
        v.id_venta,
        v.fecha_venta,
        (v.cantidad * v.precio_unitario) AS total_venta,
        'Online' AS canal
    FROM Ventas v
    INNER JOIN Clientes c ON v.id_cliente = c.id_cliente
    WHERE c.ciudad IN ('Buenos Aires', 'Rosario')

    UNION ALL

    -- Bloque 2: Ventas asignadas al canal 'Presencial' (Resto de las ciudades)
    SELECT 
        v.id_venta,
        v.fecha_venta,
        (v.cantidad * v.precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM Ventas v
    INNER JOIN Clientes c ON v.id_cliente = c.id_cliente
    WHERE c.ciudad NOT IN ('Buenos Aires', 'Rosario')
) AS v_canal
GROUP BY v_canal.canal;