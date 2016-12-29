##' @title Create a leaflet object from a data.frame
##'
##' @description Function for creating a leaflet object from a data.frame and
##' mapType
##'
##' @usage
##' leafletGeo(mapName, dat = NULL, namevar = NULL, valuevar = NULL)
##'
##' @param mapName mapName for loading, eg. 'china', 'city', ...
##' @param dat a data.frame contain regions and values
##' @param namevar show which feature is chosen for name variable
##' @param valuevar show which featue is chosen for value variable
##'
##'
##' @examples
##' dat = data.frame(regionNames("city"),
##'                               runif(384))
##' map = leafletGeo("china", dat)
##' map %>% addTiles() %>%
##'    leaflet::addPolygons(stroke = stroke,
##'    smoothFactor = smoothFactor,
##'    fillOpacity = fillOpacity,
##'    weight = weight,
##'    color = ~pal(value),
##'    popup = ~htmltools::htmlEscape(popup)
##'    ) %>%
##'      leaflet::addLegend("bottomright", pal = pal, values = ~value,
##'                           title = legendTitle,
##'                  labFormat = leaflet::labelFormat(prefix = ""),
##'                  opacity = 1)
##' @export
leafletGeo = function(mapName,
                      dat = NULL,
                      namevar = NULL,
                      valuevar = NULL){
  countries <- readGeoLocal(mapName)
  countries$popup = countries$name
  # if(.Platform$OS.type == "windows"){
  #   countries$popup = encodingSolution(countries$popup)
  # }

  if(is.null(dat)){
    return(
      countries
    )
  }else{
    if(class(dat) != 'data.frame'){
      stop("dat should be a data.frame")
    }
    if(is.null(namevar)){
      name = dat[, 1]
    }else{
      name = evalFormula(namevar,dat)
    }
    name = as.character(name)

    if(is.null(valuevar)){
      value = dat[, 2]
    }else{
      value = evalFormula(valuevar,dat)
    }
    countries <- readGeoLocal(mapName)
    index = sapply(name,function(x) which(x==countries$name)[1])
    countries$value = value[index]
    countries$popup = countries$name
    return(
      countries
    )
  }
}

