# Data

The five source files for this project, as downloaded from Kaggle.

**Source:** Microsoft Azure Predictive Maintenance
https://www.kaggle.com/datasets/arnabbiswas1/microsoft-azure-predictive-maintenance

| File | Rows | Columns | Contents |
|---|---|---|---|
| PdM_machines.csv | 100 | 3 | One row per machine: ID, model, age |
| PdM_telemetry.csv | 876,100 | 6 | Hourly voltage, rotation, pressure, and vibration readings |
| PdM_errors.csv | 3,919 | 3 | Non-breaking errors logged by the machines |
| PdM_maint.csv | 3,286 | 3 | Component replacements |
| PdM_failures.csv | 761 | 3 | Component failures |

All files are comma-separated with a header row. Dates are in the form `2015-01-01 06:00:00`.

The data belongs to its original publisher. It is included here only so the project can be reproduced.
