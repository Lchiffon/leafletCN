# leafletCN
An R gallery for China and other geojson choropleth map in leaflet


## Install

### Windows:
```
devtools::install_github("lchiffon/leafletCN")
library(leafletCN)
```


### Mac

Install GDAL on the command line first, e.g., using homebrew
```
brew install gdal
```
Then install rgdal and rgeos
```
install.packages("rgdal", type = "source", configure.args = "--with-gdal-config=/Library/Frameworks/GDAL.framework/Versions/1.11/unix/bin/gdal-config --with-proj-include=/Library/Frameworks/PROJ.framework/unix/include --with-proj-lib=/Library/Frameworks/PROJ.framework/unix/lib")
```

Install
```
devtools::install_github("lchiffon/leafletCN")
library(leafletCN)
```

## Linux

Get deps first
```
sudo apt-get install libgdal1-dev libgdal-dev libgeos-c1 libproj-dev
```

Then install rgdal and rgeos
```
install.packages("rgdal", type = "source")
```


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
