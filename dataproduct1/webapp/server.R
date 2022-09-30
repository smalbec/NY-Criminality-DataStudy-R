#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library('psych')
    library("dplyr")  
library('ggplot2')
library('RColorBrewer')
library('ggExtra')
library('readr')
library('caret')
library('ISLR')
library('MASS')
library('caTools')
library('glmnet')
library('klaR')
library(pROC)
library(class)


# Define server logic required to draw a histogram
# shinyServer(function(input, output) {
#     
#     output$distPlot <- renderPlot({
# 
#         # generate bins based on input$bins from ui.R
#         x    <- faithful[, 2]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white')
# 
#     })
# 
# })

data <- read.csv('DATA.csv', stringsAsFactors = FALSE)

set.seed(123)

sorted <- data[order(-data$CrimesPerCap),]

sorted


sorted.subset <- sorted[c('HighCrime','AidAmount_mean','AidPerCap')]

#Normalization
normalize <- function(x) {
    return ((x - min(x)) / (max(x) - min(x))) }

sorted.subset.n <- as.data.frame(lapply(sorted.subset[,2:3], normalize))

dat.d <- sample(1:nrow(sorted.subset.n),size=nrow(sorted.subset.n)*0.7,replace = FALSE) #random selection of 70% data.

train.sorted <- sorted.subset[dat.d,] # 70% training data
test.sorted <- sorted.subset[-dat.d,] # remaining 30% test data

train.sorted_labels <- sorted.subset[dat.d,1]
test.sorted_labels <-sorted.subset[-dat.d,1]

shinyServer(function(input, output) {
    
    set.seed(123)
    
    selectedData <- reactive({
        input$bins
    })
    
    
    clusters <- reactive({
        return(knn.26 <- knn(train=train.sorted, test=test.sorted, cl=train.sorted_labels, k=input$bins))
    })
    
    acc <- reactive({
        return(CC.26 <- 100 * sum(test.sorted_labels == clusters())/NROW(test.sorted_labels))
    })
    
    
    output$selected_var <- renderText((
        paste('Accuracy',acc())
    ))
    
    i=1
    k.optm=1
    for (i in 1:28){
        knn.mod <- knn(train=train.sorted, test=test.sorted, cl=train.sorted_labels, k=i)
        k.optm[i] <- 100 * sum(test.sorted_labels == knn.mod)/NROW(test.sorted_labels)
        k=i
        cat(k,'=',k.optm[i],'
')}
    
    
    output$tplot <- renderText((
        'Plot of Accuracy of the KNN model for ‘K’ values ranging from 1 to 28 (Not reactive)'
    ))
    output$plot1 <- renderPlot({
        plot(k.optm, type="b", xlab="K- Value",ylab="Accuracy level")
    })
    
    
    

    
})

