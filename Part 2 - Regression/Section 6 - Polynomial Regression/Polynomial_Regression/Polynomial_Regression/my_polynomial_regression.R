# Polynomial Regression

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


# Importing the dataset
dataset = read.csv("Position_Salaries.csv")
#View(dataset)
dataset = dataset[2:3]
#View(dataset)

# Splitting the dataset into the Training set and Test set
#The dataset is to small ....

# Feature Scaling
#The package will handle this for us

# Fitting Linear Regression to the dataset
lin_reg = lm(formula = Salary ~ .,
	     data = dataset)
#print(summary(lin_reg))

# Fitting Polynomial Regression to the dataset
dataset$Level2 = dataset$Level ^ 2
dataset$Level3 = dataset$Level ^ 3
dataset$Level4 = dataset$Level ^ 4

#View(dataset)
poly_reg = lm(formula = Salary ~ .,
	      data = dataset)
#print(summary(poly_reg))

# Visualising the Linear Regression results
library(ggplot2)
p <- ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red')
p <- p	+ geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),colour = 'blue')
p <- p	+ ggtitle('Salary vs Experience(Linear Regression)')
p <- p	+ xlab('Level') 
p <- p	+ ylab('Salary')
#plot(p)	
# Visualising the Polynomial Regression results
library(ggplot2)
p2 <- ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red')
p2 <- p2+ geom_line(aes(x = dataset$Level, y = predict(poly_reg, newdata = dataset)),colour = 'blue')
p2 <- p2+ ggtitle('Salary vs Experience(Polynomial Regression)')
p2 <- p2+ xlab('Years of experience') 
p2 <- p2+ ylab('Salary')
	
multiplot(p, p2, cols = 2)

# Predicting a new result with Linear Regression
y_pred = predict(lin_reg, data.frame(Level = 6.5))
print(y_pred)


# Predicting a new result with Polynomial Regression
y_pred = predict(poly_reg, data.frame(Level = 6.5, Level2 = 6.5^2, Level3 = 6.5^3, Level4 = 6.5^4))
print(y_pred)





