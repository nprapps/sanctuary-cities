import csv
import dateparser

from datetime import datetime

START_DATE = datetime(2007, 10, 1)
END_DATE = datetime(2015, 7, 19)


def count():
    """
    Count up US citizens
    """
    out = []
    with open('data/ice-detention-outcomes.csv') as f:
        reader = csv.DictReader(f)
        for row in reader:
            completion_date = dateparser.parse(row['Court Closed / Completion Dates'])
            if (completion_date is not None and completion_date >= START_DATE and completion_date <= END_DATE) and (row['Custody1'].lower() == 'detained' or row['Custody2'].lower() == 'detained') and row['Outcome3'].lower() == 'terminated':
                out.append(row)

    return out


if __name__ == '__main__':
    data = count()
    print(len(data))
