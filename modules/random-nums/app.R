#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(here)

here::i_am(path = "modules/random-nums/app.R")

# source modules
source(here("modules/random-nums", "R", "utils.R"))

# make app using modules
randomNumApp <- function() {
  ui <- fluidPage(
    # two rows and two columns of random nums
    fluidRow(
      column(width = 6, randomUI("rand1")),
      column(width = 6, randomUI("rand2"))
    ),
    fluidRow(
      column(width = 6, randomUI("rand3")),
      column(width = 6, randomUI("rand4"))
    )
  )
  server <- function(input, output, session) {
    randomServer("rand1")
    randomServer("rand2")
    randomServer("rand3")
    randomServer("rand4")
  }
  shinyApp(ui, server)
}

# run app
randomNumApp()
