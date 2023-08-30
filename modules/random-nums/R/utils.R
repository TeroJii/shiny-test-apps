# ui functions
randomUI <- function(id) {
  tagList(
    fluidRow(
      column(width = 2, textOutput(NS(id, "val"))),
      column(width = 10, actionButton(NS(id, "go"), "Go!"))
    )
  )
}

# server function
randomServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    rand <- eventReactive(input$go, sample(100, 1))
    output$val <- renderText(rand())
  })
}
