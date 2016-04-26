

psql sanctuary -c "select count(*) from byyear where det_facility = '$1' order by count desc;"
