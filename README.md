# MScThesis

This GitHub repository contains all R-code for the MSc Thesis in Statistics and Data Science of Lana Broer, completed ..., at Leiden University; supervised by dr. Alessio Crippa (Karolinska Insitutet) and dr. Mirko Signorelli (Leiden University).

The data used in this project is part of the ProBio trial (Karolinska Insititutet, Sweden), an international, multi-center, randomized controlled phase 3 platform trial, which aims to investigate novel treatments for metastatic prostate cancer.

The repository contains 3 folders and ... files:

* **main folder**
* * **data_management**: loads all relevant dataframes and performs initial preparation of the most used dataframes;
* **descriptive_statistics**: general descriptive statistics on the patient population;
* **RQ1_PSA_descriptives**: produces all descriptive statistics (including plots) to answer the first research question, which focuses on exploring the Prostate-Specific Antigen (PSA) trajectories;
* **RQ1_exploration_trajectories**: explores the different types of PSA trajectories for patients in the ProBio trial;
* **RQ2_explanatory_model_JMbayes**: fits a number of joint models to explore the relationship between repeated measurements of PSA and the survival outcome No-Longer Clinical Benefit (NLCB);
* **RQ2_explanatory_model_timedependentCox**: fits a time-dependent Cox model to explore the relationship between PSA and NLCB;
* **RQ2_model_diagnostics**: performs model diagnostics for the survival and longitudinal sub-models, as well as the joint models fitted in the *RQ2_explanatory_model_JMbayes* file.
