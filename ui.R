
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
      
      selectInput("year", "Year",
                  c(2011, 2012, 2013, 2014, 2015, 2016, 2017), multiple = FALSE,
                  selected = NULL), 
      selectInput("month", "Month",
                  c(seq(1,12,1)), multiple = FALSE,
                  selected = NULL),
      selectInput("day", "Day",
                  c(seq(1,31,1)), multiple = FALSE,
                  selected = NULL),
      selectInput("time", "Time (24 hours format)",
                  c(0, 3, 6, 9, 12, 15, 18, 21), multiple = FALSE,
                  selected = NULL),
      
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("map"),
      plotOutput("distPlot")
      
    )
  )
))
