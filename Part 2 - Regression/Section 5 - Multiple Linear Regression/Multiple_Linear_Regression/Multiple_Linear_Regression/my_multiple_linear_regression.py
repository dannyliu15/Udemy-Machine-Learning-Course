#!/usr/bin/env python3

#Multiple_linear_regression

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import statsmodels.formula.api as sm

def backwardElimination0(x, y, sl):
    numVars = len(x[0])
    for i in range(0, numVars):
        regressor_OLS = sm.OLS(y, x).fit()
        maxVar = max(regressor_OLS.pvalues).astype(float)
        if maxVar > sl:
            for j in range(0, numVars - i):
                if (regressor_OLS.pvalues[j].astype(float) == maxVar):
                    x = np.delete(x, j, 1)
    print(regressor_OLS.summary())
    return x
 
def backwardElimination(x, y, SL):
    numVars = len(x[0])
    temp = np.zeros((50,6)).astype(int)
    for i in range(0, numVars):
        regressor_OLS = sm.OLS(y, x).fit()
        maxVar = max(regressor_OLS.pvalues).astype(float)
        adjR_before = regressor_OLS.rsquared_adj.astype(float)
        if maxVar > SL:
            for j in range(0, numVars - i):
                if (regressor_OLS.pvalues[j].astype(float) == maxVar):
                    temp[:,j] = x[:, j]
                    x = np.delete(x, j, 1)
                    tmp_regressor = sm.OLS(y, x).fit()
                    adjR_after = tmp_regressor.rsquared_adj.astype(float)
                    if (adjR_before >= adjR_after):
                        x_rollback = np.hstack((x, temp[:,[0,j]]))
                        x_rollback = np.delete(x_rollback, j, 1)
                        print (regressor_OLS.summary())
                        return x_rollback
                    else:
                        continue
    print(regressor_OLS.summary())
    return x


#Importing the dataset
dataset = pd.read_csv('50_Startups.csv')
#print(dataset)
X = dataset.iloc[:, :-1].values
Y = dataset.iloc[:, 4].values
#print(X)
#print(Y)

#Encoding categorical data
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
X[:, 3] = labelencoder_X.fit_transform(X[:,3])
#print(X)
onehotencoder = OneHotEncoder(categorical_features = [3])
X = onehotencoder.fit_transform(X)
X = X.toarray()
np.set_printoptions(suppress=True)
#print(X)

#Avoiding the Dummy Variable Trap
X = X[:, 1:]
#print(X)

#Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state = 0)
#print(X_train)
#print(X_test)
#print(Y_train)
#print(Y_test)

#Feature Scaling
#The toolkit handles this


#Fitting Multiple Linear Regression to the Training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, Y_train)

#Predicting the Test set results
Y_pred = regressor.predict(X_test)

#print(Y_test)
#print(Y_pred)
#print(Y_test - Y_pred)

#Building the optimal model using Backward Elimination
import statsmodels.formula.api as sm
#X = np.append(arr = X, values = np.ones((50, 1)).astype(int), axis = 1)
X = np.append(arr = np.ones((50, 1)).astype(int), values = X, axis = 1)
#print(X)
SL = 0.05
X_opt = X[:,[0, 1, 2, 3, 4, 5]]
#regressor_OLS = sm.OLS(endog = Y, exog = X_opt).fit()
X_Modeled = backwardElimination0(X_opt, Y, SL)
#print(regressor_OLS.summary())

