
# Support Vector Machine (SVM) Model
# Predicting TFA Offer Confirmation


# Install and load required packages
if (!require("readxl")) install.packages("readxl", repos="http://cran.us.r-project.org")
if (!require("caret")) install.packages("caret", repos="http://cran.us.r-project.org")
if (!require("kernlab")) install.packages("kernlab", repos="http://cran.us.r-project.org")

library(readxl)
library(caret)
library(kernlab)

set.seed(1947)

cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("SUPPORT VECTOR MACHINE (SVM) MODEL\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# Load data
cat("Loading data...\n")
data <- read_excel("../418715.xlsx", sheet="Data for HBS-TFA Case - 2018-02")

# Data preprocessing
cat("Preprocessing data...\n")

# Select relevant features and target
model_data <- data.frame(
  GPA = data$`Cumulative GPA`,
  IsStemMajor = data$`Is Math, Sci, or Eng Major Minor`,
  Essay1Length = data$`Essay 1 Length`,
  Essay2Length = data$`Essay 2 Length`,
  Essay3Length = data$`Essay 3 Length`,
  EssaysUniqueWords = data$`Essays Unique Words`,
  EssaysSentiment = data$`Essays Sentiment`,
  RegionPrefLevel = data$`Region Preference Level`,
  AttendedEvent = data$`Attended Event`,
  Met = data$Met,
  Invited = data$Invited,
  Responded = data$Responded,
  CompletedAdmissions = data$`Completed Admissions Process`,
  Confirmed = factor(data$`Confirmed TFA Offer`, levels=c(0,1), labels=c("No", "Yes"))
)

# Remove rows with missing values
model_data <- na.omit(model_data)

cat("Data dimensions after preprocessing:", nrow(model_data), "rows,", ncol(model_data), "columns\n")
cat("Target distribution:\n")
print(table(model_data$Confirmed))
cat("\n")

# Split into training and testing sets (80/20)
train_index <- createDataPartition(model_data$Confirmed, p = 0.8, list = FALSE)
train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

cat("Training set size:", nrow(train_data), "\n")
cat("Test set size:", nrow(test_data), "\n\n")

# Train the SVM model with radial kernel
# Using reduced CV folds and limited tuning grid for faster execution
cat("Training SVM model (optimized for speed)...\n")
svm_model <- train(
  Confirmed ~ .,
  data = train_data,
  method = "svmRadial",
  metric = "Accuracy",
  preProcess = c("center", "scale"),
  trControl = trainControl(method = "cv", number = 3),  # Reduced from 5 to 3
  tuneGrid = expand.grid(
    sigma = c(0.01, 0.1),  # Limited sigma values
    C = c(0.5, 1, 2)       # Limited C values
  )
)

cat("\nModel training complete!\n")
cat("Best parameters:\n")
print(svm_model$bestTune)
cat("\n")

# Predict on test data
cat("Making predictions on test set...\n")
predictions <- predict(svm_model, test_data)

# Confusion matrix and performance metrics
cat("\n")
cat(paste(rep("-", 80), collapse=""), "\n")
cat("MODEL PERFORMANCE METRICS\n")
cat(paste(rep("-", 80), collapse=""), "\n")
cm <- confusionMatrix(predictions, test_data$Confirmed, positive="Yes")
print(cm)

# Extract key metrics
accuracy <- cm$overall['Accuracy']
precision <- cm$byClass['Precision']
recall <- cm$byClass['Recall']
f1 <- cm$byClass['F1']

cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("SUMMARY - SVM MODEL RESULTS\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("Accuracy:  ", round(accuracy, 4), "\n")
cat("Precision: ", round(precision, 4), "\n")
cat("Recall:    ", round(recall, 4), "\n")
cat("F1-Score:  ", round(f1, 4), "\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# Save results to file
results <- data.frame(
  Model = "SVM",
  Accuracy = accuracy,
  Precision = precision,
  Recall = recall,
  F1_Score = f1
)
write.csv(results, "results_SVM.csv", row.names=FALSE)
cat("Results saved to results_SVM.csv\n\n")
