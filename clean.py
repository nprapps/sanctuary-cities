#!/usr/bin/python

import csv
from datetime import datetime
import re
def process_csv(filename):
    with open('dataimport/%s' % filename, 'rU') as f:
        reader = csv.DictReader(f)
        writecsv(reader, filename)

def writecsv(data, filename):
    fieldnames = ['date','lift_reason', 'det_facility', 'city', 'state', 'detainer_type']
    with open('processed/%s' % filename, 'w') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        for row in data:
            date = row.get('Prepare Date')
            if date:
                parsed_date = datetime.strptime(date, '%m/%d/%y' )
                postgres_date = parsed_date.strftime('%Y-%m-%d')
            full_row = {
                'date': postgres_date,
                'lift_reason': row.get('Detainer Lift Reason'),
                'det_facility': row.get('Detainer Detention Facility'),
                'city': row.get('City'),
                'state': row.get('State'),
                'detainer_type': row.get('Detainer Type')
            }
            writer.writerow(full_row)

if __name__ == '__main__':
    for filename in ['FY08.csv', 'FY09.csv', 'FY10.csv', 'FY11_12.csv', 'FY13_14.csv', 'FY15YTD.csv']:
        process_csv(filename)

def process_csv(filename):
    with open('raw/%s' % filename, 'rU') as f:
        reader = csv.reader(f)
        data = list(reader)
        writecsv(data, filename)

def writecsv(data, filename):
    fieldnames = ['pvt_facility',
                  'city_or_state',
                  'customer',
                  'capacity',
                  'security_level',
                  'facility_type',
                  'term',
                  'renewal_option']
    i = 0
    processed_data = []
    while i < len(data) - 1:
        facility_row = data[i]
        location_row = data[i+1]
        customer = '{0} {1}'.format(facility_row[1].strip(), location_row[1].strip())
        security_level = '{0} {1}'.format(facility_row[3].strip(), location_row[3].strip())
        facility_type = '{0} {1}'.format(facility_row[3].strip(), location_row[3].strip())
        term = '{0} {1}'.format(facility_row[5].strip(), location_row[5].strip())

        full_row = {
            'pvt_facility': facility_row[0].strip(),
            'city_or_state': location_row[0].strip(),
            'customer': customer,
            'capacity': facility_row[2].strip(),
            'security_level': security_level,
            'facility_type': facility_type,
            'term': term,
            'renewal_option': facility_row[6].strip()
        }
        processed_data.append(full_row)
        i += 2

    with open('processed/%s' % filename, 'w+') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writerows(processed_data)

if __name__ == '__main__':
    for filename in ['cca_managedonly.csv','cca_owned_managed.csv']:
        process_csv(filename)

def process_csv(filename):
    with open('raw/%s' % filename, 'rU') as f:
        reader = csv.reader(f)
        data = list(reader)
        writecsv(data, filename)

def writecsv(data, filename):
    fieldnames = ['pvt_facility',
                  'city_or_state',
                  'customer',
                  'capacity',
                  'security_level',
                  'facility_type',
                  'term',
                  'renewal_option']
    i = 0
    processed_data = []
    while i < len(data) - 2:
        facility_row = data[i]
        location_row = data[i+1]
        blank_row = data[i+2]
        customer = '{0} {1} {2}'.format(facility_row[1].strip(), location_row[1].strip(), black_row[1].strip())

        full_row = {
            'pvt_facility': facility_row[0].strip(),
            'city_or_state': location_row[0].strip(),
            'customer': customer,
            'capacity': facility_row[2].strip(),
            'security_level': facility_row[3].strip(),
            'facility_type': facility_row[4].strip(),
            'term': facility_row[5].strip(),
            'renewal_option': facility_row[6].strip()
        }
        processed_data.append(full_row)
        i += 3

        with open('processed/%s' % filename, 'w+') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writerows(processed_data)

    if __name__ == '__main__':
        for filename in ['cca_leased']:
            process_csv(filename)


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
            pvt_facility = row[0]
            if pvt_facility:
                first_two_col = re.split(r'[.()]+', row[0])
                pvt_facility = first_two_col[1].strip()
            state = row[0]
            if state:
                state = first_two_col[2].strip()
            capacity = row[1]
            full_row = {
                   'pvt_facility' : pvt_facility,
                   'state' : state,
                   'capacity' : capacity
            }
            writer.writerow(full_row)

if __name__ == '__main__':
    for filename in ['geo_federal.csv']:
        process_csv(filename)

def writecsv(data, filename):
    fieldnames = ['pvt_facility','state','city']
    with open('processed/%s' % filename, 'w') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        for row in data:
            pvt_facility = row[0]
            if pvt_facility:
               first_three_col = re.split(r'[.,:]+', row[0])
               pvt_facility = first_three_col[1].strip()
            city = row[0]
            if city:
               city = first_three_col[1].strip()
            state = row[0]
            if state:
               state = first_three_col[2].strip()
            full_row = {
                 'pvt_facility' : pvt_facility,
                 'state' : state,
                 'city' : city

            }
            writer.writerow(full_row)

if __name__ == '__main__':
    for filename in ['geo_city.csv']:
        process_csv(filename)

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
                    # import ipdb
                    # ipdb.set_trace()
                    if row[1] == '':
                        state = row[0]
                        continue
                    else:
                        capacity = row[1]
                        junk, facility = row[0].split(' ', 1)
                        facility = facility.strip()
                    full_row = {
                         'pvt_facility' : facility,
                         'state' : state,
                         'capacity' : capacity
                    }
                    writer.writerow(full_row)

        if __name__ == '__main__':
            for filename in ['geo_state.csv']:
                process_csv(filename)
