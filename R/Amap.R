##' @title Load amap to leaflet
##'
##' @description Simple function like addTiles()
##'
##' @usage
##' amap(map,attribution = '&copy; <a href="http://amap.com">amp.com</a >',...)
##'
##' @param map   a leaflet object
##' @param attribution attribution of the map
##' @param ... other paramter pass to the addTiles function
##'
##' @examples
##' library(leaflet)
##' leaflet() %>% amap()
##'
##' @export
amap = function(map,
                attribution = '&copy; <a href="http://amap.com">amp.com</a >',
                ...){
  leaflet::addTiles(map,
           'http://webrd02.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}',
           leaflet::tileOptions(tileSize=256,  minZoom=3,maxZoom=17),
           attribution = attribution,
           ...)
}
