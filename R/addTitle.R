##' @title Add title to the leaflet
##'
##' @description Function for creating a h1 title to the leaflet
##'
##' @usage
##' addTitle(object, text, color = "black", fontSize = "20px",
##'  fontFamily = "Sans", leftPosition = 50, topPosition = 2)
##'
##' @param object an leaflet object
##' @param text content of the title
##' @param color title color, default: 'black'
##' @param fontSize font size for the title default: '20px'
##' @param fontFamily font family for the title, default: 'Sans'
##' @param leftPosition the percent of the title postition to left, default: 50
##' @param topPosition the percent of the title postition to top, default:2
##'
##'
##' @examples
##' demomap('china') %>% addTitle("Hello World")
##'
##' @export
addTitle = function(object,
                    text,
                    color = "black",
                    fontSize = "20px",
                    fontFamily = "Sans",
                    leftPosition = 50,
                    topPosition = 2){

  htmlwidgets::onRender(object, paste0("
                                       function(el,x){
                                       h1 = document.createElement('h1');
                                       h1.innerHTML = '", text ,"';
                                       h1.id='titleh1';
                                       h1.style.color = '", color ,"';
                                       h1.style.fontSize = '",fontSize,"';
                                       h1.style.fontFamily='",fontFamily,"';
                                       h1.style.position = 'fixed';
                                       h1.style['-webkit-transform']='translateX(-50%)';
                                       h1.style.left='",leftPosition ,"%';
                                       h1.style.top='",topPosition,"%';
                                       document.body.appendChild(h1);
                                       }"))
}
