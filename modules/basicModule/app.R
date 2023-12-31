#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# ####
# # Non-module way ----
# ####
#
# ui <- fluidPage(
#   selectInput("var", "Variable", names(mtcars)),
#   numericInput("bins", "bins", 10, min = 1),
#   plotOutput("hist")
# )
#
#
# server <- function(input, output, session) {
#   data <- reactive(mtcars[[input$var]])
#   output$hist <- renderPlot({
#     hist(data(), breaks = input$bins, main = input$var)
#   }, res = 96)
# }
#
# # Run the application
# shinyApp(ui = ui, server = server)


####
# Module way ----
####

histogramUI <- function(id) {
  tagList(
    selectInput(NS(id, "var"), "Variable", choices = names(mtcars)),
    numericInput(NS(id, "bins"), "bins", value = 10, min = 1),
    plotOutput(NS(id, "hist"))
  )
}

histogramServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(mtcars[[input$var]])
    output$hist <- renderPlot({
      hist(data(), breaks = input$bins, main = input$var)
    }, res = 96)
  })
}

# Run the application
histogramApp <- function() {
  ui <- fluidPage(
    column(width = 6,
      histogramUI("hist1")
    ),
    column(width = 6,
      histogramUI("hist2")
    )
  )
  server <- function(input, output, session) {
    histogramServer("hist1")
    histogramServer("hist2")
  }
  shinyApp(ui, server)
}

histogramApp()
