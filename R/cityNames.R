regionNames = function(city){
  # city = '上海'
  countries <- readGeoLocal(city)
  encodingSolution(countries$name)
}
