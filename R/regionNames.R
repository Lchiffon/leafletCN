##' @title Show regions in submaps
##'
##' @description show regions in the map
##'
##' @usage
##' regionNames(mapName)
##'
##' @param mapName for loading, eg. 'china', 'city', ...
##'
##' @examples
##' regionNames('city')
##' @export

regionNames = function(mapName=NULL){
  # city = 'china'
  if(is.null(mapName)){
    print(mapNames$name)
    cat("\nThese are valid mapName~\n")
    return("NULL")
  }

  ## read from local files
  countries <- readGeoLocal(mapName)

  ## convert Encoding in Windows
  if(.Platform$OS.type == "windows"){
    encodingSolution(countries$name)
  }

  countries$name
}
