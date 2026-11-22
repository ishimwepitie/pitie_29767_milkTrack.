# Dataset Card: Milk Quality Dataset

- **Name:** Milk Quality Prediction (milknew.csv)
- **Source:** Kaggle, uploaded by Shrijayan
- **Link:** https://www.kaggle.com/datasets/cpluzshrijayan/milkquality
- **Licence:** Unknown (not stated on the Kaggle page; confirmation requested from the instructor)
- **Format:** CSV
- **Size:** 1,059 records, 8 columns, 26 KB
- **Date collected:** 22 November 2026
- **Personal data:** None

## What one record represents
One milk sample with seven measurements (pH, temperature, taste, odor, fat, turbidity, colour) and a quality grade (low, medium or high).

## Columns
pH, Temprature (spelling as in the source file), Taste, Odor, Fat, Turbidity, Colour, Grade

## Data quality counts
- Total records: 1,059
- Missing values: 0
- Exact duplicate rows: 976 (only 83 unique records)
- pH range: 3 to 9.5
- Temperature range: 34 to 90
- Grade counts: low 429, medium 374, high 256 (total 1,059; no spelling variants)

## Issues noticed
- The header "Temprature" is misspelt in the source and will be renamed in my own tables.
- Many rows are exact duplicates.
- Some values are extreme (pH 3, temperature 90) and may be outliers.
- The file has no farmer, centre or delivery information, so these will be simulated and kept separate from the real quality data.

## Handling
The raw file is stored unchanged in data/raw/milknew.csv.
