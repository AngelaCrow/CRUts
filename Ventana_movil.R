library(terra)

# Parametros
var_name <- "tmin"  # Cambiar por "tmax" o "prec" 
input_dir <- paste0(var_name, "_anual")
output_dir <- paste0(var_name, "_ventana5_mov3")
dir.create(output_dir, showWarnings = FALSE)

# years
years <- 1901:2016

# Inicios de las ventanas: salto de 3 en 3
start_years <- seq(1901, max(years) - 4, by = 3)

# Loop 
for (start in start_years) {
  ventana <- start:(start + 4)
  files <- file.path(input_dir, paste0(var_name, "_anual_", ventana, ".tif"))
  
  if (all(file.exists(files))) {
    r <- rast(files)
    r_mean <- mean(r)
    
    label <- paste0(start, "_", start + 4)
    writeRaster(r_mean,
                filename = file.path(output_dir, paste0(var_name, "_mov3_", label, ".tif")),
                overwrite = TRUE)
  } 
}