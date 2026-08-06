# ---- Rutas del proyecto ----
data_path <- "data/dataset/consumo_energia.csv"
figures_dir <- file.path("public", "assets", "images", "figures", "r")
good_dir <- file.path(figures_dir, "good_design")
bad_dir <- file.path(figures_dir, "bad_design")

# Crear las carpetas de figuras si no existen
for (d in c(good_dir, bad_dir)) {
  if (!dir.exists(d)) {
    dir.create(d, recursive = TRUE)
  }
}

# ---- Carga de datos ----
df <- read.csv(data_path)

# Vista rapida de los datos
head(df)
str(df)

# ============================================================
# GRAFICAS BIEN DISEÑADAS (good_design)
# Principios: titulo informativo, ejes con unidades, cuadricula
# sutil detras de los datos, colores sobrios, etiquetas de datos
# ============================================================

# ---- Boxplot: consumo por sector ----
png(file.path(good_dir, "boxplot_consumption_by_sector.png"),
    width = 1950, height = 1080, res = 300)
par(mar = c(4, 4, 3, 1))
box_colors <- c("#74a9cf", "#2b8cbe", "#a6bddb")
# Primera pasada: establece ejes y escala
boxplot(consumo_kwh ~ sector, data = df, border = NA,
        main = "Consumo mensual por sector (R)",
        xlab = "Sector", ylab = "Consumo (kWh/mes)")
grid(nx = NA, ny = NULL)  # solo lineas horizontales, detras de las cajas
# Segunda pasada: dibuja las cajas sobre la cuadricula
boxplot(consumo_kwh ~ sector, data = df,
        col = box_colors, add = TRUE, axes = FALSE)
dev.off()

# ---- Dispersion: consumo vs costo ----
png(file.path(good_dir, "scatter_consumption_vs_cost.png"),
    width = 1950, height = 1140, res = 300)
par(mar = c(4, 4, 3, 1))
sector_colors <- c(Residencial = "#1b9e77",
                   Comercial = "#d95f02",
                   Industrial = "#7570b3")
# Primera pasada: lienzo vacio con ejes
plot(df$consumo_kwh, df$costo_miles_cop, type = "n",
     main = "Consumo vs. costo mensual (R)",
     xlab = "Consumo (kWh/mes)", ylab = "Costo (miles de COP)")
grid()  # cuadricula completa, detras de los puntos
# Segunda pasada: puntos, tendencia y leyenda sobre la cuadricula
points(df$consumo_kwh, df$costo_miles_cop,
       col = sector_colors[df$sector], pch = 19, cex = 0.6)
abline(lm(costo_miles_cop ~ consumo_kwh, data = df), lty = 2)
legend("topleft", legend = names(sector_colors),
       col = sector_colors, pch = 19, cex = 0.8)
dev.off()

# ---- Participacion por sector en el consumo total (se usa en ambas) ----
share <- aggregate(consumo_kwh ~ sector, data = df, FUN = sum)
share$pct <- share$consumo_kwh / sum(share$consumo_kwh) * 100
share <- share[order(share$pct), ]  # ordenado ascendente

# ---- Barras horizontales ordenadas (version CORRECTA de la torta) ----
png(file.path(good_dir, "barh_sector_share.png"),
    width = 1950, height = 950, res = 300)
par(mar = c(4, 6, 3, 1))
# Primera pasada: establece el area de trazado
bar_pos <- barplot(share$pct, names.arg = share$sector, horiz = TRUE,
                   col = NA, border = NA, xlim = c(0, 100),
                   main = "Participación por sector en el consumo total (R)",
                   xlab = "Participación (%)", las = 1)
grid(nx = NULL, ny = NA)  # solo lineas verticales, detras de las barras
# Segunda pasada: barras sobre la cuadricula
barplot(share$pct, horiz = TRUE, col = "#2b8cbe", border = NA,
        add = TRUE, axes = FALSE, names.arg = rep("", 3))
text(x = share$pct + 4, y = bar_pos,
     labels = sprintf("%.1f%%", share$pct), cex = 0.8)
dev.off()

# ============================================================
# GRAFICA MAL DISEÑADA (bad_design) - ejemplo para analisis critico
# Errores intencionales: titulo vago sin unidades, sin etiquetas
# de datos, colores saturados sin funcion, leyenda separada,
# angulo de inicio arbitrario, comparacion basada en angulos/areas
# ============================================================

# ---- Torta mal diseñada (version INCORRECTA) ----
png(file.path(bad_dir, "pie_sector_share_bad.png"),
    width = 1560, height = 1080, res = 300)
par(mar = c(1, 1, 3, 8))
pie(share$consumo_kwh, labels = NA,
    col = c("#ff00ff", "#00ffff", "#ffff00"),
    init.angle = 17, border = "grey40",
    main = "Consumo")
legend("topright", inset = c(-0.35, 0), xpd = TRUE,
       legend = share$sector, cex = 0.8,
       fill = c("#ff00ff", "#00ffff", "#ffff00"))
dev.off()

# ---- Verificacion de estadisticos (deben coincidir con Python) ----
aggregate(consumo_kwh ~ sector, data = df, FUN = mean)
cor(df$consumo_kwh, df$costo_miles_cop)  # esperado: 0.998