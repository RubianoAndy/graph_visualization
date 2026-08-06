<div align="center">
    <img src="public/assets/images/Logo.png" width="250" alt="Logo Universidad de La Salle">
</div>

# Introducción a la Visualización de Datos y Principios de Diseño de Gráficos

## 📋 Información General

<div align="center">
    <img src="public/assets/images/author/Andy Rubiano.png" width="200" alt="Foto de Andrés Giovanny Rubiano Muñoz" style="border-radius: 10px;">
</div>

| Aspecto | Detalles |
|--------|----------|
| **Autor** | Andrés Giovanny Rubiano Muñoz "Andy Rubiano" |
| **Correo** | arubiano67@unisalle.edu.co |
| **Asignatura** | Ciencia de Datos — Actividad 1 |
| **Programa** | Maestría en Inteligencia Artificial |
| **Universidad** | Universidad de La Salle |
| **Herramientas** | Python (Matplotlib + pandas) y R (RStudio / VS Code) |
| **Año** | 2026 |
| **Estado** | Completado |

---

## 🎯 Descripción del Proyecto

Laboratorio de **visualización de datos** sobre un conjunto de datos simulado de consumo energético mensual de **120 clientes** de una empresa distribuidora de energía (sectores Residencial, Comercial e Industrial). El proyecto aplica los **principios de diseño de gráficos** (integridad gráfica, razón dato-tinta, etiquetado completo, uso funcional del color) mediante:

- **Estadística descriptiva** por sector (media, mediana, desviación estándar) y correlación de Pearson entre consumo y costo.
- **Gráficos básicos bien diseñados** en Python y replicados en R: histograma, barras, dispersión con regresión, diagrama de caja y barras horizontales de participación.
- **Análisis crítico de diseño:** una gráfica intencionalmente mal diseñada (torta con título vago, colores saturados y sin etiquetas) frente a su versión corregida (barras horizontales ordenadas).
- **Verificación cruzada entre herramientas:** los estadísticos calculados en Python y en R coinciden (r = 0,998), validando el análisis.

### Objetivos Principales

- Crear y evaluar visualizaciones de datos efectivas utilizando Matplotlib en Python y RStudio.
- Aplicar principios esenciales de diseño gráfico en la construcción de cada figura.
- Comparar herramientas de visualización, con énfasis en Matplotlib y justificación de su elección.
- Contrastar ejemplos de gráficos bien y mal diseñados sobre los mismos datos.

---

## 📚 Estructura del Repositorio

```
.
├── README.md                         # Este archivo
├── requirements.txt                  # Dependencias de Python
├── data/
│   ├── dataset/
│   │   └── consumo_energia.csv       # Dataset generado (semilla 42, reproducible)
│   └── processed/                    # Estadísticos calculados (stats_by_sector.csv, corr.txt)
├── public/
│   └── assets/
│       └── images/                   # Logo institucional y foto del autor
│           └── figures/
│               ├── python/           # Figuras generadas con Matplotlib
│               │   ├── good_design/  # hist, bar, scatter, boxplot, barh
│               │   └── bad_design/   # torta mal diseñada (análisis crítico)
│               └── r/                # Figuras generadas con R
│                   ├── good_design/  # boxplot, scatter, barh
│                   └── bad_design/   # torta mal diseñada (análisis crítico)
└── utils/
    └── codes/
        ├── visualizations.py         # Genera dataset, estadísticos y figuras (Python)
        └── visualizations.R          # Replica figuras y verifica estadísticos (R)
```

---

## 🧪 Pipeline del Laboratorio

El flujo es **secuencial**: Python genera los datos y sus figuras; R consume el mismo CSV y replica el análisis, permitiendo la verificación cruzada.

### Fase 1 · Generación y análisis en Python

[`visualizations.py`](utils/codes/visualizations.py) construye el dataset simulado con distribuciones normales por sector y semilla fija (`default_rng(42)`), calcula la estadística descriptiva y produce las figuras con Matplotlib.

| Salida | Ubicación | Descripción |
|---|---|---|
| Dataset | `data/dataset/consumo_energia.csv` | 120 registros: cliente, sector, consumo (kWh), costo (miles COP) |
| Estadísticos | `data/processed/` | Media, mediana, desviación por sector + correlación de Pearson |
| Figuras bien diseñadas | `public/assets/images/figures/python/good_design/` | 5 gráficas con título, unidades, cuadrícula sutil y etiquetas de datos |
| Figura mal diseñada | `public/assets/images/figures/python/bad_design/` | Torta con errores intencionales para el análisis crítico |

