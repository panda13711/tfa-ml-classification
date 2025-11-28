# TFA Offer Prediction - Machine Learning Model Comparison

A comprehensive machine learning analysis to predict Teach for America (TFA) offer confirmations using multiple classification algorithms.

## Dataset

- **Source**: Teach for America Application Data (418715.xlsx)
- **Records**: 74,839 applicants
- **Features**: 13 predictor variables including GPA, essay metrics, engagement indicators
- **Target**: Confirmed TFA Offer (Binary: Yes/No)
- **Class Distribution**: No=66,131 (88.4%), Yes=8,708 (11.6%)

## Models Implemented

Six classification models were trained and evaluated:

1. **Logistic Regression** - Baseline linear classifier
2. **Decision Tree (C5.0)** - Rule-based classifier  
3. **k-Nearest Neighbors (kNN)** - Instance-based learning ⭐ **BEST MODEL**
4. **Artificial Neural Network (ANN)** - Multi-layer perceptron
5. **Random Forest** - Ensemble of decision trees
6. **Support Vector Machine (SVM)** - Optimized kernel classifier

## Performance Results

| Model | Accuracy | Precision | Recall | F1-Score |
|-------|----------|-----------|--------|----------|
| **kNN** ⭐ | 88.45% | 51.02% | 17.23% | **0.2576** |
| Logistic Regression | 88.98% | 59.58% | 16.26% | 0.2554 |
| Decision Tree | 88.88% | 57.98% | 15.85% | 0.2490 |
| ANN | 88.90% | 59.61% | 14.07% | 0.2277 |
| Random Forest | 88.81% | 57.93% | 13.84% | 0.2235 |
| SVM | 88.83% | 60.18% | 11.72% | 0.1962 |

## Best Model

🏆 **k-Nearest Neighbors (kNN)** with k=21 neighbors

- Highest F1-Score: 0.2576
- Best balance between precision and recall
- Fast prediction time
- No assumptions about data distribution

## Key Features

Important predictors identified across models:
1. GPA (Cumulative GPA) - Most important
2. Invited status - Strong predictor
3. Essays Unique Words - Quality indicator
4. Region Preference Level
5. Attended Event - Engagement indicator
6. Essays Sentiment
7. Essay Lengths
8. Met, Responded - Engagement metrics

## Project Structure

```
R_Models/
├── 00_RUN_ALL_MODELS.R          # Master script to run all models
├── 01_ANN_model.R                # Artificial Neural Network
├── 02_DecisionTree_model.R       # Decision Tree (C5.0)
├── 03_kNN_model.R                # k-Nearest Neighbors ⭐
├── 04_SVM_model.R                # Support Vector Machine
├── 05_RandomForest_model.R       # Random Forest
├── 06_LogisticRegression_model.R # Logistic Regression
├── 07_Compare_Models.R           # Model comparison & visualization
├── FINAL_MODEL_COMPARISON.csv    # Results comparison
├── FINAL_SUMMARY_REPORT.txt      # Detailed analysis report
├── Model_Comparison_Plot.png     # Performance visualization
└── results_*.csv                 # Individual model results
```

## Quick Start

### Run All Models
```r
cd R_Models
Rscript 00_RUN_ALL_MODELS.R
```

### Run Individual Model
```r
# Run best model only
Rscript 03_kNN_model.R

# Or any other model
Rscript 06_LogisticRegression_model.R
```

## Requirements

```r
# Required R packages
install.packages(c(
  "readxl",
  "caret",
  "nnet",
  "C50",
  "class",
  "kernlab",
  "randomForest",
  "ggplot2",
  "tidyr"
))
```

## Methodology

- **Split**: 80/20 train-test split
- **Cross-Validation**: 5-fold CV (3-fold for SVM)
- **Preprocessing**: Feature scaling (center & scale)
- **Evaluation**: Accuracy, Precision, Recall, F1-Score
- **Selection Criteria**: F1-Score (balances precision & recall)

## Key Insights

- All models achieved high accuracy (~88-89%) due to class imbalance
- Low recall (12-17%) indicates difficulty predicting minority class
- kNN achieved best F1-Score with good balance of metrics
- GPA is the most important feature across all models
- Class imbalance (88:12) makes this a challenging prediction task

## Recommendations

### For Deployment
- Use **kNN (k=21)** for best overall performance
- Alternative: Use **SVM** for higher precision (60.18%)
- Alternative: Use **Logistic Regression** for highest accuracy (88.98%)

### For Improvement
1. Handle class imbalance with SMOTE or class weights
2. Feature engineering: interaction terms, polynomial features
3. Ensemble methods: combine multiple models
4. Threshold tuning: adjust decision threshold
5. Collect additional behavioral/engagement data

## Results Files

- `FINAL_MODEL_COMPARISON.csv` - Comparison of all models
- `FINAL_SUMMARY_REPORT.txt` - Detailed analysis and recommendations
- `Model_Comparison_Plot.png` - Visual comparison chart
- `results_*.csv` - Individual model performance metrics

## License

This project analyzes educational data for research purposes.

## Author

Machine Learning Model Comparison Project
Generated: November 27, 2025
