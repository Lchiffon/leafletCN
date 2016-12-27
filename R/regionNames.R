regionNames = function(mapType=NULL){
  # city = 'china'
  if(is.null(mapType)){
    print(mapNames$name)
    cat("\nThese are valid mapType~\n")
    return("NULL")
  }

  ## read from local files
  countries <- readGeoLocal(mapType)

  ## convert Encoding in Windows
  if(.Platform$OS.type == "windows"){
    encodingSolution(countries$name)
  }

  countries$name
}
