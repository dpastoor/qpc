README
=============

This package provides the functions related to performing quantitative predictive checks, including:

* underlying calculations:
  * predictive-p value
  * p-equivalence
* plotting output (histograms)

based on publication [A new equivalence based metric for predictive check to qualify mixed effects models](http://www.ncbi.nlm.nih.gov/pubmed/16353930)

A QPC can be performed on any test statistic, however initial implementation will focus on AUC (area-under-the-curve) and single time-point comparisons.

A high level conceptualization of the overall workflow/api is as such:

1. User passes in simulation data and real data, time points, and partial AUC calculations, and comparisons (eg. p-eq, pp) they are interested in. 

2. user can plot or ask for tabular output of the results

Implimentation revolves around the following functions:

## internal functions
* qpc_db() -  creates the qpc database
* check_timepoints() - provides a check to make sure all individuals have observed values at the specified times. 
* check_aucs() - checks for times at both edges of partial auc calculations (eg pAUC0-10 would check for timepoint 0 and 10). 
* interpolate_value() - given check_timepoints() fails, an interpolated value can be calculated based on some calculation. Initial calculation would be a log-linear interplotation, exp((log(c_(i-1))+log(c_(i+1)))/2) given a time c_(i+1) is available, else interpolate based on some terminal slope. This will be added later, however should be considered in error handling given individuals having missing pAUC portions or time points. 
* c_statistics() - calculate the provided statistics

## API (external functions)
* qpc() - does all calculations and aggregations
* summary() - gives a summarization of all test statistics 
* plot() - creates histogram plots for qpcs
* data()? - returns raw output from internal AUC calculations and summary statistic calculations. Subject to name change





