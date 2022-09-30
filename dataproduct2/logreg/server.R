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


data <- read.csv('DATA.csv', stringsAsFactors = FALSE)

set.seed(123)

sorted <- data[order(-data$CrimesPerCap),]

sorted

sorted.subset <- sorted[c('HighCrime','AidAmount_mean','AidPerCap')]

features = sorted[,c(3,5,7)]

shinyServer(function(input, output) {
    
    set.seed(123)
    
    
    clusters <- reactive({
        return(sample.split(features$HighCrime, SplitRatio = input$bins))
    })
    

    
    clusters7 <- reactive({
        train = subset(features, clusters()==TRUE)
        test = subset(features, clusters()==FALSE)
        
        model_glm <- glm(HighCrime ~ . , family="binomial", data = train)
        summary(model_glm)
        
        prop.table(table(train$HighCrime))
        
        test$model_prob <- predict(model_glm, test, type = "response")
        
        test <- test %>% mutate(model_pred = 1*(model_prob > .53) + 0,
                                 HighCrime = 1*(HighCrime == 1) + 0)
        
        test <- test %>% mutate(accurate = 1*(model_pred == HighCrime))
        sum(test$accurate)/nrow(test)
        
        test_prob = predict(model_glm, newdata = test, type = "response")
        test_roc = roc(test$HighCrime ~ test_prob, plot = TRUE, print.auc = TRUE)
    })
    
    clusters8 <- reactive({
        train = subset(features, clusters()==TRUE)
        test = subset(features, clusters()==FALSE)
        
        model_glm <- glm(HighCrime ~ . , family="binomial", data = train)
        summary(model_glm)
        
        prop.table(table(train$HighCrime))
        
        test$model_prob <- predict(model_glm, test, type = "response")
        
        test <- test  %>% mutate(model_pred = 1*(model_prob > .53) + 0,
                                 HighCrime = 1*(HighCrime == 1) + 0)
        
        test <- test %>% mutate(accurate = 1*(model_pred == HighCrime))
        sum(test$accurate)/nrow(test)
    })
    
    
    
    output$selected_var <- renderText((
        paste('Accuracy:',clusters8())
    ))
    
    
    output$tplot <- renderText((
        'Receiver Operating Characteristic'
    ))
    output$plot1 <- renderPlot({
        clusters7()
    })
    
    
    
})

