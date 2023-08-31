#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

ui <- fluidPage(
  selectInput("x", "X variable", choices = names(iris)),
  selectInput("y", "Y variable", choices = names(iris)),
  selectInput("geom", "geom", c("point", "smooth", "jitter", "area")),
  plotOutput("plot")
)
server <- function(input, output, session) {
  plot_geom <- reactive({
    # user input on "geom" is selected from a list of alternatives
    switch(input$geom,
           point = geom_point(),
           smooth = geom_smooth(se = FALSE),
           jitter = geom_jitter(),
           area = geom_area()
    )
  })

  output$plot <- renderPlot({
    ggplot(iris, aes(.data[[input$x]], .data[[input$y]])) +
      plot_geom()
  }, res = 96)
}

# Run the application
shinyApp(ui = ui, server = server)
