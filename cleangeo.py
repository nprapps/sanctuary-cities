import csv
import re

def process_csv(filename):
    with open('raw/%s' % filename, 'rU') as f:
        reader = csv.reader(f)
        writecsv(reader, filename)

def writecsv(data, filename):
    fieldnames = ['pvt_facility','state','capacity']
    with open('processed/%s' % filename, 'w') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        for row in data:
            facility_col = row[0]
            state = row[0]
            if facility_col[0].isdigit():
              clean_facility_col = facility_col
              pvt_facility = clean_facility_col
              if pvt_facility:
                 first_two_col = re.split(r'[.()]+', clean_facility_col)
                 pvt_facility = first_two_col[1].strip()

            elif not facility_col[0].isdigit():
                 clean_state = facility_col

            capacity = row[1]

            full_row = {
                 'pvt_facility' : pvt_facility,
                 'state' : clean_state,
                 'capacity' : capacity
            }
            writer.writerow(full_row)

if __name__ == '__main__':
    for filename in ['geo_state.csv']:
        process_csv(filename)
