library(shiny)

ui <- fluidPage(
  # Show a tabset that includes a plot, summary, and
  # table view of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Summary", verbatimTextOutput("summary")),
      tabPanel("Table", tableOutput("table"))
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)