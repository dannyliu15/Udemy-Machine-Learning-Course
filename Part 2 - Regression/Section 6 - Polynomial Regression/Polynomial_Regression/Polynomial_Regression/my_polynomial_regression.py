#!/usr/bin/env python3

#Polynomial Regression
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#Importing the dataset
dataset = pd.read_csv('Position_Salaries.csv')
print(dataset)
X = dataset.iloc[:, 1:2].values
Y = dataset.iloc[:, 2].values
#print(X)
#print(Y)

#Splitting the dataset into the Training set and Test set
#The dataset is too small... no need to split!!!
#Using the whole dataset to train the model

#Feature Scaling
#The package handles this for us

#Fitting Linear Regression to the dataset
from sklearn.linear_model import LinearRegression
linReg = LinearRegression()
linReg.fit(X, Y)

#Fitting Polynomial Regression to the dataset
from sklearn.preprocessing import PolynomialFeatures
poly_reg = PolynomialFeatures(degree = 4)
X_poly = poly_reg.fit_transform(X)
#print(X_poly)
linReg2 = LinearRegression()
linReg2.fit(X_poly, Y)
#print(linReg2.summary())

#Visualising the Linear Regression results
plt.subplot(1,2,1)
plt.scatter(X, Y, color = 'red')
plt.plot(X, linReg.predict(X), color = 'blue')
plt.title('Linear Regression')
plt.xlabel('Level')
plt.ylabel('Salary')


#Visualising the Polynomial Regression results
X_grid = np.arange(min(X), max(X), 0.1)
X_grid = X_grid.reshape((len(X_grid), 1))
#print(X_grid)
plt.subplot(1,2,2)
plt.scatter(X, Y, color = 'red')
plt.plot(X_grid, linReg2.predict(poly_reg.fit_transform(X_grid)), color = 'blue')
plt.title('Polynomial Regression')
plt.xlabel('Level')
plt.ylabel('Salary')

# Predicting a new result with Polynomial Regression
print(linReg2.predict(poly_reg.fit_transform(6.5)))

# Predicting a new result with Linear Regression
print(linReg.predict(6.5))



plt.show()




