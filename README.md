# clustcif: Determining Clusters of Cumulative Incidence Functions in Competing Risks Framework




```clustcif``` is an R package that implements a method to determine clusters
of cumulative incidence functions (CIFs) in a competing risks framework.
The method is based on the use of the Aalen-Johansen estimator to
estimate the CIFs, and the use of a distance measure to quantify the
dissimilarity between CIFs. The distance measure used in this package is
the L2 distance, but other distance measures can be easily implemented.

The full methodology of the methodology is published in the following
paper:

> Sestelo, M., Meira-Machado, L., Villanueva, N.M., Roca-Pardinas, J.(2024). 
_Clustering multiple cumulative incidence functions in competing risks framework_. Biometrical Journal https://doi.org/10.1002/bimj.202400025




## Installation


```clustcif``` is available through both [CRAN](https://cran.r-project.org/) and 
in Github [Github repository](https://github.com/sestelo/clustcif/).

Get the released version from CRAN:
```
install.packages("clustcif")
```

Or the development version from GitHub:
```
# install.packages("devtools")
devtools::install_github("sestelo/clustcif")
```



## Sample usage

In the following example, we use ebmt data to showcase the performance
of the clustcif taking into a count of the presence of several competing
risks.

```         
library(mstate) # data from this package

data("ebmt2") # loading data
out <- table(ebmt2$cod) # causes of death

table9 <- c(out[-1], out[1]) # reorder causes of death
names(table9)[7] <- "Censored" # changed name of the last cause of death
(table9 <- data.frame(t(table9)))



# Testing the number of groups
outtest <- survcifcurves(time = ebmt2$time, status = ebmt2$status, 
                         kvector = NULL,  kbin = 50, nboot = 100,
                         algorithm = "kmeans", cluster = TRUE)




summary(outtest)
# Plotting the grouped CIFs (Figure 6)
figure <- autoplot(outtest) +
  ggplot2::theme(legend.position="none") +
  ggplot2::scale_color_manual(values = c("#E7298A","#D95F02", "#1B9E77",
                                         "#1B9E77", "#1B9E77",  "#7570B3" ))
```

## Citation

If you use ```clustcif``` in your research, please cite the following paper:

> Sestelo, M., Meira-Machado, L., Villanueva, N.M., Roca-Pardinas, J.(2024). 
_Clustering multiple cumulative incidence functions in competing risks framework_. Biometrical Journal https://doi.org/10.1002/bimj.202400025

```         
@article{ortega2024explainable,
author = {Sestelo, Meira-Machado, Villanueva and Roca-Pardinas},
doi = {10.1002/bimj.202400025},
issn = {0323-3847},
journal = {Biometrical Journal},
number = {4},
pages = {1-17},
title = {{A method for determining groups in cumulative incidence curves in competing risk data}},
url = {https://doi.org/10.1002/bimj.202400025},
volume = {66},
year = {2024}
}
```
