library(shiny)

ui <- fluidPage(
  navbarPage("App Title",
             tabPanel("Plot"),
             tabPanel("Summary"),
             tabPanel("Table")
  ),
  navbarPage("App Title",
             tabPanel("Plot"),
             navbarMenu("More",
                        tabPanel("Summary"),
                        "----",
                        "Section header",
                        tabPanel("Table")
             )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)