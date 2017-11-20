from random import randint


import numpy as np
import pandas as pd
import matplotlib
from sklearn.linear_model import LinearRegression

matplotlib.use('Agg')
import matplotlib.pyplot as plt


def main():
    timestamps = [pd.to_datetime(1511205513 + t, unit="s") for t in range(0, 100)]
    values = [v + randint(0, 9) for v in range(0, 100)]
    series = pd.Series(values, timestamps)

    X = [i for i in range(0, len(series))]
    X = np.reshape(X, (len(X), 1))
    y = series.values
    model = LinearRegression()
    model.fit(X, y)

    trend = model.predict(X)

    plt.plot(y)
    plt.plot(trend)
    plt.savefig("/src/plot.png")

    print("Finished integration tests")

if __name__ == "__main__":
    main()
