# 📊 Proyecto Final — Análisis Comercial & Dashboard Ejecutivo RetailPro

## 📌 Descripción del Proyecto
Este proyecto integra la solución analítica completa desarrollada para **RetailPro**, una distribuidora de productos tecnológicos y comerciales. A lo largo del proyecto se implementó un flujo end-to-end que abarca la arquitectura de base de datos en SQL, modelado relacional en estrella, transformación de datos con Power Query y la construcción de un dashboard interactivo en Power BI diseñado para la toma de decisiones estratégicas.

---

## 🛠️ Tecnologías Utilizadas
* **Base de Datos & SQL:** Microsoft SQL Server (T-SQL)
* **ETL & Limpieza:** Power Query (Lenguaje M)
* **Modelado & DAX:** Power BI Desktop (Modelo en Estrella / Star Schema)
* **Visualización & Storytelling:** Power BI Desktop
* **Documentación:** Google Docs & GitHub

---

## 📐 Arquitectura de Datos (Modelo Relacional)
El modelo se diseñó siguiendo un esquema en estrella (*Star Schema*) compuesto por una tabla de hechos principal y tablas de dimensiones:

* **Tabla de Hechos (`ventas`):** Almacena el historial de transacciones (`TransactionID`, `CustomerID`, `ProductID`, `FechaCompra`, `Cantidad`, `MontoTotal`, `MedioPago`).
* **Tablas de Dimensión:**
  * `clientes`: Información demográfica (`CustomerID`, `Nombre`, `Email`, `Ciudad`, `País`, `Segmento`).
  * `productos`: Catálogo corporativo (`ProductID`, `Nombre_Producto`, `Categoría`, `SubCategoría`, `PrecioUnitario`).
  * `Tabla-Calendario`: Dimensión temporal para análisis cronológico YTD.
  * `_Medidas`: Contenedor exclusivo de métricas DAX (`Total Ventas`, `Ticket Promedio`, `Total Transacciones`).

---

## 📈 Principales Insights de Negocio
1. **Liderazgo de Categoría:** La vertical de **Tecnología** concentra la mayor parte de la facturación global y ostenta el ticket promedio más elevado (`$60.643`), consolidándose como el motor comercial de la empresa.
2. **Tendencia Temporal:** El comportamiento de ventas acumuladas (YTD) muestra una curva alcista constante a lo largo del año, alcanzando una aceleración marcada hacia el cierre del ejercicio.
3. **Eficiencia Transaccional:** El negocio registra un ticket promedio general de `$41.794` sobre un total de `3.000` transacciones auditadas.

---

## 📄 Entregables del Proyecto
* **Informe Completo:** Presentado mediante el documento unificado de Google Docs (con explicaciones teóricas, capturas SQL, modelo ER y storytelling).
* **Archivo de Power BI:** `Pipeline_ETL_Cespedes_Daniel.pbix` (Dashboard interactivo con marcadores de limpieza de filtros).
* **Consultas SQL:** Scripts `.sql` con consultas de negocio, uniones (`JOINs`) y filtrado temporal dinámico.

---
**Autor:** Daniel Céspedes  
**Especialidad:** Data Analytics
