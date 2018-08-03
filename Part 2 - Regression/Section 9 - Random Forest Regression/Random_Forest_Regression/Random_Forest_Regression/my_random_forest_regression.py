#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

dataset = pd.read_csv('Position_Salaries.csv')
X = dataset.iloc[:, 1:2].values
Y = dataset.iloc[:, 2].values
X_grid = np.arange(min(X), max(X), 0.01)
X_grid = X_grid.reshape(-1, 1)


from sklearn.ensemble import RandomForestRegressor
n_layers = 0
n_layers_gap = 500
n_plot = 4
for i in range (1,1 + n_plot):
	n_layers = i * n_layers_gap
	regressor2 = RandomForestRegressor(n_estimators = n_layers, random_state = 0)
	regressor2.fit(X, Y)
	
	y_pred2 = regressor2.predict(6.5)
	print("X: 6.5, y_pred: %f(n_estimators = %d)"%(y_pred2, n_layers))
	
	plt.subplot(1, n_plot, i)
	plt.scatter(X, Y, color = 'red')
	plt.plot(X_grid, regressor2.predict(X_grid), color = 'blue')
	str_title = "Truth or Bluff(Random Forest n_layer %d)" % n_layers
	plt.title(str_title)
	plt.xlabel('Position Level')
	plt.ylabel('Salary')


plt.show()

