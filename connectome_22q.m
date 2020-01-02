clear;

root_path = '/home/cmoreau/projects/def-jacquese/su_cm/';
preproc_path = [root_path '22q_prep_light/'];
path_out = [root_path 'glm/Final_pheno_clean_4June'] ;
model_path = [root_path 'pheno/Pheno_clean_4June_light.csv'];

files_in.networks.cambridge64 = [root_path 'template/template_cambridge_basc_multiscale_sym_scale064.nii.gz'];
files_in.networks.cambridge36 = [root_path 'template/template_cambridge_basc_multiscale_sym_scale036.nii.gz'];

%opt_g.exclude_subject = {'s14725xx46xFCAP1','s14785xx5xFCAP1', 's14871xx1xFCAP1', 's14927xx1xFCAP1', 's14928xx1xFCAP1', 's14880xx1xFCAP1', 's14952xx5xFCAP1'};
opt_g.min_nb_vol = 40; % The minimum number of volumes for an fMRI dataset to be included. This option is useful when scrubbing is used, and the resulting time series may be too short.
opt_g.min_xcorr_func = 0.5; % The minimum xcorr score for an fMRI dataset to be included. This metric is a tool for quality control which assess the quality of non-linear coregistration of functional image_norms in stereotaxic space. Manual inspection of the values during QC is necessary to properly set this threshold.
opt_g.min_xcorr_anat = 0.5; % The minimum xcorr score for an fMRI dataset to be included. This metric is a tool for quality control which assess the quality of non-linear coregistration of the anatomical image_norm in stereotaxic space. Manual inspection of the values during QC is necessary to properly set this threshold.
opt_g.type_files = 'glm_connectome'; % Specify to the grabber to prepare the files for the glm_connectome pipeline
tmp =  niak_grab_fmri_preprocess(preproc_path, opt_g);
files_in.fmri = tmp.fmri;
files_in.model.group = model_path;

opt.fdr = 0.05;
opt.folder_out = path_out; 

%%%%%%%%%%% add your model (same as the one for the subtype) %%%%%%%%%%%%%%

%%%%%%%%%%%%
%% Tests
%%%%%%%%%%%%

%%%% mean con  %%%%%
opt.test.mean_con.group.contrast.g1 = 0; %del
opt.test.mean_con.group.contrast.g2 = 1; %con
opt.test.mean_con.group.contrast.g3 = 0; %dup
opt.test.mean_con.group.contrast.sex = 0;
opt.test.mean_con.group.contrast.FD_scrubbed_norm = 0;
opt.test.mean_con.group.contrast.age_norm = 0;
opt.test.mean_con.group.flag_intercept = false;
opt.test.mean_con.group.normalize_x = false;
opt.test.mean_con.group.normalize_y = false;

%%%% mean del %%%%%
opt.test.mean_del.group.contrast.g1 = 1; %del
opt.test.mean_del.group.contrast.g2 = 0; %con
opt.test.mean_del.group.contrast.g3 = 0; %dup
opt.test.mean_del.group.contrast.sex = 0;
opt.test.mean_del.group.contrast.FD_scrubbed_norm = 0;
opt.test.mean_del.group.contrast.age_norm = 0;
opt.test.mean_del.group.flag_intercept = false;
opt.test.mean_del.group.normalize_x = false;
opt.test.mean_del.group.normalize_y = false;

%%%% mean dup %%%%%
opt.test.mean_dup.group.contrast.g1 = 0; %del
opt.test.mean_dup.group.contrast.g2 = 0; %con
opt.test.mean_dup.group.contrast.g3 = 1; %dup
opt.test.mean_dup.group.contrast.sex = 0;
opt.test.mean_dup.group.contrast.FD_scrubbed_norm = 0;
opt.test.mean_dup.group.contrast.age_norm = 0;
opt.test.mean_dup.group.flag_intercept = false;
opt.test.mean_dup.group.normalize_x = false;
opt.test.mean_dup.group.normalize_y = false;

%%%% del-dup %%%%%
opt.test.del_minus_dup.group.contrast.g1 = 1; %del
opt.test.del_minus_dup.group.flag_intercept = true;
opt.test.del_minus_dup.group.normalize_x = false;
opt.test.del_minus_dup.group.normalize_y = false;
opt.test.del_minus_dup.group.contrast.sex = 0;
opt.test.del_minus_dup.group.contrast.FD_scrubbed_norm = 0;
opt.test.del_minus_dup.group.contrast.age_norm = 0;
opt.test.del_minus_dup.group.select(1).label = 'g2';
opt.test.del_minus_dup.group.select(1).values = 0;

%%%% del-con %%%%%
opt.test.del_minus_con.group.contrast.g1 = 1; %dup
opt.test.del_minus_con.group.flag_intercept = true;
opt.test.del_minus_con.group.normalize_x = false;
opt.test.del_minus_con.group.normalize_y = false;
opt.test.del_minus_con.group.contrast.sex = 0;
opt.test.del_minus_con.group.contrast.FD_scrubbed_norm = 0;
opt.test.del_minus_con.group.contrast.age_norm = 0;
opt.test.del_minus_con.group.select(1).label = 'g3';
opt.test.del_minus_con.group.select(1).values = 0;

%%%% dup-con %%%%%
opt.test.dup_minus_con.group.contrast.g3 = 1; %dup
opt.test.dup_minus_con.group.flag_intercept = true;
opt.test.dup_minus_con.group.normalize_x = false;
opt.test.dup_minus_con.group.normalize_y = false;
opt.test.dup_minus_con.group.contrast.sex = 0;
opt.test.dup_minus_con.group.contrast.FD_scrubbed_norm = 0;
opt.test.dup_minus_con.group.contrast.age_norm = 0;
opt.test.dup_minus_con.group.select(1).label = 'g1';
opt.test.dup_minus_con.group.select(1).values = 0;

opt.flag_test = false;
[pipeline,opt] = niak_pipeline_glm_connectome(files_in,opt);
