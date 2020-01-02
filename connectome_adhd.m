%% February 2019
%% C Moreau & S. Urchs

clear;

root_path = '/home/cmoreau/projects/def-pbellec/cmoreau/adhd200/PREPROCESS_ALL';

%preproc_path = [root_path '/OUTPUT/'];
preproc_path = 'OUTPUT_PREP_123/';

path_out = [root_path '/Connectome_123/glm'] ;

model_path = [root_path '/PHENO/data_mri_pheno.csv'];


files_in.networks.cambridge64 = '/home/cmoreau/projects/def-pbellec/ATLAS/MIST/Parcellations/MIST_64.nii.gz';

% opt_g.exclude_subject = {'subx1435954','subx1743472', 'subx2136051', 'subx2260910', 'subx2292940', 'subx2297413', 'subx2570769', 'subx2740232', 'subx2741068', 'subx2854839', 'subx2920716', 'subx2983819','subx0010003',
'subx0010013', 'subx0010015', 'subx0010032', 'subx0010077', 'subx0010119', 'subx0015033', 'subx0015038', 'subx0016017', 'subx0016088', 'subx0021014', 'subx0021037', 'subx0021044', 'subx0021046', 'subx0023024', 
'subx0025003','subx3119327','subx3322144', 'subx3560456', 'subx3653737', 'subx3662296', 'subx3679455', 'subx3912996', 'subx6206397', 'subx4104523', 'subx6568351', 'subx8415034', 'subx8463326', 'subx9499804', 'subx9750701'};


opt_g.min_nb_vol = 50; % The minimum number of volumes for an fMRI dataset to be included. This option is useful when scrubbing is used, and the resulting time series may be too short.
opt_g.min_xcorr_func = 0.5; % The minimum xcorr score for an fMRI dataset to be included. This metric is a tool for quality control which assess the quality of non-linear coregistration of functional images in stereotaxic space. Manual inspection of the values during QC is necessary to properly set this threshold.
opt_g.min_xcorr_anat = 0.5; % The minimum xcorr score for an fMRI dataset to be included. This metric is a tool for quality control which assess the quality of non-linear coregistration of the anatomical image in stereotaxic space. Manual inspection of the values during QC is necessary to properly set this threshold.
opt_g.type_files = 'glm_connectome'; % Specify to the grabber to prepare the files for the glm_connectome pipeline
tmp =  niak_grab_fmri_preprocess(preproc_path, opt_g);
files_in.fmri = tmp.fmri;
files_in.model.group = model_path;

opt.fdr = 0.05;
opt.folder_out = path_out; % Where to store the results

%%%%%%%%%%% add your moadhd (same as the one for the subtype) %%%%%%%%%%%%%%

%%%%%%%%%%%%
%% Tests
%%%%%%%%%%%%

%%%% mean con  %%%%%
opt.test.mean_con.group.contrast.adhd = 0; %adhd
opt.test.mean_con.group.contrast.con = 1; %con
opt.test.mean_con.group.contrast.Sex = 0;
opt.test.mean_con.group.contrast.FD_scrubbed = 0;
opt.test.mean_con.group.contrast.Age = 0;
opt.test.mean_con.group.contrast.Site = 0;
opt.test.mean_con.group.flag_intercept = false;
opt.test.mean_con.group.normalize_x = false;
opt.test.mean_con.group.normalize_y = false;


opt.flag_test = false; 
opt.psom.qsub_options = '--mem=8G  --account def-jacquese --time=00-20:00  --ntasks=1 --cpus-per-task=1';

[pipeline,opt] = niak_pipeline_glm_connectome(files_in,opt);