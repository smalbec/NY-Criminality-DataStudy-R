#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library("dplyr")
library(bslib)

# Define UI for application that draws a histogram

set.seed(123)

data <- read.csv('DATA.csv', stringsAsFactors = FALSE)


shinyUI(fluidPage(
    
    theme = bs_theme(version = 4, bootswatch = "minty"),
    
    set.seed(123),
    
    headerPanel('K Nearest Neighbour Algorithm on New York High Crime Counties'),
    sidebarPanel(
        sliderInput("bins",
                    "Number of k Neighbors:",
                    min = 1,
                    max = 28,
                    value = 28)
    ),
    mainPanel(
        textOutput("selected_var"),
        textOutput("tplot"),
        plotOutput('plot1')
    )
)
)