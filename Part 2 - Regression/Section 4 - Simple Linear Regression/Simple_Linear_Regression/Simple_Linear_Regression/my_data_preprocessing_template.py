#!/usr/bin/python3


#Importing libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


#Importing the dataset
dataset = pd.read_csv('Salary_Data.csv')
print(dataset)
X = dataset.iloc[:, :-1].values
Y = dataset.iloc[:, 1].values
#print(X)
#print(Y)


#Splitting the dataset into the Training set and Test set
from sklearn.cross_validation import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 1/3, random_state = 0)
#print(X_train)
#print(X_test)
#print(Y_train)
#print(Y_test)


#Feature Scaling
#Most libraries will take care this step


#Fitting Simple Linear Regression to the Training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, Y_train)


#Predicting the Test set results
Y_pred = regressor.predict(X_test)
#print(Y_pred)
#print(Y_test)
#print(Y_test - Y_pred)


# Visualising the Training set results
plt.subplot(2, 1, 1)
plt.scatter(X_train, Y_train, color = 'red')
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Training set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
#plt.show()

# Visualising the Test set results
plt.subplot(2, 1, 2)
plt.scatter(X_test, Y_test, color = 'red')
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Test set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
plt.show()





