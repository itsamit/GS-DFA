
# Converting Gene Symbol to ensembl IDs (RNA Sequencing data)
setwd("C:/Users/DELL/Desktop/Tpm_Norm") # Path

# Import the file
Data1 <- read.csv("GSE153315_counts.csv")

# Import hgu95av2.db
library(hgu95av2.db)

# Converting Gene Symbol to ensembl IDs
keytypes(hgu95av2.db)
ensembl.id <- mapIds(hgu95av2.db, keys= Data1$Gene, column='ENSEMBL', keytype='SYMBOL', multiVals='first') 
ensembl.id <- as.matrix(ensembl.id)
write.csv(ensembl.id, "GSE153315_counts_ENSEMBL.csv")

# Post processing of the file
Data2 <- read.csv("GSE153315_counts_ENSEMBL.csv")
colnames(Data2)[1]='Gene'
merged_df <- merge(Data2, Data1, by = "Gene", all = TRUE)
print(merged_df)
df_cleaned <- na.omit(merged_df)
print(df_cleaned)
df_without_first_column <- df_cleaned[, -1]
print(df_without_first_column)
colnames(df_without_first_column)[1]='Gene_Symbol'
write.csv(df_without_first_column, "GSE153315_counts_ENSEMBL_Final.csv")
