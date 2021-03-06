
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# :)

library(shiny)
library(rworldxtra)

shinyUI(fluidPage(

  # Application title
  titlePanel("rWind Viewer"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h4("Choose a date to compute rWind"),
      selectInput("year", "Year",
                  c(2011, 2012, 2013, 2014, 2015, 2016, 2017), multiple = FALSE,
                  selected = 2014), 
      selectInput("month", "Month",
                  c(seq(1,12,1)), multiple = FALSE,
                  selected = NULL),
      selectInput("day", "Day",
                  c(seq(1,31,1)), multiple = FALSE,
                  selected = NULL),
      selectInput("time", "Time (24 hours format)",
                  c(0, 3, 6, 9, 12, 15, 18, 21), multiple = FALSE,
                  selected = NULL),
      h4("Press the button when date and extent are defined"),
      actionButton("go", "Compute"),
      h4("To calculate a min cost route, select an origin (one click) and destination (double click) on the winds map and press the button"),
      actionButton("ruta", "Route")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("map", brush = "plot_brush"),
      plotOutput("plot_speed", click ="start" , dblclick ="finish" )
  
      
    )
  )
))
