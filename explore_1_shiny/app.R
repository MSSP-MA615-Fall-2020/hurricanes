library(tidyverse)
library(shiny)

# download the hurricaneexposure package
library(drat)
addRepo("geanders")
library(hurricaneexposuredata)


# attach the hurr_tracks data
data("hurr_tracks")
data_ht <- as.data.frame(hurr_tracks)
# add a column "year"
data_ht$year <- substr(data_ht$date, 1, 4)
View(data_ht)
data_ht$date <- as.numeric(data_ht$date)


## for summary data purposes:
##               use wind for wind in knots
##               use precip_max for rain in mm per day
##               for wind and rain: min, max, mean, median
##               for dates earliest and latest dates
##               for storm name separated from year
##               for year  
## 
##   This will result in one row of data for each storm:
##    year, storm, begin_date, end_date, max_wind, max_rain
##
##   Plots x = data, y = rain, size = wind


# Define UI for random distribution app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Explore the Hurricane Data"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Select the year ----
            selectInput("year",
                        "Year:",
                        c("All",
                          unique(data_ht$year))),
            
            # br() element to introduce extra vertical spacing ----
            br(),
            
            # Input: Select the storm name ----
            selectInput("storm",
                        "Storm ID:",
                        c("All",
                          unique(as.character(data_ht$storm_id))))
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Summary", verbatimTextOutput("summary")),
                        tabPanel("Table", DT::dataTableOutput("table"))
            )
            
        )
    )
)

# Define server logic for random distribution app ----
server <- function(input, output) {
    
    # Generate a plot of the data ----
    # E.g. x = data, y = wind
    output$plot <- renderPlot({
        data <- data_ht
        if (input$storm != "All") {
            data <- data[data$storm_id == input$storm,]
        }
        if (input$year != "All") {
            data <- data[data$year == input$year,]
        }
        
        ggplot(data = data, aes(x = date, y = wind)) +
            geom_point() +
            theme_minimal() +
            labs(x = "Date", y = "Wind") +
            ggtitle("Date vs Wind") 
        
    })
    
    # Generate a summary of the data ----
    output$summary <- renderPrint({
        data <- data_ht
        if (input$storm != "All") {
            data <- data[data$storm_id == input$storm,]
        }
        if (input$year != "All") {
            data <- data[data$year == input$year,]
        }
        
        summary(data)
    })
    
    # Generate an table view of the data ----
    output$table <- DT::renderDataTable(DT::datatable({
        data <- data_ht
        if (input$storm != "All") {
            data <- data[data$storm_id == input$storm,]
        }
        if (input$year != "All") {
            data <- data[data$year == input$year,]
        }
        
        data
    }))
    
}



# Run the application 
shinyApp(ui = ui, server = server)
