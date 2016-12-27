amap = function(map){
  leaflet::addTiles(map,
           'http://webrd02.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}',
           leaflet::tileOptions(tileSize=256,  minZoom=3,maxZoom=17),
           attribution = '&copy; <a href="http://amap.com">高德地图</a >',  )
}
