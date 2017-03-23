# rsfmri
scripts related to seed-based resting state functional connectivity analysis

all scripts require the output from [Nipype rsfmri preprocessing script] (https://github.com/nipy/nipype/blob/master/examples/rsfmri_vol_surface_preprocessing_nipy.py)


### make_seed_ts_files.py

called by run_rsfmri_glm.sh script. Grabs the average time series for specified FreeSurfer ROIs from parcellations/aparc/rest_01_avgwf.txt, and writes to seed_ts.txt file.


### run_rsfmri_glm.sh

to see usage: `bash run_rsfmri_glm.sh`

for each subject and ROI, grabs average time series using make_seed_ts_files.py, then runs GLM.

from: Dr. Allyson Mackey


### seed_FC_pipeline.ipynb

draft of Nipype script that runs a seed-based functional connectivity analysis using FreeSurfer parcellations. Contains steps for creating subject-level beta maps, as well as group-level mixed effects analysis and multiple comparison correction.
