# Load necessary library
library(dplyr)

# Load your dataset
data <- read.csv("TPM_Input_File.csv")

# Extract gene names, expression values, and gene lengths from the data set
gene_names <- data[, 2]  # Gene names are in the first column
expression_values <- data[, 3:32]  # Expression values for 30 samples are in columns 2 to 31
gene_lengths <- data[, ncol(data)]  # Gene lengths are in the last column

gene_lengths_kbp <- gene_lengths / 1000
Read_per_kelobase <- sweep(expression_values, 1, gene_lengths_kbp, "/")
Normalization_factor <- colSums(Read_per_kelobase) / 1000000

TPM <- sweep(Read_per_kelobase, 2, Normalization_factor, "/")

# Add gene names as the first column to the TPM data frame
TPM <- cbind(genes = gene_names, TPM)

# Print the resulting data frame with TPM values
print(TPM)

# Save the TPM file
write.csv(TPM,"TPM_File.csv",row.names = FALSE)