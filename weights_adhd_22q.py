import sys
sys.path.append('../../')
import numpy as np
import pandas as pd
import pathlib as pal

import cnvfc

root_p = pal.Path('../../data/')
profile_p = root_p / 'processed/fc_profiles/cnv_22q_del_vs_con.tsv'
connectomes_p = root_p / 'processed/residual_connectomes/icc_residual_connectomes_adhd.npy'
out_p = root_p / 'processed/weights/'

conn_mask = np.tril(np.ones((64, 64))).astype(bool)

profile = pd.read_csv(profile_p, sep='\t')
profile_mat = cnvfc.tools.conn2mat(profile.betas.values, conn_mask)

connectomes = np.load(connectomes_p)
n_sub = connectomes.shape[0]
# Cast the vectorized connectomes back to matrices
connectome_mat = np.array([cnvfc.tools.conn2mat(connectomes[i, :], conn_mask)
                           for i in range(connectomes.shape[0])])

w = cnvfc.stats.make_weights(connectome_mat, profile_mat)
np.save(out_p / 'icc_22q_weights_adhd.npy', w)
