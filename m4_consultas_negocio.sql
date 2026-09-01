-- Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
-- Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con 
-- EXTRACT(MONTH FROM fecha_venta).

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) / COUNT(id_venta) AS ticket_promedio
FROM Ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas 
-- (SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. 
-- Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que etiquete con CASE WHEN 
-- si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.

-- Consulta 4 — Meses por encima / por debajo del promedio
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            -- Subconsulta: calcula el promedio general facturado
            SELECT AVG(cantidad * precio_unitario) 
            FROM Ventas
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS desempeño_vs_promedio
FROM Ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
-- ============================================================
-- BLOQUE DE CIERRE: HALLAZGOS DEL ANÁLISIS DE DATOS
-- ============================================================
/*
1. Concentración de Facturación en el Top Producto:
   El producto id_producto = 1 (Laptop Pro 15) es el líder absoluto en ingresos, 
   generando $3,600.00 sobre un total de $6,444.00, lo que representa más del 55% 
   de la facturación total con solo 3 unidades vendidas.

2. Disparidad entre Volumen de Ventas e Ingresos:
   Existe una fuerte diferencia entre el volumen físico y el financiero: mientras 
   que el id_producto = 2 registró el mayor volumen de ventas (13 unidades), 
   solo generó $364.00. En contraste, los productos de alto valor (id 1 y 3) 
   impulsan la mayor parte de los ingresos del negocio.

3. Distribución de Clientes y Ticket Promedio:
   La base de clientes muestra un comportamiento homogéneo con 2 pedidos por cliente, 
   destacándose el id_cliente = 1 con el mayor gasto acumulado ($2,640.00). 
   Asimismo, la facturación global de marzo ($6,444.00) se ubicó 'Por encima' 
   del promedio por transacción, alcanzando un ticket promedio de $644.40.
*/