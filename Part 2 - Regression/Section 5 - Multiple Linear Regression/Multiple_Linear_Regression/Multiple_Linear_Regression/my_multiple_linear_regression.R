#!/usr/bin/r

    backwardElimination <- function(x, sl) {
        numVars = length(x)
        for (i in c(1:numVars)){
          regressor = lm(formula = Profit ~ ., data = x)
          maxVar = max(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"])
          if (maxVar > sl){
            j = which(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"] == maxVar)
            x = x[, -j]
          }
          numVars = numVars - 1
        }
        return(summary(regressor))
      }
      
#Multiple Linear Regression
#Importing the dataset
dataset = read.csv('50_Startups.csv')
#View(dataset)

#Encoding categorical data
dataset$State = factor(dataset$State,
		       levels = c('New York', 'California', 'Florida'),
		       labels = c(1, 2, 3))
#View(dataset)

#Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
#View(dataset)
#View(training_set)
#View(test_set)

#Feature Scaling
#The package will handle this

#Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~ .,
	       data = training_set)
#print(summary(regressor))

#Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)
#print(y_pred)

#Building the optimal model using Backward Elimination
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
	       data = dataset)
print(summary(regressor))


regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend ,
	       data = dataset)
print(summary(regressor))


regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend ,
	       data = dataset)
print(summary(regressor))


regressor = lm(formula = Profit ~ R.D.Spend ,
	       data = dataset)
print(summary(regressor))


#backResult = backwardElimination(dataset, 0.07)
#print(backResult)

