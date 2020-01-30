import sys
import argparse
import logging
import os

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn import datasets
from sklearn.decomposition import PCA
import pandas as pd


logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))


def main():
    """ PCA analysis on iris dataset.
    Reads in data from specified directory, runs analysis, and saves figure.
    """
    # Parse save directory from arguments
    parser = argparse.ArgumentParser(description='Input / Output directories.')
    parser.add_argument('inputdir', type=str, help='Input directory path.')
    parser.add_argument('outdir', type=str, help='Output directory path.')
    args = parser.parse_args()
    INPUT_DIR = args.inputdir
    OUTPUT_DIR = args.outdir

    # Read data
    data = pd.read_csv(INPUT_DIR + 'data' + '.csv', index_col = 'Unnamed: 0').to_numpy()
    target = pd.read_csv(INPUT_DIR + 'target' + '.csv', index_col = 'Unnamed: 0').to_numpy()
    X = data[:, :2]  # only the first two features
    y = target.T[0]

    x_min, x_max = X[:, 0].min() - .5, X[:, 0].max() + .5
    y_min, y_max = X[:, 1].min() - .5, X[:, 1].max() + .5

    plt.figure(2, figsize=(8, 6))
    plt.clf()

    # Plot the training points
    plt.scatter(X[:, 0], X[:, 1], c=y, cmap=plt.cm.Set1,edgecolor='k')
    plt.xlabel('Sepal length')
    plt.ylabel('Sepal width')

    plt.xlim(x_min, x_max)
    plt.ylim(y_min, y_max)
    plt.xticks(())
    plt.yticks(())

    # To getter a better understanding of interaction of the dimensions
    # plot the first three PCA dimensions
    fig = plt.figure(1, figsize=(8, 6))
    ax = Axes3D(fig, elev=-150, azim=110)
    X_reduced = PCA(n_components=3).fit_transform(data)
    ax.scatter(X_reduced[:, 0], X_reduced[:, 1], X_reduced[:, 2], c=y,
               cmap=plt.cm.Set1, edgecolor='k', s=40)
    ax.set_title("First three PCA directions")
    ax.set_xlabel("1st eigenvector")
    ax.w_xaxis.set_ticklabels([])
    ax.set_ylabel("2nd eigenvector")
    ax.w_yaxis.set_ticklabels([])
    ax.set_zlabel("3rd eigenvector")
    ax.w_zaxis.set_ticklabels([])

    # plt.show()
    plt.savefig(OUTPUT_DIR)
    print('PRINT Saved to: {}'.format(OUTPUT_DIR))
    logging.info('Saved to: {}'.format(OUTPUT_DIR))

if __name__ == "__main__":
    logging.info('Starting . . .')
    main()