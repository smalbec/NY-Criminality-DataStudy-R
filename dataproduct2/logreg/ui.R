#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)
library("dplyr")

# Define UI for application that draws a histogram

data <- read.csv('DATA.csv', stringsAsFactors = FALSE)

set.seed(123)


shinyUI(fluidPage(
    
    set.seed(123),
    
    theme = bs_theme(version = 4, bootswatch = "minty"),
    
    headerPanel('Logistic Regression Algorithm on New York High Crime Counties'),
    sidebarPanel(
        sliderInput("bins",
                    "Training set ratio:",
                    min = 0.1,
                    max = 0.9,
                    value = 0.75)
    ),
    mainPanel(
        textOutput("selected_var"),
        textOutput("tplot"),
        plotOutput('plot1')
    )
)
)