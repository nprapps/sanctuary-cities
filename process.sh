#!/bin/bash

echo "Cleaning data"
python clean.py

# Importing
./import.sh

# Exporting
./export.sh
