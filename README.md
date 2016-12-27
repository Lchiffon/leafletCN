# leafletCN
An R gallery for China and other geojson choropleth map in leaflet



Install
```
devtools::install_github("lchiffon/leafletCN")
library(leafletCN)
```

### demo
```
## mapNames
regionNames("china")

## demomap
demomap("china")

## Choropleth Map
dat = data.frame(regionNames("city"),
                 runif(384))
stupidMap(dat,"city")
```

TODO:
- write the document
- add argument to stupidMap
- kill the import rgdal
- get data from web
- get data from geojson
