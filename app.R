#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
data(mtcars)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Car performance Comparator"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("cars","Select Cars:",
                     choices = rownames(mtcars),
                     multiple = T,
                     selected = c("Mazda RX4", "Datsun 710")
    ), selectInput("metric", "Performance Metric:",
                   c("MPG" = "mpg",
                     "Horsepower" = "hp",
                     "Quarter Mile Time" = "qsec"))
  ),
  mainPanel(
    plotOutput("comparisonplot")
  )
))

server <- function(input, output) {
  output$comparisonplot <- renderPlot({
    req(input$cars)
    data <- mtcars[rownames(mtcars) %in% input$cars, ]
    ggplot(data, aes( x= rownames(data), y = .data[[input$metric]])) +
      geom_col(fill = "steelblue")+ labs ( title = paste("Comparison of", input$metric),
                                           x = "Car Model", y = input$metric)
  })
}

shinyApp(ui, server)

# Car performance Comparator




