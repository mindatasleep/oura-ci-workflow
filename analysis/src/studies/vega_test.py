import sys
import argparse
import logging
import os

import altair as alt
from vega_datasets import data


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
    cars = data.cars()

    chart = alt.Chart(cars).mark_point().encode(
        x='Horsepower',
        y='Miles_per_Gallon',
        color='Origin',
    ).interactive()

    chart.save(OUTPUT_DIR)

    print('PRINT Saved to: {}'.format(OUTPUT_DIR))
    logging.info('Saved to: {}'.format(OUTPUT_DIR))


if __name__ == "__main__":
    logging.info('Starting . . .')
    main()