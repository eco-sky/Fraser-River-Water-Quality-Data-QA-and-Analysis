# Environmental Water Quality Data QA and Analysis
**Tools:** Microsoft Access, R, ggplot2  
**Dataset:** Environment and Climate Change Canada (ECCC), Fraser River Long-term Water Quality Monitoring Data

## Project Overview

Conducted data quality assurance (QA) and exploratory analysis of ECCC Fraser River water quality monitoring data to assess data completeness, identify potential anomalies, and investigate relationships between total barium concentrations, turbidity, and nonfilterable residue.

## Data Management and QA

Imported and organized approximately 437,000 water quality records in Microsoft Access. Created table relationships and SQL queries to examine data completeness, potential duplicate records, measurement ranges, and validation status.

Key checks and findings:

- **Completeness:** No missing values were identified in the measurement value, site number, or date/time fields across 437,097 records.
- **Potential duplicates:** No repeated combinations of site, date/time, sample ID, and variable code were identified.
- **Potential anomalies:** Identified four unusually high air-temperature readings, ranging from 78°C to 138°C, for further review rather than automatically classifying them as errors.
- **Validation status:** Examined provisional and validated barium records. Provisional records accounted for 3,841 of 4,098 total-barium records (93.7%).

## Barium Investigation

Focused on total barium measurements at monitoring site BC08MF0001. Summarized annual concentrations, reviewed unusually high observations, and compared selected barium results with associated turbidity and nonfilterable residue measurements.

The highest observed barium concentration was 259 µg/L on May 4, 2023. The record was marked provisional, and its measurement flag was blank. The same sample had turbidity of 255 NTU and nonfilterable residue of 658 mg/L. These findings warrant review but do not establish that the measurement is erroneous.

## Statistical Analysis

Exported 128 paired observations from Access for analysis in R. Used Spearman's rank correlation to assess relationships between total barium and two related water quality measurements.

- **Barium and turbidity:** Spearman's ρ = 0.897, p < 0.001.
- **Barium and nonfilterable residue:** Spearman's ρ = 0.913, p < 0.001.

Both relationships remained strong after excluding the highest barium observation, indicating that the overall associations were not driven solely by that observation. Created scatterplots using ggplot2 to visualize both relationships.

## Key Takeaways

The analysis identified potential anomalies for further investigation and strong positive associations between total barium, turbidity, and nonfilterable residue at the selected monitoring site. The project demonstrates practical skills in relational data management, SQL-based QA checks, data validation review, exploratory statistics, and visualization.

## Limitations

The analysis is observational and focuses on one monitoring site for the barium investigation. Correlation does not establish causation, and provisional records should not automatically be considered invalid. Results are descriptive and do not independently establish regulatory exceedances or environmental impacts.

## Data Source

Environment and Climate Change Canada. *Fraser River Long-term Water Quality Monitoring Data.*

https://open.canada.ca/data/en/dataset/1e0e8033-3113-4297-a813-13ec6f239039
