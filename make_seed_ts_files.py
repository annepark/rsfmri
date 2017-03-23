# make_seed_ts_files.py

# Grabs average time series for specified ROIs from rest_01_avgwf.txt file produced by Nipype rsfmri preprocessing script (this file contains the average time series for many FreeSurfer parcellations)

import os
import numpy
import sys
import pandas as pd

subj_id = sys.argv[1]
data_dir = sys.argv[2]
roi_file = sys.argv[3]

subj_dir = os.path.join(data_dir, subj_id, 'resting')
output_dir = 'roi_betas'

roi_list = []

with open(os.path.join(data_dir, roi_file),'r') as roi_f:
    for roi_line in roi_f:
        roi_split = roi_line.split(',')
        roi_list.append((roi_split[0].strip(), roi_split[1].strip()))
    
for roi in roi_list:
    if os.path.exists(os.path.join(subj_dir, output_dir, roi[1])) != True:
        os.makedirs(os.path.join(subj_dir, output_dir, roi[1]))

    with open(os.path.join(subj_dir,'parcellations','aparc','rest_01_summary.stats'),'r') as summary_f:
        for line in summary_f:
            line_list = line.split(' ')
            if '#' in line_list:
                continue
            line_list = [x for x in line_list if x != '']
            if line_list[4] == roi[0]:
                roi_num = line_list[0]
                col_num = int(roi_num)-1
                
    ts_f = os.path.join(subj_dir,'parcellations','aparc','rest_01_avgwf.txt')
    time_series = pd.read_csv(ts_f, delim_whitespace=True, usecols=[col_num], header=None)
    seed_ts_f = os.path.join(subj_dir, output_dir, roi[1],'seed_ts.txt')
    time_series.to_csv(seed_ts_f, sep='\n', index=False, header=False)

