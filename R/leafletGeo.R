leafletGeo = function(mapName){
  countries <- readGeoLocal(city)
  countries$popup = countries$name
  if(.Platform$OS.type == "windows"){
    countries$popup = encodingSolution(countries$popup)
  }
  leaflet::leaflet(countries)
}

