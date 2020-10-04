library(tidyverse)
library(shiny)

# the hurricaneexposure package
## here is the package's Github page: https://github.com/geanders/hurricaneexposure
## here is the description document: https://cran.r-project.org/web/packages/hurricaneexposure/hurricaneexposure.pdf
## to see more details about the hurricaneexposure package: https://cran.r-project.org/web/packages/hurricaneexposure/vignettes/hurricaneexposure.html

# download the hurricaneexposure package
library(drat)
addRepo("geanders")
#install.packages("hurricaneexposuredata")
library(hurricaneexposuredata)

# use 2 datasets in the package
# attach the hurr_tracks data
data("hurr_tracks")
data_ht <- as.data.frame(hurr_tracks)
# add a column "year"
data_ht$year <- substr(data_ht$date, 1, 4)

# attach the rain data
data("rain")
data_rain <- as.data.frame(rain)


ui <- fluidPage(
    title = "Examples of Data Tables",
    sidebarLayout(
        tabsetPanel(
            conditionalPanel(
                'input.dataset === "data_ht"'),
            
            conditionalPanel(
                'input.dataset === "data_rain"',
            )
        ),
        mainPanel(
            tabsetPanel(
                id = 'dataset',
                tabPanel("Storm tracks for Atlantic basin storms data table",
                
                # Create a new Row in the UI for selectInputs
                fluidRow(
                    column(4,
                           selectInput("storm",
                                       "Storm ID:",
                                       c("All",
                                         unique(as.character(data_ht$storm_id))))
                    ),
                    column(4,
                           selectInput("year",
                                       "Year:",
                                       c("All",
                                         unique(data_ht$year)))
                    )
                ),
                # Create a new row for the table.
                DT::dataTableOutput("table1")),
                
                tabPanel("Rainfall for US counties during Atlantic basin tropical storms data table",
                
                # Create a new Row in the UI for selectInputs
                fluidRow(
                    column(4,
                           selectInput("storm",
                                       "Storm ID:",
                                       c("All",
                                         unique(as.character(data_rain$storm_id))))
                    ),
                    column(4,
                           selectInput("fips",
                                       "Fips:",
                                       c("All",
                                         unique(data_rain$fips)))
                    )
                ),
                # Create a new row for the table.
                DT::dataTableOutput("table2")))
            )
        )
    )


server <- function(input, output) {
    
    # Filter data based on selections
    output$table1 <- DT::renderDataTable(DT::datatable({
        data <- data_ht
        if (input$storm != "All") {
            data <- data[data$storm_id == input$storm,]
        }
        if (input$year != "All") {
            data <- data[data$year == input$year,]
        }
        
        data
    }))
    
    # sorted columns are colored now because CSS are attached to them
    # Filter data based on selections
    output$table2 <- DT::renderDataTable(DT::datatable({
        data2 <- data_rain
        if (input$storm != "All") {
            data2 <- data2[data_rain$storm_id == input$storm,]
        }
        if (input$fips != "All") {
            data2 <- data2[data_rain$fips == input$fips,]
        }
        
        data2
    }))
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
