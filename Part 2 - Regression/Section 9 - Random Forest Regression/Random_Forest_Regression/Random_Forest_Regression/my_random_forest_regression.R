# Random Forest Regression

dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting Decision Tree Regression to the dataset
#install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor = randomForest( x = dataset[1], y = dataset$Salary, ntree = 500)



# Predicting a new result
y_pred = predict(regressor, data.frame(Level = 6.5))
cat(sprintf("X: 6.5, y_pred: %f\n", y_pred))


# Visualising the Decision Tree Regression results
library(ggplot2)
X_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
p <- ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red')
p <- p	+ geom_line(aes(x = X_grid, y = predict(regressor, newdata = data.frame(Level = X_grid))),colour = 'blue')
p <- p	+ ggtitle('Salary vs Experience(Random Forest Regression)')
p <- p	+ xlab('Level') 
p <- p	+ ylab('Salary')
plot(p)

