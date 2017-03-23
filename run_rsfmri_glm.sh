#!/bin/bash

# run_rsfmri_glm.sh

# This script runs a glm for each subject, for multiple ROIs, based on output of Nipype resting state preprocessing script. 

# Usage

if [ $# -eq 0 ]; then
echo "Usage: run_rsfmri_glm.sh <data_dir> <sub_list> <fs_roi_list> <roi_list_abbrev>
      
data_dir = output directory from Nipype resting state preprocessing script
sub_list = text file with each subject ID on a new line
fs_roi_list = text file with each ROI on a new line
              format: Freesurfer label and desired abbreviation (for naming directories), separated by a comma
              e.g. Right-Amygdala,R_amyg
roi_list_abbrev = text file with just the ROI abbreviations, each on a new line; ROIs must be in the same order as fs_roi_list"

exit
fi

data_dir=${1}
sub_list=${2}
fs_roi_list=${3}
roi_list_abbrev=${4}

for subj in `cat ${sub_list}`; do

echo $subj

# extracts average time series from specified ROIs
python /om/user/annepark/projects/EF4/analysis/rsfmri_final/scripts/make_seed_ts_files.py ${subj} ${data_dir} ${fs_roi_list}

for roi in `cat ${roi_list_abbrev}`; do

mkdir -p ${data_dir}/${subj}/resting/roi_betas/${roi}

# runs glm for seed time series, outputs beta map
# submits job to the queue (SLURM)

echo '#!/bin/sh' > rsfmri_glm_cmd.sh

echo "fsl_glm -i ${data_dir}/${subj}/resting/timeseries/target/rest_01_smooth_trans_masked.nii.gz -d ${data_dir}/${subj}/resting/roi_betas/${roi}/seed_ts.txt -o ${data_dir}/${subj}/resting/roi_betas/${roi}/MNI_beta.nii.gz --demean" >> rsfmri_glm_cmd.sh

sbatch rsfmri_glm_cmd.sh

done

done

