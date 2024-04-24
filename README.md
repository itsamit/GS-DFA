Protocol for GS-DFA

Genome-Scale Differential Flux Analysis can be employed to identify affected biochemical pathways within human cells or tissues in the context of metabolic diseases.

1. Firstly, normalize the gene expression data. Utilize the provided scripts and input data in the TPM_normalization file to achieve the TPM-normalized gene expression data.

2. Furthermore, the normalized data can be integrated into the HumanGEM model to reconstruct a context-specific model. Install RAVEN 2.4.0 and HumanGEM 1.4.1 from https://github.com/SysBioChalmers. Utilize the scripts and input data provided in the Model_reconstruction file to achieve the context-specific model.

3. Finally, use the context-specific model to perform Flux Sampling, Differential Flux Analysis, and Pathway Enrichment Analysis. Employ the scripts and input data provided in the Analysis file to identify the impacted biochemical pathways within human cells or tissues in the context of metabolic diseases.
