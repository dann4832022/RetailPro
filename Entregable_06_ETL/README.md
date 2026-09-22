Decidí qué hacer con los dos registros que tienen nulos en email y ciudad. Justificá tu decisión en el documento de entrega: ¿los eliminás o los reemplazás con un valor por defecto? ¿Por qué?
Reemplazar los valores vacíos/nulos por el texto "Sin registro".

Justificación: Se optó por no eliminar estos registros para preservar la totalidad de la base de clientes y sus transacciones asociadas. El correo electrónico y la ciudad son atributos opcionales dentro de la dimensión; al etiquetarlos explícitamente como "Sin registro", se evita perder filas valiosas en los reportes de ventas sin distorsionar los filtros o agrupaciones geográficas en Power BI.

El producto con precio nulo es un problema crítico ya que sin precio no se puede calcular el ingreso. Decidí si lo eliminás o lo reemplazás con un valor lógico y justificalo.
iltrar y eliminar el registro con precio nulo.

Justificación: El precio es una variable numérica crítica indispensable para la lógica de negocio. Mantener la fila o imputar un valor artificial (como $0 o un promedio) generaría cálculos de ingresos distorsionados y subestimaría el total facturado. Ante la imposibilidad de calcular métricas financieras reales, la práctica estándar es excluir la entidad hasta que el dato sea corregido en el sistema de origen.

El producto con categoria nula puede asignarse a una categoría existente o marcarse como "Sin Categoría". Justificá tu elección.
Decisión: Marcar el valor nulo con la etiqueta "Sin Categoría".

Justificación: La categoría es un atributo descriptivo de agrupación (dimensión). Eliminar el producto por carecer de categoría provocaría la pérdida de su inventario, stock y el histórico de ventas asociado. Al asignar la etiqueta "Sin Categoría", se conservan la integridad financiera de las ventas totales y la trazabilidad operativa del producto dentro del modelo dimensional.

