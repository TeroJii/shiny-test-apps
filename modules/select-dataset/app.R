#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# modules
datasetInput <- function(id, filter = NULL) {
  names <- ls("package:datasets")
  if (!is.null(filter)) {
    data <- lapply(names, get, "package:datasets")
    names <- names[vapply(data, filter, logical(1))]
  }

  selectInput(NS(id, "dataset"), "Pick a dataset", choices = names)
}

datasetServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive(get(input$dataset, "package:datasets"))
  })
}

# app
datasetApp <- function(filter = NULL) {
  ui <- fluidPage(
    fluidRow(h1("Choose a dataset")),
    datasetInput("dataset", filter = filter),
    shiny::sliderInput(inputId = "n", label = "Num. Obs.", min = 1, max = 20, value = 6),
    h2("Display the head of the dataset"),
    tableOutput("data")
  )
  server <- function(input, output, session) {
    data <- datasetServer("dataset")
    output$data <- renderTable(head(data(), n = input$n))
  }
  shinyApp(ui, server)
}

# Run the application
datasetApp()
