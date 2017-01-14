##' @title Show the basic shape of the data
##'
##' @description This function create a leaflet map from a name of the mapType like china, city
##'
##' @usage
##' demomap (mapName)
##'
##' @param mapName mapName for loading, eg. 'china', 'city', ...
##'
##'
##' @examples
##' demomap("china")
##' @export
demomap = function(mapName){
  # if(.Platform$OS.type == "windows"){
  #   locate = Sys.getlocale("LC_CTYPE")
  #   Sys.setlocale("LC_CTYPE","eng")
  # }

  countries <- readGeoLocal(mapName)
  countries$popup = countries$name
  # countries$color = rainbow(length(countries$name))
  ## Encoding
  # Sys.setlocale("LC_CTYPE","eng")
  # if(.Platform$OS.type == "windows"){
  #   countries$popup = encodingSolution(countries$popup)
  # }

  map <- leaflet::leaflet(countries)
  output = map %>% leaflet::addTiles() %>%
    leaflet::addPolygons(stroke = T,
                smoothFactor = 0.2,
                fillOpacity = 0.2,
                # fillColor = ~color,
                weight = 1,
                popup = ~htmltools::htmlEscape(popup))
#
#   if(.Platform$OS.type == "windows"){
#     Sys.setlocale("LC_CTYPE",locate)
#   }

  return(output)
}
