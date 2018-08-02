#!/usr/bin/R

#Multiple function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

#Importing the dataset
dataset = read.csv('Salary_Data.csv')
#View(dataset)

#Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
#View(training_set)
#View(test_set)

#Fitting Simple Linear Regression to the Training set
regressor = lm(formula = Salary ~ YearsExperience,
	       data = training_set)
#print(summary(regressor))

#Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)
#print(y_pred)



#Visualising the Training set results
library(ggplot2)
p <- ggplot() + geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),colour = 'red')
p <- p	+ geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),colour = 'blue')
p <- p	+ ggtitle('Salary vs Experience(Training set)')
p <- p	+ xlab('Years of experience') 
p <- p	+ ylab('Salary')
	
plot(p)

#Visualising the Test set results
library(ggplot2)
p2 <- ggplot() + geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),colour = 'red')
p2 <- p2+ geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),colour = 'blue')
p2 <- p2+ ggtitle('Salary vs Experience(Training set)')
p2 <- p2+ xlab('Years of experience') 
p2 <- p2+ ylab('Salary')
	
multiplot(p, p2, cols = 2)


