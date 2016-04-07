
psql sanctuary -c "select count(*) from byyear where det_facility = '$1' and year = '2014' order by count desc;"
