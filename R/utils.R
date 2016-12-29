# .onAttach <- function(libname, pkgname ){
#   library(leaflet)
#   library(sp)
# }
globalVariables(c("mapNames", ".triList"))

## Encoding solution
encodingSolution = function(str){
  iconv(str, "UTF-8", "UTF-8")
}

## read function
readGeoLocal = function(city){
  query = toLabel(city)
  if(!any(mapNames$label==query)){
    stop(paste0("\n",
                city,
                ": this mapType cannot found!\n",
                "Please check the mapType name or use icnov to convert encoding.\n",
                "Valid mapTypes: regionNames()\n",
                "Encoding convert: ?iconv"))
  }
  file = paste0("geojson/",
                mapNames$files[mapNames$label==query]
  )
  filePath = system.file(file,package = "leafletCN")

  # output = rgdal::readOGR(filePath, "OGRGeoJSON")
  output = read.geoShape(filePath)
  if(.Platform$OS.type == "windows"){
    output$name = encodingSolution(output$name)
  }

  return(output)
}

## .triList
## Use first two words to match
toLabel = function(city){
  labels = sapply(city, function(x){
    if(tolower(substr(x,1,1)) %in% letters){
      return(tolower(x))
    } else if(grepl(.triList[[1]], x)|
       grepl(.triList[[2]], x)|
       grepl(.triList[[3]], x)|
       grepl(.triList[[4]], x)
    ){
      return(substr(x, 1, 3))
    }else{
      return(substr(x, 1, 2))
    }
  })
  return(labels)
}

## Fork from echarts
evalFormula = function(x, data) {
  # x = ~value; data = mapData
  if (!inherits(x, 'formula')) return(x)
  if (length(x) != 2) stop('The formula must be one-sided: ', deparse(x))
  x_formula = terms.formula(x)
  if (length(attr(x_formula, "term.labels")) == 1){
    eval(x[[2]], data, environment(x))
  }else{
    as.data.frame(sapply(attr(x_formula, "term.labels"),function(tmpTerm){
      return(eval(as.name(tmpTerm), data, environment(x)))
    }),stringsAsFactors=F)
  }
}
