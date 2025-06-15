import logging
from logging.handlers import RotatingFileHandler
import time
import random

# Dummy lorem text
LOREM = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum.",
    "Excepteur sint occaecat cupidatat non proident, sunt in culpa.",
]

def setup_logger():
    # Create logger
    logger = logging.getLogger("DummyLogger")
    logger.setLevel(logging.INFO)

    # Configure RotatingFileHandler
    handler = RotatingFileHandler(
        "dummy.log", maxBytes=5 * 1024 * 1024, backupCount=5  # 5 MB max, keep 5 backups
    )
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)

    logger.addHandler(handler)
    return logger

def generate_logs(logger):
    while True:
        # Randomly select a dummy log line
        line = random.choice(LOREM)
        logger.info(line)
        time.sleep(0.01)  # Simulate log generation rate (adjust as needed)

if __name__ == "__main__":
    logger = setup_logger()
    try:
        generate_logs(logger)
    except KeyboardInterrupt:
        print("Log generation stopped.")
