%% GLM Abide July 12 - 2018 Sebastian Urchs - Clara Moreau
clear;

root_path = '/project/6003287/PROJECT/simon_project/';
preproc_path = ['/project/6003287/PREPROCESS/abide_1/niak_gs0_lp1/'];
path_out = [root_path 'glm/abide_glm'] ;
model_path = [root_path 'pheno/abide_big_glm_model.csv'];

files_in.networks.cambridge64 = [root_path 'template/template_cambridge_basc_multiscale_sym_scale064.nii.gz'];
files_in.networks.cambridge36 = [root_path 'template/template_cambridge_basc_multiscale_sym_scale036.nii.gz'];

opt_g.min_nb_vol = 50; % The minimum number of volumes for an fMRI dataset to be included. This option is useful when scrubbing is used, and the resulting time series may be too short.
opt_g.min_xcorr_func = 0.5; % The minimum xcorr score for an fMRI dataset to be included. This metric is a tool for quality control which assess the quality of non-linear coregistration of functional images in stereotaxic space. Manual inspection of the values during QC is necessary to properly set this threshold.
opt_g.min_xcorr_anat = 0.5; % The minimum xcorr score for an fMRI dataset to be included. This metric is a tool for quality control which assess the quality of non-linear coregistration of the anatomical image in stereotaxic space. Manual inspection of the values during QC is necessary to properly set this threshold.
opt_g.type_files = 'glm_connectome'; % Specify to the grabber to prepare the files for the glm_connectome pipeline
tmp =  niak_grab_fmri_preprocess(preproc_path, opt_g);
files_in.fmri = tmp.fmri;
files_in.model.group = model_path;

opt.fdr = 0.05;
opt.folder_out = path_out; % Where to store the results

%%%%%%%%%%%%
%% Tests
%%%%%%%%%%%%

opt.test.asd_con.group.contrast.Autism = 1 ;
opt.test.asd_con.group.contrast.CALTECH = 0;
opt.test.asd_con.group.contrast.CMU = 0;
opt.test.asd_con.group.contrast.KKI = 0; 
opt.test.asd_con.group.contrast.LEUVEN_1 = 0;
opt.test.asd_con.group.contrast.LEUVEN_2 = 0;
opt.test.asd_con.group.contrast.MAX_MUN = 0;
opt.test.asd_con.group.contrast.NYU = 0;
opt.test.asd_con.group.contrast.OHSU = 0;
opt.test.asd_con.group.contrast.OLIN = 0;
opt.test.asd_con.group.contrast.SDSU = 0;
opt.test.asd_con.group.contrast.STANFORD = 0;
opt.test.asd_con.group.contrast.TRINITY = 0;
opt.test.asd_con.group.contrast.UCLA_1 = 0;
opt.test.asd_con.group.contrast.UCLA_2 = 0;
opt.test.asd_con.group.contrast.UM_1 = 0;
opt.test.asd_con.group.contrast.UM_2 = 0;
opt.test.asd_con.group.contrast.USM = 0;
opt.test.asd_con.group.contrast.YALE = 0;
opt.test.asd_con.group.contrast.FD_scrubbed = 0;
opt.test.asd_con.group.flag_intercept = true;
opt.test.asd_con.group.normalize_x = false;
opt.test.asd_con.group.normalize_y = false;


opt.flag_test = false; 
[pipeline,opt] = niak_pipeline_glm_connectome(files_in,opt);

