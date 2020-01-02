import sys
sys.path.append('../../')

# Imports
import numpy as np
import pandas as pd
import pathlib as pal
from cnvfc import io as cio

root_p = pal.Path('../../')
pheno_p = root_p / 'data/pheno/Pheno_22q.csv'
connectome_p = root_p / 'data/preprocessed/connectome/22q_connectome/niak/'
connectome_t = 'connectome_{}_cambridge64.mat'
connectome_n = 'mean_con'
out_p = root_p / 'data/preprocessed/connectome/22q_connectome/python/'
if not out_p.is_dir():
    out_p.mkdir()

conn_mask = np.tril(np.ones((64,64))).astype(bool)
pheno = pd.read_csv(pheno_p)
pheno.rename(columns={'Unnamed: 0':'niak_id'}, inplace=True)

for rid, row in pheno.iterrows():
    sub = row.niak_id
    p = connectome_p / connectome_t.format(sub)
    new_name = connectome_t.format(sub).split('.')[0]
    # Check if output already exists
    if not p.is_file():
        print(f'{sub} does not have {p.resolve()}')
    conn_mat = cio.niak_conn2mat(p.resolve(), connectome_n, conn_mask)
    
    np.save((out_p / f'{new_name}.npy').resolve(), conn_mat)
    if rid%50==0:
        print(rid)
