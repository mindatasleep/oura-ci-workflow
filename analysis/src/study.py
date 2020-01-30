# Main Study
import os

import pandas as pd
import logging


logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))


def main():
	print('Run main()...')


if __name__=="__main__":
	logging.warning('@@@@@@@@ LOGGING @@@@@@@@@@')

	main()
