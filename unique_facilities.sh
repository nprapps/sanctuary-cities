#!/bin/bash
echo `psql sanctuary -c "COPY(select distinct(det_facility) from requests where city = '$1' and state = '$2')TO STDOUT;" | sed -e 's/^/"/;s/$/"/'`
