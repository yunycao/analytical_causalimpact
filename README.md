# analytical_causalimpact
Samples scripts from econometrics course. Methods cover:
1. Difference-in-Difference
2. Bayesian structural time series model
3. Grainger Causality Test
4. Propensity score matching
5. Chi-squared Automatic Interaction Detection (CHAID)
 
Packages include:
1. `tfcausalimpact`
2. `causalml`
3. `CHAID`
4. `statsmodels`
5. `sklearn`

Additional work that is not covered:
`econML` is another package for causal inference. The package can analyze marginal effect on conversion for each incremental impression. Sample is not covered here but it is used at work. 

When to Use Causal Inference Methods?

Choosing the appropriate causal inference method is critical for accurate analysis. The decision is driven by the data structure, research question, and underlying assumptions.

**Difference-in-Differences (DiD)**
Use DiD when you have a clear treatment and control group with pre- and post-intervention data. This method is suitable for group-level interventions and relies on the parallel trends assumption, meaning both groups would have followed similar trends without the intervention.

Example: Assessing the effect of a new policy on a state by comparing its economic trend to a similar state that did not adopt the policy.

**Bayesian Structural Time Series (BSTS) Model / CausalImpact**
This advanced method is ideal for measuring the impact of an intervention on a single unit. Use it with long time series data for the treated unit and multiple control series. It constructs a sophisticated counterfactual and is a robust alternative when the parallel trends assumption of DiD is too restrictive.

Example: Quantifying the impact of a website redesign on user engagement using data from other unaffected websites as a counterfactual.

**Granger Causality Test**
This method is used for time series analysis to identify predictive relationships. It answers the question: "Do past values of one variable help forecast another?" Use it for exploratory analysis to uncover potential leading indicators in a system.

Example: Determining if past fluctuations in a market index can predict future movements in a specific stock's price.

**Propensity Score Matching (PSM)**
PSM is designed for observational data where you cannot use a randomized controlled trial. It creates comparable treatment and control groups by matching individuals based on their probability of receiving the treatment, thereby controlling for a multitude of confounding variables.

Example: Evaluating the effectiveness of a new job training program by matching participants with non-participants who share similar demographic and professional backgrounds.

**Chi-squared Automatic Interaction Detection (CHAID)**
CHAID is a predictive modeling and segmentation tool, not a method for causal inference. It is used to identify relationships between categorical variables to build a decision tree. Use it for data exploration and creating interpretable models for business segmentation.

Example: A marketing team using customer data to segment an audience into groups that are most likely to respond to a new campaign.
