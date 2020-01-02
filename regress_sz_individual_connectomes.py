import sys
sys.path.append('../../')
import patsy as pat
import numpy as np
import pandas as pd
import pathlib as pal
from sklearn import linear_model as sln

root_p = pal.Path('../../data/')
pheno_p = root_p / 'pheno/Pheno_SZ.csv'
connectome_p = root_p / 'preprocessed/connectome/cobre_connectome/python/'
connectome_t = 'connectome_s{}_cambridge64.npy'
out_p = root_p / 'processed/residual_connectomes/'
if not out_p.is_dir():
    out_p.mkdir()

conn_mask = np.tril(np.ones((64,64))).astype(bool)
pheno = pd.read_csv(pheno_p, sep=';')

available_subject_mask = [True if (connectome_p / connectome_t.format(row.SUB_ID)).resolve().exists() else False 
                          for rid, row in pheno.iterrows()]

available_subjects = [str(i) for i in pheno.loc[available_subject_mask].SUB_ID.values]
pheno = pheno.loc[available_subject_mask]

regressors = ['C(SITE_ID)', 'FD_scrubbed', 'AGE_AT_SCAN', 'SEX']

paths = [(connectome_p / connectome_t.format(row.SUB_ID)).resolve() for rid, row in pheno.iterrows()]

conn_stack = np.array([np.load(p)[conn_mask] for p in paths])
regressors_str = ' + '.join(regressors)

# Control the COBRE connectomes for nuisance covariates
model = pat.dmatrix(regressors_str, data=pheno, return_type='dataframe')
# Run the glm
mod = sln.LinearRegression(fit_intercept=False, normalize=False)
res = mod.fit(model, conn_stack)
# Get the residuals
resid = conn_stack - res.predict(model)

np.save(out_p / 'icc_residual_connectomes_cobre.npy', resid)
# Store the list of subjects used to generate the connectomes
with (out_p / 'icc_subjects_included_in_residual_connectomes_cobre.tsv').open('w') as f:
    f.write('\n'.join(available_subjects))
