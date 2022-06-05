library(raster)
library(rgdal)
library(sf)

sl1 <- raster("Terrain Elevation Map/data 1.tif")
sl2 <- raster("Terrain Elevation Map/data 2.tif")
sl3 <- raster("Terrain Elevation Map/data 3.tif")
sl4 <- raster("Terrain Elevation Map/data 4.tif")

sl <- mosaic(sl1, sl2, sl3, sl4, fun=min)

plot(sl2)

e <- as(extent(-72.2, -71.8, -39.12, -38.8), 'SpatialPolygons')
crs(e) <- "+proj=longlat +datum=WGS84 +no_defs"
r <- crop(sl, e)

plot(r)

limite_urbano <- st_read("Data/R09/R09/LIMITE_URBANO_CENSAL_C17.shp")

collico <- st_read("./Terrain Elevation Map/Lago Collico.shp")

r1 <- mask(r, collico, inverse = T)
r2 <- mask(r1, limite_urbano, inverse = T)
plot(r2, main = "Elevación del Terreno entre Cunco y el Lago Collico")
