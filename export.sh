#!/bin/bash

echo "Number of American citizens released from LEA detention"
echo "select count(*) from requests where lift_reason='United States Citizen Interviewed'" | psql -t sanctuary

echo "Number of American citizens released from ICE detention"
python ice_detention_counter.py
