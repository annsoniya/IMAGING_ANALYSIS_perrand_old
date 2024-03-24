# Intro
- changes made in the significant cell selection -  introduced bonferroni correction of 16 

- create_sig_with_5sets_frms created db with moving average of 5 frames and stored it in 
matrix = SigWith5Frms

- then performed bleaching correction on the dff values 

# Stim details 
categorising teh segments into periodic and random stimulus line output

| Periodic Stimset 4 | Aperiodic Stimset 4 | Periodic Stimset 3 | Aperiodic Stimset 3 |
|--------------------|---------------------|--------------------|---------------------|
| 11                 | 12                  | 3                  | 13                  |
|                    |                     | 4                  | 14                  |
|                    |                     | 5                  | 15                  |
|                    |                     | 6                  | 16                  |
|                    |                     | 7                  |                     |
|                    |                     | 8                  |                     |

# Files & Purpose

| Filename                            | Purpose                                                                                       |
|-------------------------------------|-----------------------------------------------------------------------------------------------|
| cells_after_bleach_crrtn            | The database with all cells after bleaching correction / signal not done in this database.    |
| sig_cell_stimwise_40frms            | The final database after bleaching correction arranged according to stimulus.                 |
-----------------------------------------------------------------------------------------------|
| roi_based.m                         | Code for performing ROI-based analysis.                                                      |
| container_map_for_roi               | Container to store all ROI-based analysis results in one place.                               |
