# palette or color space RColorBrewer::display.brewer.all()

stupidMap = function(dat,
                     mapName,
                     namevar=NULL,
                     valuevar=NULL,
                     palette = "Blues",
                     colorMethod = "numeric",
                     popup = NULL,
                     stroke = T,
                     smoothFactor = 1,
                     weight = 1,
                     fillOpacity = 0.7,
                     legendTitle = "Legend",
                     ...){
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

  if(is.null(popup)){
    countries$popup = countries$name
  }else if(length(popup)!=dim(dat)[1]){
    warning("Length of popup and data don't match, use names instead!")
    countries$popup = countries$name
  }else{
    countries$popup = popup[index]
  }

  countries$value = value[index]

  ##
  # if(is.numeric(value)){
    pal <- leaflet::colorNumeric(
      palette = palette,
      domain = countries$value
    )
  # }else{
  #
  # }


  map <- leaflet::leaflet(countries)
  map %>% leaflet::addTiles() %>%
    leaflet::addPolygons(stroke = stroke,
                smoothFactor = smoothFactor,
                fillOpacity = fillOpacity,
                weight = weight,
                color = ~pal(value),
                popup = ~htmltools::htmlEscape(popup)
    ) %>%
    leaflet::addLegend("bottomright", pal = pal, values = ~value,
              title = legendTitle,
              labFormat = leaflet::labelFormat(prefix = ""),
              opacity = 1
    )


}
#
#
# dat = data.frame(regionNames("city"),
#                 runif(384))
# stupidMap(dat,"city")
