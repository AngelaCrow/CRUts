setwd("/Volumes/TOSHIBA EXT/COBERTURAS/chelsav1/chelsa_cruts")

library(future.apply)
library(terra)

#Precipitation####
future::plan(multisession, workers = parallel::detectCores() - 1)

prec<-list.files("prec", full.names = T, pattern=".tif*");prec
head(prec)
years <- gsub(".*_prec_\\d+_(\\d{4})_.*", "\\1", prec)
files_by_year <- split(prec, years)
dir.create("prec_anual", showWarnings = FALSE)

sum_and_write <- function(file_list, year) {
  r <- rast(file_list)
  r_sum <- sum(r)
  writeRaster(r_sum, filename = file.path("prec_anual", paste0("prec_anual_", year, ".tif")),overwrite = TRUE)
}

future_mapply(
  sum_and_write,
  file_list = files_by_year,
  year = names(files_by_year),
  future.seed = TRUE
)

rm(prec)

#Temperaturr#####
future::plan(multisession, workers = parallel::detectCores() - 1)

#minimum
tmin<-list.files("tmin", full.names = T, pattern=".tif*");prec
head(tmin)
years <- gsub(".*_tmin_\\d+_(\\d{4})_.*", "\\1", prec)
files_by_year <- split(tmin, years)
dir.create("tmin_anual", showWarnings = FALSE)

mean_and_write <- function(file_list, year) {
  r <- rast(file_list)
  r_mean <- mean(r)
  writeRaster(r_mean, filename = file.path("tmin_anual", paste0("tmin_anual_", year, ".tif")), overwrite = TRUE)
}

future_mapply(
  mean_and_write,
  file_list = files_by_year,
  year = names(files_by_year),
  future.seed = TRUE
)

rm(tmin)

#maximum
tmax<-list.files("tmax", full.names = T, pattern=".tif*");prec
head(tmax)
years <- gsub(".*_tmax_\\d+_(\\d{4})_.*", "\\1", prec)
files_by_year <- split(tmax, years)
dir.create("tmax_anual", showWarnings = FALSE)

mean_and_write <- function(file_list, year) {
  r <- rast(file_list)
  r_mean <- mean(r)
  writeRaster(r_mean, filename = file.path("tmax_anual", paste0("tmax_anual_", year, ".tif")),overwrite = TRUE)
}

future_mapply(
  mean_and_write,
  file_list = files_by_year,
  year = names(files_by_year),
  future.seed = TRUE
)
