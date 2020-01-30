import argparse

from sklearn import datasets
import pandas as pd
import numpy as np


# Parse save directory from arguments
parser = argparse.ArgumentParser(description='Output directory.')
parser.add_argument('outdir', type=str, help='Output directory path.')
args = parser.parse_args()
PATH_DATA = args.outdir

# Import data to play with
iris = datasets.load_iris()


def main():
    """Download and save datasets.
    """
    pd.DataFrame(iris.data).to_csv(PATH_DATA + 'data' + '.csv')
    pd.DataFrame(iris.target).to_csv(PATH_DATA + 'target' + '.csv')


if __name__ == "__main__":
    main()