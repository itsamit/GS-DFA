
# Merge RNA sequencing data and gene length in a single file
setwd("C:/Users/DELL/Desktop/Tpm_Norm") # Path

Data1 <- read.csv("SRX105932_gene_length_ENSEMBL_Final.csv")
df_without_first_column_D1 <- Data1[, -1]
Data2 <- read.csv("GSE153315_counts_ENSEMBL_Final.csv")
df_without_first_column_D2 <- Data2[, -1]
merged_df <- merge(df_without_first_column_D2, df_without_first_column_D1, by = "Gene_Symbol", all = TRUE)
print(merged_df)
df_cleaned <- na.omit(merged_df)
write.csv(df_cleaned, "TPM_Input_File.csv")
