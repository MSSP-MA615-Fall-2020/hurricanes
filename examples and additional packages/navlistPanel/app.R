library(shiny)

ui <- fluidPage(
  fluidPage(
    titlePanel("Application Title"),
    navlistPanel(
      "Header",
      tabPanel("First"),
      tabPanel("Second"),
      tabPanel("Third")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)