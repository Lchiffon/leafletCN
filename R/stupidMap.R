stupidMap = function(dat,
                     mapName,
                     namevar=NULL,
                     valuevar=NULL,
                     palette = "Blues",
                     popup = NULL,
                     stroke = T,
                     smoothFactor = 1,
                     weight = 1,
                     fillOpacity = 0.7,...){

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
  index = sapply(name,function(x) which(x==countries$name))

  if(is.null(popup)){
    countries$popup = countries$name
  }else if(length(popup)!=dim(dat)[1]){
    warning("Length of popup and data don't match, use names instead!")
    countries$popup = countries$name
  }else{
    countries$popup = popup[index]
  }

  countries$value = value[index]


  pal <- leaflet::colorNumeric(
    palette = palette,
    domain = countries$value
  )

  map <- leaflet::leaflet(countries)
  map %>% leaflet::addTiles() %>%
    leaflet::addPolygons(stroke = stroke,
                smoothFactor = smoothFactor,
                fillOpacity = fillOpacity,
                weight = weight,
                color = ~pal(value),
                popup = ~htmltools::htmlEscape(popup),...
    )


}
#
#
# dat = data.frame(cityNames("china"),
#                 runif(384))
# stupidMap(dat,"city")
