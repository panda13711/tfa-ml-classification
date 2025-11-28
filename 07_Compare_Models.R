
# Model Comparison Script
# Compare all models and identify the best performer


cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("MODEL COMPARISON AND BEST MODEL SELECTION\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# Read all result files
results_files <- list.files(pattern = "^results_.*\\.csv$")

if (length(results_files) == 0) {
  cat("Error: No result files found!\n")
  quit(status = 1)
}

cat("Found", length(results_files), "model result files\n\n")

# Combine all results
all_results <- data.frame()
for (file in results_files) {
  result <- read.csv(file)
  all_results <- rbind(all_results, result)
}

# Display all results
cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("COMPARISON OF ALL MODELS\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# Sort by F1-Score (descending)
all_results <- all_results[order(-all_results$F1_Score), ]

# Format and display
print(all_results, row.names = FALSE)

cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("BEST MODEL SELECTION\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# Find best model by different metrics
best_accuracy <- all_results[which.max(all_results$Accuracy), ]
best_precision <- all_results[which.max(all_results$Precision), ]
best_recall <- all_results[which.max(all_results$Recall), ]
best_f1 <- all_results[which.max(all_results$F1_Score), ]

cat("Best Accuracy:  ", best_accuracy$Model, " (", round(best_accuracy$Accuracy, 4), ")\n", sep="")
cat("Best Precision: ", best_precision$Model, " (", round(best_precision$Precision, 4), ")\n", sep="")
cat("Best Recall:    ", best_recall$Model, " (", round(best_recall$Recall, 4), ")\n", sep="")
cat("Best F1-Score:  ", best_f1$Model, " (", round(best_f1$F1_Score, 4), ")\n", sep="")

cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("RECOMMENDATION\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("\n")
cat("The BEST overall model is: ", best_f1$Model, "\n", sep="")
cat("\n")
cat("Performance metrics:\n")
cat("  - Accuracy:  ", round(best_f1$Accuracy, 4), "\n", sep="")
cat("  - Precision: ", round(best_f1$Precision, 4), "\n", sep="")
cat("  - Recall:    ", round(best_f1$Recall, 4), "\n", sep="")
cat("  - F1-Score:  ", round(best_f1$F1_Score, 4), "\n", sep="")
cat("\n")
cat("This model provides the best balance between precision and recall,\n")
cat("based on F1-Score, which balances precision and recall.\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# Save final comparison
write.csv(all_results, "FINAL_MODEL_COMPARISON.csv", row.names=FALSE)
cat("Final comparison saved to FINAL_MODEL_COMPARISON.csv\n\n")

# Create a visual comparison
cat("Creating performance visualization...\n")

# Prepare data for plotting
library(ggplot2)
library(tidyr)

plot_data <- all_results %>%
  pivot_longer(cols = c(Accuracy, Precision, Recall, F1_Score),
               names_to = "Metric",
               values_to = "Score")

# Create bar plot
p <- ggplot(plot_data, aes(x = Model, y = Score, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Model Performance Comparison",
       subtitle = "Comparing all models across different metrics",
       y = "Score",
       x = "Model") +
  scale_fill_brewer(palette = "Set2") +
  ylim(0, 1)

ggsave("Model_Comparison_Plot.png", plot = p, width = 10, height = 6, dpi = 300)
cat("Visualization saved to Model_Comparison_Plot.png\n\n")

cat("Analysis complete!\n")
