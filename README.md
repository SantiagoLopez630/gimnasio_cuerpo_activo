# 🏋️‍♂️ Base de Datos Relacional — Gimnasio Cuerpo Activo

Proyecto integral de diseño, modelado, construcción y consulta de una base de datos relacional en **PostgreSQL** para la gestión operativa, financiera y administrativa del **Gimnasio Cuerpo Activo**.

---

## 📋 Descripción del Problema

El gimnasio llevaba el control de sus socios, membresías, entrenadores y clases grupales de forma manual en cuadernos y grupos de WhatsApp, generando pérdida de trazabilidad sobre pagos vencidos, disponibilidad de cupos e historial médico. Este proyecto digitaliza y estructura toda la información del negocio bajo integridad referencial.

---

## 🗂️ Estructura del Repositorio

El proyecto está dividido en 4 fases secuenciales y 18 scripts SQL ejecutables en orden sobre una base de datos vacía:

```text
taller-gimnasio/
├── diagramas/
│   ├── diagrama_er.png              # Modelo Entidad-Relación (Chen)
│   └── diagrama_relacional.png      # Modelo Relacional (Crow's Foot)
├── 01_estructura.sql                # Creación de tablas, PK, FK y restricciones CHECK/UNIQUE
├── 02_datos.sql                     # Carga inicial de datos de prueba
├── 03_consultas.sql                 # Consultas básicas (SELECT, WHERE, AND)
├── 04_cambios.sql                   # Modificación de esquema (ALTER TABLE)
├── 05_actualizaciones.sql           # Mantenimiento de registros (UPDATE / DELETE)
├── 06_tipos.sql                     # Nuevos atributos financieros y de contacto
├── 07_restricciones.sql             # Reglas de negocio y unicidad compuesta
├── 08_claves_foraneas.sql           # Políticas de borrado (ON DELETE CASCADE / RESTRICT)
├── 09_mas_datos.sql                 # Ampliación de dataset para analítica
├── 10_consultas.sql                 # Filtros avanzados, ordenamiento y precedencia lógica
├── 11_reportes.sql                  # Funciones de agregación (COUNT, SUM, AVG, MIN, MAX)
├── 12_por_grupos.sql                # Agrupaciones y filtros de grupo (GROUP BY / HAVING)
├── 13_joins.sql                     # Consultas multitabla con INNER JOIN
├── 14_sin_pareja.sql                # Detección de registros huérfanos con LEFT JOIN
├── 15_horarios.sql                  # Navegación por tablas intermedias (N:M)
├── 16_informe.sql                   # Reportes ejecutivos combinando JOIN y GROUP BY
├── 17_subconsultas.sql              # Subconsultas escalares y de pertenencia (IN / NOT IN)
├── 18_vistas.sql                    # Vistas operativas en tiempo real para recepción
├── correcciones.txt                 # Bitácora de ajustes del modelo
├── informe_final.pdf                # Documentación técnica e informe ejecutivo
└── README.md
🧱 Modelo de Datos
El sistema consta de 7 entidades/tablas normalizadas:

socio: Información de contacto, documento de identidad (PK) y autorización de WhatsApp.

ficha_medica: Relación 1:1 con socio (ON DELETE CASCADE) con peso, estatura y registro de lesiones.

plan: Catálogo de planes (Mensual, Trimestral, Anual) con duración y tarifa base.

membresia: Historial transaccional de pagos (1:N con socio y plan), fechas de vigencia y valor_pagado real.

entrenador: Personal instructor y especialidad.

clase_grupal: Programación de sesiones (1:N con entrenador), horarios, cupo máximo y estado (activa / suspendida).

inscripcion: Tabla intermedia que resuelve la relación N:M entre socio y clase_grupal con restricción de unicidad por clase.

⚙️ Cómo Ejecutar el Proyecto
Abre pgAdmin 4 o tu cliente de PostgreSQL.

Crea la base de datos:

SQL
CREATE DATABASE gimnasio_cuerpo_activo;
Conéctate a gimnasio_cuerpo_activo y ejecuta los archivos .sql en estricto orden numérico desde 01_estructura.sql hasta 18_vistas.sql.

📊 Vistas Operativas Creadas
Para facilitar la operación diaria en recepción sin escribir consultas complejas, el sistema incluye dos vistas actualizadas en tiempo real:

socios_vencidos: Lista los socios cuya última membresía ya expiró (MAX(fecha_fin) < CURRENT_DATE), evitando falsos positivos en clientes que ya renovaron.

ocupacion_clases: Muestra el aforo actual de cada clase activa (cupo, inscritos y cupos_disponibles).

🛠️ Tecnologías Utilizadas
Motor de Base de Datos: PostgreSQL

Administración y Consultas: pgAdmin 4

Modelado: draw.io (diagrams.net)