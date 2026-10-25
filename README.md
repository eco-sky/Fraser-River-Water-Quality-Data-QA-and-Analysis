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
- **Validation status:** Provisional records accounted for 3,841 of 4,098 total-barium records (93.7%).

## Barium Investigation

Focused on total barium measurements at monitoring site `BC08MF0001`. Summarized annual concentrations, reviewed unusually high observations, and compared selected barium results with associated turbidity and nonfilterable residue measurements.

The highest observed barium concentration was **259 µg/L on May 4, 2023**. The record was marked provisional, and its measurement flag was blank. The same sample had turbidity of 255 NTU and nonfilterable residue of 658 mg/L. These findings warrant review but do not establish that the measurement is erroneous.

## Statistical Analysis

Exported 128 paired observations from Access for analysis in R. Used Spearman's rank correlation to assess relationships between total barium and two related water quality measurements.

- **Barium and turbidity:** Spearman's ρ = 0.897, p < 0.001.
- **Barium and nonfilterable residue:** Spearman's ρ = 0.913, p < 0.001.

Both relationships remained strong after excluding the highest barium observation, indicating that the associations were not driven solely by that observation.

## Results

### 1. Barium vs. Turbidity


<img width="960" height="488" alt="Scatterplot of total barium concentration versus turbidity" src="https://github.com/user-attachments/assets/7eeb6d9e-20f7-4c1e-8c8a-59a12d4bb7c3" />

*Figure 1. Total barium concentration versus turbidity at monitoring site BC08MF0001. Spearman's ρ = 0.897.*



<img width="960" height="488" alt="Scatterplot of total barium concentration versus turbidity with regression line" src="https://github.com/user-attachments/assets/eef3de2b-9a69-4417-b36e-e9cdcbdcf09e" />

*Figure 2. Total barium concentration versus turbidity with a linear regression trend line.*

### 2. Barium vs. Nonfilterable Residue



<img width="960" height="488" alt="Scatterplot of total barium concentration versus nonfilterable residue" src="https://github.com/user-attachments/assets/0b80472b-a2f9-4f31-9628-f8d28905639a" />



*Figure 3. Total barium concentration versus nonfilterable residue at monitoring site BC08MF0001. Spearman's ρ = 0.913.*


<img width="960" height="488" alt="Scatterplot of total barium concentration versus nonfilterable residue with regression line" src="https://github.com/user-attachments/assets/d35674b2-8a16-4866-aa30-bec0334357da" />

*Figure 4. Total barium concentration versus nonfilterable residue with a linear regression trend line.*

### Interpretation

Both scatterplots show strong positive associations: higher barium concentrations generally correspond to higher turbidity and nonfilterable residue in the paired observations. The relationships remained strong after excluding the highest barium observation of 259 µg/L.

The regression lines provide a visual summary of the linear trends, while Spearman's rank correlation quantifies the strength of the monotonic relationships. These associations do not establish causation or independently confirm the validity of individual measurements.

## Key Takeaways

The analysis identified potential anomalies for further investigation and strong positive associations between total barium, turbidity, and nonfilterable residue at the selected monitoring site. The project demonstrates practical skills in relational data management, SQL-based QA checks, validation-status review, exploratory statistics, and data visualization.

## Limitations

The barium investigation focuses on one monitoring site and uses observational data. Correlation does not establish causation, and provisional records should not automatically be considered invalid. Results are descriptive and do not independently establish regulatory exceedances or environmental impacts.

## Data Source

Environment and Climate Change Canada. *Fraser River Long-term Water Quality Monitoring Data.*

https://open.canada.ca/data/en/dataset/1e0e8033-3113-4297-a813-13ec6f
