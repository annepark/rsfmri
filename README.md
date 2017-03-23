# rsfmri
Scripts related to seed-based resting state functional connectivity analysis

All scripts require the output from [Nipype rsfmri preprocessing script](https://github.com/nipy/nipype/blob/master/examples/rsfmri_vol_surface_preprocessing_nipy.py)


### make_seed_ts_files.py

Called by run_rsfmri_glm.sh script. Grabs the average time series for specified FreeSurfer ROIs from parcellations/aparc/rest_01_avgwf.txt, and writes to seed_ts.txt file.


### run_rsfmri_glm.sh

To see usage: `bash run_rsfmri_glm.sh`

For each subject and ROI, grabs average time series using make_seed_ts_files.py, then runs GLM.

From: Dr. Allyson Mackey


### seed_FC_pipeline.ipynb

Draft of Nipype script that runs a seed-based functional connectivity analysis using FreeSurfer parcellations. Contains steps for creating subject-level beta maps, as well as group-level mixed effects analysis and multiple comparison correction.
