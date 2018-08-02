#!/usr/bin/env python3

# SVR

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('Position_Salaries.csv')
X = dataset.iloc[:, 1:2].values
Y = dataset.iloc[:, 2].values
Y = Y.reshape(-1, 1)
#print(X)
#print(Y)
# Feature Scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
sc_Y = StandardScaler()
X = sc_X.fit_transform(X)
Y = sc_Y.fit_transform(Y)
#print(X)
#print(Y)
# Fitting SVR to the dataset
from sklearn.svm import SVR
regressor = SVR(kernel = 'rbf')
regressor.fit(X, Y)

# Predicting a new result
y_pred = regressor.predict(sc_X.transform(np.array([6.5]).reshape(-1,1)))
print("X: 6.5, Y: %8.8f" % sc_Y.inverse_transform(y_pred))

# Visualising the Linear Regression results
plt.scatter(sc_X.inverse_transform(X), sc_Y.inverse_transform(Y), color = 'red')
# Making predicting curve more smoothly 
X_grid = np.arange(min(X), max(X), 0.1)
X_grid = X_grid.reshape(-1,1)
X = X_grid

plt.plot(sc_X.inverse_transform(X), sc_Y.inverse_transform(regressor.predict(X)), color = 'blue')
plt.title('Supporting Vector Regression')
plt.xlabel('Level')
plt.ylabel('Salary')
plt.show()






