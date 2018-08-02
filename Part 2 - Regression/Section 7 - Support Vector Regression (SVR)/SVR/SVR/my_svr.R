# SVR


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

# Fitting the SVR to the dataset
#install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ ., data = dataset, type = 'eps-regression')

cat(sprintf("X: 6.5, y_pred:%f\n", predict(regressor, data.frame(Level = 6.5))))

# Visualising the SVR results
library(ggplot2)
p <- ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red')
p <- p	+ geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),colour = 'blue')
p <- p	+ ggtitle('Salary vs Level(SVR)')
p <- p	+ xlab('Level') 
p <- p	+ ylab('Salary')
plot(p)

