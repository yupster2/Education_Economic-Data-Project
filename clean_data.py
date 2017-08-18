import csv
with open('earning_by_education_flat_columns.csv') as earning_csv:
    earning_csv_in = csv.reader(earning_csv)
    next(earning_csv, None)
    for row in earning_csv_in:
        location = row[1].split(',')[0]
        if len(row[1].split(',')) > 1:
           state = row[1].split(',')[-1]
        else:
           state = ""
        for (i,elm) in enumerate(row):
           if elm == "$-" or elm.startswith("-$"):
              row[i] = ""
        print(row[0] + "," + location + "," + state + "," + ",".join(row[2:]))
