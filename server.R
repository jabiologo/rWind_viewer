
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rworldxtra)
library(raster)
library(rWind)
library(shape)
library(gdistance)
data(countriesHigh)

my.object <- reactiveValues(my.extent = extent(-180,180,-90,83))

shinyServer(function(input, output) {

  output$map <- renderPlot({
    brush_extent <- input$plot_brush
    if (!is.null(brush_extent)) my.object$my.extent <<- extent(brush_extent$xmin,
                                                              brush_extent$xmax,
                                                              brush_extent$ymin,
                                                              brush_extent$ymax)
    
    plot(crop(countriesHigh,my.object$my.extent))
  })
  
  
  
  observeEvent(input$go, {
    
    brush_extent <- input$plot_brush
    if (!is.null(brush_extent)) my.object$my.extent <<- extent(brush_extent$xmin,
                                                               brush_extent$xmax,
                                                               brush_extent$ymin,
                                                               brush_extent$ymax)
    
    print(input$year)
    print(as.numeric(input$year))
    print(as.numeric(input$month))
    print(as.numeric(input$day))
    print(as.numeric(input$time))
    print(brush_extent$xmin)
    print(brush_extent$xmax)
    print(brush_extent$ymin)
    print(brush_extent$ymax)
    w <- wind.dl(as.numeric(input$year), as.numeric(input$month), as.numeric(input$day), as.numeric(input$time), brush_extent$xmin,
                 brush_extent$xmax,
                 brush_extent$ymin,
                 brush_extent$ymax)
    w2 <- wind.fit(w)
    r_dir<-wind2raster(w2,type="dir")
    r_spe<-wind2raster(w2,type="speed")
    trans <- flow.dispersion(r_dir, r_spe, type = "activo", output = "transitionLayer")
    
    
    
    output$plot_speed <- renderPlot({
      plot(r_spe)
      lines(crop(countriesHigh,my.object$my.extent))
      #alpha=arrowDir(w2)
      #Arrowhead(w2$lon, w2$lat, angle=alpha, arr.length = 0.03, arr.type="curved")
      
      
      if (!is.null(input$start)) {
        print(c(input$start$x,input$start$y))
        my.object$start <- c(input$start$x, input$start$y)
      }
      if (!is.null(input$finish)) {
        print(c(input$finish$x,input$finish$y))
        my.object$finish <- c(input$finish$x, input$finish$y)
      }
      
      
      observeEvent(input$ruta, {
        #AtoB<- shortestPath(trans, c(input$start$x,input$start$y), c(input$finish$x,input$finish$y), output="SpatialLines")
        AtoB<- shortestPath(trans, my.object$start, my.object$finish, output="SpatialLines")
        print(my.object$start)
        print(my.object$finish)
        output$plot_speed <- renderPlot({
          plot(r_spe)
          lines(crop(countriesHigh,my.object$my.extent))
          lines(AtoB, col="red", lwd=10)
        }
        )
        
      }
      )
      
      
    })
    
    
    
  })
  
  
  


})
