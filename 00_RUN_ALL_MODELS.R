
# MASTER SCRIPT - Run All Models and Generate Comparison


cat("\n")
cat("================================================================================\n")
cat("         MACHINE LEARNING MODEL COMPARISON - TFA Offer Prediction\n")
cat("================================================================================\n\n")

start_time <- Sys.time()

# List of all model scripts
model_scripts <- c(
  "06_LogisticRegression_model.R",
  "02_DecisionTree_model.R",
  "03_kNN_model.R",
  "01_ANN_model.R",
  "05_RandomForest_model.R",
  "04_SVM_model.R"
)

model_names <- c(
  "Logistic Regression",
  "Decision Tree",
  "k-Nearest Neighbors",
  "Artificial Neural Network",
  "Random Forest",
  "Support Vector Machine"
)

# Run each model
for (i in seq_along(model_scripts)) {
  cat("\n")
  cat(paste(rep("=", 80), collapse=""), "\n")
  cat("Running Model", i, "of", length(model_scripts), ":", model_names[i], "\n")
  cat(paste(rep("=", 80), collapse=""), "\n\n")
  
  model_start <- Sys.time()
  source(model_scripts[i])
  model_end <- Sys.time()
  
  cat("\nModel completed in:", round(difftime(model_end, model_start, units="secs"), 2), "seconds\n")
}

# Run comparison
cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("Generating Final Comparison and Visualization\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

source("07_Compare_Models.R")

end_time <- Sys.time()
total_time <- difftime(end_time, start_time, units="mins")

cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("ALL MODELS COMPLETED SUCCESSFULLY!\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("Total execution time:", round(total_time, 2), "minutes\n")
cat("\nResults saved in:\n")
cat("  - FINAL_MODEL_COMPARISON.csv\n")
cat("  - Model_Comparison_Plot.png\n")
cat("  - FINAL_SUMMARY_REPORT.txt\n")
cat("  - Individual results_*.csv files\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")
