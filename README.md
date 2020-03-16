## Neuropsychiatric mutations delineate functional brain connectivity dimensions contributing to autism and schizophrenia
https://www.biorxiv.org/content/10.1101/862615v1

#### Authors: Moreau Clara, Urchs Sebastian, et cie
clara.moreau@umontreal.ca
sebastian.urchs@mail.mcgill.ca 

#### Last authors: Bearden Carrie, Bellec Pierre, and Jacquemont Sebastien 

### One sentence summary: Neuropsychiatric CNVs across the genome reorganize brain connectivity architecture along dominant patterns contributing to complex idiopathic conditions.

### Abstract
<p align="justify"> 16p11.2 and 22q11.2 Copy Number Variants (CNVs) confer high risk for Autism Spectrum Disorder (ASD), schizophrenia (SZ), and Attention-Deficit-Hyperactivity-Disorder (ADHD), but their impact on functional connectivity (FC) networks remains unclear. </p>
<p align="justify"> We analyzed resting-state functional magnetic resonance imaging data from 101 CNV carriers, 755 individuals with idiopathic ASD, SZ, or ADHD and 1,072 controls. We used CNV FC-signatures to identify major dimensions contributing to complex idiopathic conditions. CNVs had large mirror effects on FC at the global and regional level, and their effect-sizes were twice as large as those of idiopathic conditions. Thalamus, somatomotor, and posterior insula regions played a critical role in dysconnectivity shared across deletions, duplications, idiopathic ASD, SZ but not ADHD. Individuals with higher similarity to deletion FC-signatures exhibited worse behavioral and cognitive symptoms. </p>
<p align="justify"> These seemingly distinct neuropsychiatric mutations showed similar gene co-expression patterns and converged on FC dimensions, that may represent mechanistic building blocks shared across idiopathic conditions.</p>

### Notebooks and scripts

#### Aim 1 Characterize the impact of gene dosage on connectivity for CNVs at eight genomic loci

Connectome Wide Association Study: Linear model contrasting CNV carriers with controls, adjusting models for mean connectivity </p>
##### Scripts
to_preprocess_restingstate_fMRI_data.m </p>
to_generate_connectomes.m </p>

#### Aim 2 Test similarities between whole-brain connectomes of CNVs and idiopathic psychiatric conditions
Pearson correlation between beta maps obtained from each CWAS and individual connectomes of either ASD, SZ, ADHD cases or controls 
##### Scripts
Publication_similarities_analyses.md

to_create_chord_diag.r </p>

### New Manuscript and corresponding scripts 
## The general impact of haploinsufficiency on brain connectivity underlies the pleiotropic effect of neuropsychiatric CNVs
https://github.com/claramoreau9/NeuropsychiatricCNVs_Connectivity
