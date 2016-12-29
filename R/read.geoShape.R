# raw = jsonlite::fromJSON("inst/geojson/65.json")
# a$features$geometry$coordinates
#
# b = readGeoLocal("新疆")



# simple example, from scratch:
# Sr1 = Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
# Sr2 = Polygon(cbind(c(5,4,2,5),c(2,3,2,2)))
# Sr3 = Polygon(cbind(c(4,4,5,10,4),c(5,3,2,5,5)))
# Sr4 = Polygon(cbind(c(5,6,6,5,5),c(4,4,3,3,4)), hole = TRUE)
#
# Srs1 = Polygons(list(Sr1), "s1")
# Srs2 = Polygons(list(Sr2), "s2")
# Srs3 = Polygons(list(Sr3, Sr4), "s3/4")
# SpP = SpatialPolygons(list(Srs1,Srs2,Srs3), 1:3)
# plot(SpP, col = 1:3, pbg="white")
# ex_1.7 <- SpatialPolygonsDataFrame(SpP,
#                                    data=data.frame(id=1:3,
#                                                    name=1:3,
#                                                    row.names = row.names(SpP)))
# plot(ex_1.7)

## txt a geoJSON string, URL or file
read.geoShape = function(txt){

  raw = jsonlite::fromJSON(txt)
  # Polygons part

  ployList = lapply(raw$features$geometry$coordinates, function(x){
    if(class(x) == "array"){
      a = as.vector(x)
      dim(a) = c(length(a)/2,2)
      # if(length(dim(x))==3){
      #   Sr = (sp::Polygon(x[1,,])
      # }else{
      #   Sr = sp::Polygon(x)
      # }
      Sr = sp::Polygon(a)
      Sp = sp::Polygons(list(Sr), "namei")
      return(Sp)
    }else{
      if(any(sapply(x, class) == 'list')){
        whilei = 0
        while(any(sapply(x, class) == 'list')){
          whilei = whilei+1
          if(whilei==10)
            break
          index = which(sapply(x, class)=='list')[1]
          x = append(x[-index],x[[index]])
        }
      }

      Sr = lapply(x,function(y){

        a = as.vector(y)
        dim(a) = c(length(a)/2,2)
        return(sp::Polygon(a))
        # if(length(dim(y))==3){
        #   return(sp::Polygon(y[1,,]))
        # }else{
        #   return(sp::Polygon(y))
        # }
      })
      Sp = sp::Polygons(Sr, "namei")
      return(Sp)
    }
  })

  for(i in 1:length(ployList)){
    ployList[[i]]@ID = as.character(i)
  }
  ployPart =  sp::SpatialPolygons(ployList, 1:length(ployList))

  # dat part
  datPart = raw$features$properties
  if(any(sapply(datPart, class)=='list')){
    index = which(sapply(datPart, class)=='list')
    outlist = lapply(index, function(x){
      out = do.call(rbind,datPart[,x])
      colnames(out) = paste0(names(datPart)[x], 1:dim(out)[2])
      return(out)
    })
    datPart = cbind(datPart, do.call(cbind, outlist))
    datPart = datPart[, -index]
  }
  rownames(datPart) = row.names(ployPart)


  ex_1.7 = sp::SpatialPolygonsDataFrame(ployPart,
                                     datPart)
  return(ex_1.7)
}

#
# files = dir("inst/geojson/")
# for(file in files){
#   cat(file,"\n")
#   a  = geoShapeRead(paste0('inst/geojson/',file))
# }