### Fase 2 · Réplica y verificación en R

[`visualizations.R`](utils/codes/visualizations.R) lee el CSV generado en la Fase 1 y replica el análisis con graficación base de R.

| Salida | Ubicación | Descripción |
|---|---|---|
| Figuras bien diseñadas | `public/assets/images/figures/r/good_design/` | Boxplot, dispersión y barras horizontales (cuadrícula detrás de los datos) |
| Figura mal diseñada | `public/assets/images/figures/r/bad_design/` | Misma torta defectuosa replicada en R |
| Verificación | Consola | Medias por sector y correlación — deben coincidir con Python |

**Características clave:**

- **Reproducibilidad:** semilla fija en la generación; cualquier ejecución produce datos y figuras idénticos.
- **Rutas robustas:** Python resuelve las rutas desde la ubicación del script (`Path(__file__)`); R crea las carpetas de salida si no existen (`dir.create(recursive = TRUE)`).
- **Verificación cruzada:** las medias por sector (248,3 / 878,1 / 2 654,0 kWh) y la correlación consumo-costo (**r = 0,998**) coinciden entre ambos lenguajes.

---

## ⚙️ Requisitos

### Python

> ⚠️ **Versión:** Python 3.10 o superior, con entorno virtual dedicado (`.venv`).

| Dependencia | Uso |
|---|---|
| `numpy` | Generación del dataset y cálculo numérico |
| `pandas` | Estadística descriptiva y manejo del CSV |
| `matplotlib` | Generación de todas las figuras de Python |

### R

- **R 4.x** (probado en 4.6.1) — solo graficación base, sin paquetes adicionales.
- Editor: RStudio Desktop o VS Code con la extensión **R** (REditorSupport) + `languageserver`.

---

## 🛠️ Ejecución

```bash
# 1. Entorno de Python
python -m venv .venv
source .venv/Scripts/activate   # Git Bash (en PowerShell: .venv\Scripts\activate)
pip install -r requirements.txt

# 2. Fase 1: dataset, estadísticos y figuras de Python
python utils/codes/visualizations.py

# 3. Fase 2: figuras de R y verificación cruzada
Rscript utils/codes/visualizations.R
```

En VS Code, el script de R también puede ejecutarse con **Ctrl + Shift + S** (source del archivo) o línea a línea con **Ctrl + Enter** desde la terminal R Interactive.

---

## 📊 Resultados

| Sector | n | Media (kWh) | Mediana (kWh) | Desv. est. |
|---|---|---|---|---|
| Residencial | 62 | 248,3 | 240,6 | 61,1 |
| Comercial | 40 | 878,1 | 866,6 | 207,3 |
| Industrial | 18 | 2 654,0 | 2 666,8 | 686,9 |

- **Correlación consumo-costo (Pearson): r = 0,998** — asociación lineal casi perfecta, consistente con un esquema tarifario proporcional al consumo, verificada de forma independiente en Python y en R.
- La distribución global del consumo es fuertemente asimétrica a la derecha: la media global (~819 kWh) no representa a ningún grupo, lo que evidencia la necesidad de visualizar y no solo resumir.
- El contraste torta mal diseñada vs. barras ordenadas demuestra que el mismo dato puede ser ilegible o inmediato según se respeten los principios de diseño.

---

## 🔑 Palabras Clave

`Visualización de Datos` · `Matplotlib` · `pandas` · `R` · `RStudio` · `Principios de Diseño de Gráficos` · `Estadística Descriptiva` · `Ciencia de Datos` · `Python`

---

## 📧 Contacto

**Andrés Giovanny Rubiano Muñoz**
Maestría en Inteligencia Artificial · Universidad de La Salle
arubiano67@unisalle.edu.co

---

## 📄 Derechos Reservados

© 2026 Andrés Giovanny Rubiano Muñoz (Andy Rubiano). Todos los derechos reservados.

Este laboratorio y su contenido —código, datos y documentación— son propiedad intelectual conjunta de:

- **Andrés Giovanny Rubiano Muñoz** (Andy Rubiano) — Autor
- **Universidad de La Salle** — Institución académica

El uso, reproducción o distribución requiere autorización previa escrita de los titulares de derechos.

---

<div align="center">
  Universidad de La Salle | Bogotá D. C., Colombia
</div>