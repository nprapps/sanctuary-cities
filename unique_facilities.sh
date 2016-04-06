psql sanctuary -c "select distinct(det_facility) from requests where city = '$1' and state = '$2';"
