library("tidyverse")
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

data = read.csv('data/cleanedData.csv', stringsAsFactors = FALSE)

data = data %>% group_by(County) %>% summarise(Population_mean = mean(Population), AidAmount_mean = mean(AidAmount),
                                               CrimesReported_mean = mean(CrimesReported))

data = data %>% mutate(data, AidPerCap = AidAmount_mean / Population_mean, CrimesPerCap = 
                         CrimesReported_mean / Population_mean, HighCrime = if_else(CrimesPerCap > 0.035, 1, 0))

sorted <- data[order(-data$CrimesPerCap),]

sorted

set.seed(12)

ran <- sample(1:nrow(sorted), 0.85 * nrow(sorted)) 

##the normalization function is created
nor <-function(x) { (x -min(x))/(max(x)-min(x))   }

##Run nomalization on first 4 coulumns of dataset because they are the predictors
sorted_norm <- as.data.frame(lapply(sorted[,c(3,5)], nor))

summary(sorted_norm)

sorted_train <- sorted_norm[ran,] ##extract testing set
sorted_test <- sorted_norm[-ran,]  ##extract 5th column of train dataset because it will be used as 'cl' argument in knn function.
sorted_target_category <- sorted[ran,7] ##extract 5th column if test dataset to measure the accuracy
sorted_test_category <- sorted[-ran,7]##load the package class
library(class) ##run knn function
pr <- knn(train = sorted_train, test = sorted_test, cl = sorted_target_category$HighCrime, k=5)

##create confusion matrix
tab <- table(pr,sorted_test_category$HighCrime)

##this function divides the correct predictions by total number of predictions that tell us how accurate teh model is.

accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tab)

confusionMatrix(table(pr, sorted_test_category$HighCrime))

i=1
k.optm=1
for (i in 1:28){
  knn.mod <- knn(train = sorted_train, test = sorted_test, cl = sorted_target_category$HighCrime, k=i)
  k.optm[i] <- 100 * sum(sorted_test_category$HighCrime == knn.mod)/NROW(sorted_test_category$HighCrime)
  k=i
  cat(k,'=',k.optm[i],'')}

plot(k.optm, type="b", xlab="K- Value",ylab="Accuracy level")

features = sorted[,c(3,5,7)]

spl = sample.split(features$HighCrime, SplitRatio = 0.75)
train = subset(features, spl==TRUE)
test = subset(features, spl==FALSE)

model_glm <- glm(HighCrime ~ . , family="binomial", data = train)
summary(model_glm)

prop.table(table(train$HighCrime))

test$model_prob <- predict(model_glm, test, type = "response")

test <- test  %>% mutate(model_pred = 1*(model_prob > .53) + 0,
                         HighCrime = 1*(HighCrime == 1) + 0)

test <- test %>% mutate(accurate = 1*(model_pred == HighCrime))
sum(test$accurate)/nrow(test)

test_prob = predict(model_glm, newdata = test, type = "response")
test_roc = roc(test$HighCrime ~ test_prob, plot = TRUE, print.auc = TRUE)


features = sorted[,c(3,5,7)]

model_lda <- lda(HighCrime ~ AidPerCap+AidAmount_mean, data = train)
model_lda

predictions_lda <- data.frame(predict(model_lda, data = train))
predictions_lda

predictions_lda = cbind(test, predictions_lda)

predictions_lda %>%
  count(class, HighCrime)

predictions_lda %>%
  summarize(score = mean(class == HighCrime))

par(mfrow=c(1,1))

