##' @title Load amap to leaflet
##'
##' @description Simple function like addTiles()
##'
##' @usage
##' geojsonMap(dat, mapName, namevar=NULL, valuevar=NULL,
##'   palette = "Blues", colorMethod = "numeric",
##'   na.color = "#808080", popup = NULL, stroke = T, smoothFactor = 1,
##'    weight = 1, fillOpacity = 0.7, legendTitle = "Legend", tileType, ...)
##'
##' @param dat a data.frame contain regions and values
##' @param mapName mapName for loading, eg. 'china', 'city', ...
##' @param namevar show which feature is chosen for name variable
##' @param valuevar show which featue is chosen for value variable
##' @param palette The colors or color function that values will be mapped to, see RColorBrewer::display.brewer.all()
##' @param colorMethod set one of the coloe mapping in c("numeric", "bin", "quantile", "Factor")
##' @param na.color The color to return for NA values. Note that na.color=NA is valid.
##' @param popup a character vector of the HTML content for the popups (you are recommended to escape the text using htmlEscape() for security reasons)
##' @param stroke whether to draw stroke along the path (e.g. the borders of polygons or circles)
##' @param smoothFactor how much to simplify the polyline on each zoom level (more means better performance and less accurate representation)
##' @param weight stroke width in pixels
##' @param fillOpacity fill opacity
##' @param legendTitle legend title
##' @param tileType function to define tile like amap or leaflet::addTiles
##' @param ... other paramter pass to the color mapping function
##'
##' @examples
##' dat = data.frame(name = regionNames("china"),
##'                  value = runif(34))
##' geojsonMap(dat,"china")
##'
##' dat$value2 = cut(dat$value, c(0, 0.25, 0.5, 1))
##' geojsonMap(dat,"china",
##'   namevar = ~name,
##'   valuevar = ~value2,
##'   palette="Reds",
##'   colorMethod="factor")
##'
##' geojsonMap(dat,"china",
##'   namevar = ~name,
##'   valuevar = ~value2,
##'   palette = topo.colors(3),
##'   colorMethod="factor")
##' @export
geojsonMap= function(dat,
                     mapName,
                     namevar=NULL,
                     valuevar=NULL,
                     palette = "Blues",
                     colorMethod = "numeric",
                     na.color = "#808080",
                     popup = NULL,
                     stroke = T,
                     smoothFactor = 1,
                     weight = 1,
                     fillOpacity = 0.7,
                     legendTitle = "Legend",
                     tileType = amap,
                     ...){
  if(class(dat) != 'data.frame'){
    stop("dat should be a data.frame")
  }
  if(is.null(namevar)){
    name = dat[, 1] %>% toLabel()
  }else{
    name = evalFormula(namevar,dat) %>% toLabel()
  }
  name = as.character(name)

  if(is.null(valuevar)){
    value = dat[, 2]
  }else{
    value = evalFormula(valuevar,dat)
  }


  countries <- readGeoLocal(mapName)
  countries$label = toLabel(countries$name)
  index = sapply(countries$label,function(x) which(name==x)[1])

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
  if(colorMethod == "numeric"){
    pal <- leaflet::colorNumeric(
      palette = palette,
      domain = countries$value,
      na.color = na.color,
      ...
    )
  }else if( colorMethod == "bin" ){
    pal <- leaflet::colorBin(
      palette = palette,
      domain = countries$value,
      na.color = na.color,
      ...
    )
  }else if(colorMethod == "quantile"){
    pal <- leaflet::colorQuantile(
      palette = palette,
      domain = countries$value,
      na.color = na.color,
      ...
    )
  }else if(colorMethod == "factor"){
    pal <- leaflet::colorFactor(
      palette = palette,
      domain = countries$value,
      na.color = na.color,
      ...
    )
  }else{
    pal <- leaflet::colorNumeric(
      palette = palette,
      domain = countries$value,
      na.color = na.color,
      ...
    )
  }


  map <- leaflet::leaflet(countries)
  map %>% tileType %>%
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
