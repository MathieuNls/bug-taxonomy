#!/usr/bin/env Rscript

#File reading and variables declarations
apache.t1 <- read.csv(file="ap_t1.csv",head=TRUE,sep=",")
apache.t2 <- read.csv(file="ap_t2.csv",head=TRUE,sep=",")
apache.t3 <- read.csv(file="ap_t3.csv",head=TRUE,sep=",")
apache.t4 <- read.csv(file="ap_t4.csv",head=TRUE,sep=",")
apache.t1t2 <- rbind(apache.t1, apache.t2)
apache.t1t3 <- rbind(apache.t1, apache.t3)
apache.t1t4 <- rbind(apache.t1, apache.t4)
apache.t3t4 <- rbind(apache.t3, apache.t4)
apache.t2t4 <- rbind(apache.t2, apache.t4)
apache.t2t3 <- rbind(apache.t2, apache.t3)

netbeans.t1 <- read.csv(file="nb_t1.csv",head=TRUE,sep=",")
netbeans.t2 <- read.csv(file="nb_t2.csv",head=TRUE,sep=",")
netbeans.t3 <- read.csv(file="nb_t3.csv",head=TRUE,sep=",")
netbeans.t4 <- read.csv(file="nb_t4.csv",head=TRUE,sep=",")
netbeans.t1t2 <- rbind(netbeans.t1, netbeans.t2)
netbeans.t1t3 <- rbind(netbeans.t1, netbeans.t3)
netbeans.t1t4 <- rbind(netbeans.t1, netbeans.t4)
netbeans.t3t4 <- rbind(netbeans.t3, netbeans.t4)
netbeans.t2t4 <- rbind(netbeans.t2, netbeans.t4)
netbeans.t2t3 <- rbind(netbeans.t2, netbeans.t3)

all.t1 <- read.csv(file="t1.csv",head=TRUE,sep=",")
all.t2 <- read.csv(file="t2.csv",head=TRUE,sep=",")
all.t3 <- read.csv(file="t3.csv",head=TRUE,sep=",")
all.t4 <- read.csv(file="t4.csv",head=TRUE,sep=",")
all.t1t2 <- rbind(all.t1, all.t2)
all.t1t3 <- rbind(all.t1, all.t3)
all.t1t4 <- rbind(all.t1, all.t4)
all.t3t4 <- rbind(all.t3, all.t4)
all.t2t4 <- rbind(all.t2, all.t4)
all.t2t3 <- rbind(all.t2, all.t3)

#Global variable for significance percentage
stats.sig <<- 0
stats.unsig <<- 0

# Given types and type combination, this function returns wilcox tests and the related descriptive Statistics
wilcoxEcosystem <- function(t1, t2, t3, t4, ct1t2, ct1t3, ct1t4, ct3t4, ct2t4, ct2t3, columnName){

  result <- list (
    t1t2 = wilcox.test(t1[[columnName]], t2[[columnName]]),
    t1t3 = wilcox.test(t1[[columnName]], t3[[columnName]]),
    t1t4 = wilcox.test(t1[[columnName]], t4[[columnName]]),
    t2t3 = wilcox.test(t2[[columnName]], t3[[columnName]]),
    t2t4 = wilcox.test(t2[[columnName]], t4[[columnName]]),
    t3t4 = wilcox.test(t3[[columnName]], t4[[columnName]]),
    t1t2vt3t4 = wilcox.test(ct1t2[[columnName]], ct3t4[[columnName]]),
    t1t3vt2t4 = wilcox.test(ct1t3[[columnName]], ct2t4[[columnName]]),
    t1t4vt2t3 = wilcox.test(ct1t4[[columnName]], ct2t3[[columnName]]),
    descriptiveStats = computeDescriptiveStats(t1, t2, t3, t4, ct1t2, ct1t3, ct1t4, ct3t4, ct2t4, ct2t3, columnName)
  )

  return(result)
}

#Generates a boxplot
boxplotEcosystem <- function(columnName){
  box <- boxplot(
    apache.t1[[columnName]],
    apache.t2[[columnName]],
    apache.t3[[columnName]],
    apache.t4[[columnName]],
    netbeans.t1[[columnName]],
    netbeans.t2[[columnName]],
    netbeans.t3[[columnName]],
    netbeans.t4[[columnName]],
    all.t1[[columnName]],
    all.t2[[columnName]],
    all.t3[[columnName]],
    all.t4[[columnName]],
    main=columnName,
    names = c(
      expression('T1'[a]),expression('T2'[a]),expression('T3'[a]),expression('T4'[a]),
      expression('T1'[n]),expression('T2'[n]),expression('T3'[n]),expression('T4'[n]),
      expression(T1),expression(T2),expression(T3),expression(T4)
      ),
  	xlab="Types", ylab=columnName)

  mytable <- box$stats
  colnames(mytable)<-box$names
  rownames(mytable)<-c('min','lower quartile','median','upper quartile','max')
  print(mytable)
}

# The results are intended as statistically significant at α = 0.05.
# W. J. Conover, Practical Nonparametric Statistics, 3rd ed. Wiley, 1998
isStatisticallySignificant <- function(value){
  #print(value)
  if (value < 0.05 || is.nan(value)) {
    stats.sig <<- stats.sig + 1
    return("✓ (< 0.05)")
  } else {
    stats.unsig <<- stats.unsig + 1
    return(paste("✕ (", round(value, digits=2), ")", sep = ""))
  }
}

#Compute descriptive Statistics for a column
computeDescriptiveStatForColumn <- function (table, columnName, total){

  mean <- round(mean(table[[columnName]]), digits = 3)
  sum <- sum(table[[columnName]])
  median <- round(median(table[[columnName]]), digits = 3)
  perc <- round(sum(table[[columnName]]) / total * 100, digits = 1)
  std <- round(sd(table[[columnName]]), digits = 1)
  toString <- paste("μ:", mean, "∑:", sum, "x:", median, "%:", perc, "σX", std, sep = ",")

  result <- list (
    mean = mean,
    sum = sum,
    median = median,
    perc = perc,
    std = std,
    toString = toString
  )
}

# Compute descriptive Stats for each type
computeDescriptiveStats <- function(t1, t2, t3, t4, ct1t2, ct1t3, ct1t4, ct3t4, ct2t4, ct2t3, columnName){

  total <- (sum(t1[[columnName]]) + sum(t2[[columnName]]) + sum(t3[[columnName]]) + sum(t4[[columnName]]))

  result <- list(

    t1 = computeDescriptiveStatForColumn(t1, columnName, total),
    t2 = computeDescriptiveStatForColumn(t2, columnName, total),
    t3 = computeDescriptiveStatForColumn(t3, columnName, total),
    t4 = computeDescriptiveStatForColumn(t4, columnName, total),
    t1t2 = computeDescriptiveStatForColumn(ct1t2, columnName, total),
    t1t3 = computeDescriptiveStatForColumn(ct1t3, columnName, total),
    t1t4 = computeDescriptiveStatForColumn(ct1t4, columnName, total),
    t3t4 = computeDescriptiveStatForColumn(ct3t4, columnName, total),
    t2t4 = computeDescriptiveStatForColumn(ct2t4, columnName, total),
    t2t3 = computeDescriptiveStatForColumn(ct2t3, columnName, total)
  )
}

# compute wilcox tests and chi-square test for each ecosystem
statsTest <- function(columnName){

  boxplotEcosystem(columnName)

  #Apache
  print("APACHE")
  aWilcox <- wilcoxEcosystem(apache.t1, apache.t2, apache.t3, apache.t4, apache.t1t2, apache.t1t3, apache.t1t4, apache.t3t4, apache.t2t4, apache.t2t3, columnName)

  #Netbeans
  print("Netbeans")
  nWilcox <- wilcoxEcosystem(netbeans.t1, netbeans.t2, netbeans.t3, netbeans.t4, netbeans.t1t2, netbeans.t1t3, netbeans.t1t4, netbeans.t3t4, netbeans.t2t4, netbeans.t2t3, columnName)

  #All
  print("All")
  allWilcox <- wilcoxEcosystem(all.t1, all.t2, all.t3, all.t4, all.t1t2, all.t1t3, all.t1t4, all.t3t4, all.t2t4, all.t2t3, columnName)

  freqs = c(
    aWilcox$descriptiveStats$t1$sum,
    aWilcox$descriptiveStats$t2$sum,
    aWilcox$descriptiveStats$t3$sum,
    aWilcox$descriptiveStats$t4$sum,
    nWilcox$descriptiveStats$t1$sum,
    nWilcox$descriptiveStats$t2$sum,
    nWilcox$descriptiveStats$t3$sum,
    nWilcox$descriptiveStats$t4$sum
  )

  freqsCumul = c(
    aWilcox$descriptiveStats$t1t2$sum,
    nWilcox$descriptiveStats$t3t4$sum
  )

  freqsCumulTwo = c(
    aWilcox$descriptiveStats$t1t3$sum,
    nWilcox$descriptiveStats$t2t4$sum
  )

  data.matrix = matrix(freqs, nrow=2)
  dimnames(data.matrix) = list(ecosystem=c("Apache","Netbeans"), types=c("T1","T2","T3", "T4"))

  data.cumul.matrix = matrix(freqsCumul, nrow=1)
  data.cumul.two.matrix = matrix(freqsCumulTwo, nrow=1)

  result <- list(
    aWilcox = aWilcox,
    nWilcox = nWilcox,
    allWilcox = allWilcox,
    sum.matrix =  data.matrix,
    chisq.sum = round(chisq.test(data.matrix)$p.value, digits = 3),
    chisq.cumul.sum = round(chisq.test(data.cumul.matrix)$p.value, digits = 3),
    chisq.cumul.two.sum = round(chisq.test(data.cumul.two.matrix)$p.value, digits = 3)
  )

  return(result)
}

#Builds a string intended to be eval'd
evalDescriptiveMetric <- function(metric, desc, dataset, type){
  return (paste(metric, "$", dataset, "$descriptiveStats$t", type, "$", desc,sep=""))
}

#Builds a string intended to be eval'd
evalQuantitativeMetric <- function(metric, tin, tout, dataset){

  if(tin == tout){
    return("na")
  }else if(tout < tin){
    return(paste("isStatisticallySignificant(", metric, "$", dataset, "$t", tout, "t", tin, "$p.value)",sep=""))
  }else{
    return(paste("isStatisticallySignificant(", metric, "$", dataset, "$t", tin, "t", tout, "$p.value)",sep=""))
  }
}

#  We followed the guidelines in [21] to interpret the effect size values:
#  small for d < 0.33 (positive as well as negative values), medium for 0.33 ≤ d < 0.474 and large for d ≥ 0.474.
# W. J. Conover, Practical Nonparametric Statistics, 3rd ed. Wiley, 1998
effectSizeValue <- function(value){

  if(value < 0.01){
    return("<0.01")
  }else if(value <0.05){
    return("<0.05")
  }else if(value < 0.33){
    return (paste("small (", value, ")", sep = ""))
  }else if(value < 0.474){
    return (paste("medium (", value, ")", sep = ""))
  }else {
    return (paste("large (", value, ")", sep = ""))
  }
}

buildRQOneMatrix <- function(){

  sumApache <-  nrow(apache.t1) + nrow(apache.t2) + nrow(apache.t3) + nrow(apache.t4)

  sumNetbeans <-  nrow(netbeans.t1) + nrow(netbeans.t2) + nrow(netbeans.t3) + nrow(netbeans.t4)

  sumAll <- sumApache + sumNetbeans

  chisqAll <- effectSizeValue(round(
    chisq.test(
      matrix(
      c(
        nrow(apache.t1),
        nrow(apache.t2),
        nrow(apache.t3),
        nrow(apache.t4),
        nrow(netbeans.t1),
        nrow(netbeans.t2),
        nrow(netbeans.t3),
        nrow(netbeans.t4),
        nrow(all.t1),
        nrow(all.t2),
        nrow(all.t3),
        nrow(all.t4)
      ), nrow=3)
    )$p.value,
    digits = 3
  ))

  chisqCombined <- effectSizeValue(round(
    chisq.test(
      matrix(
      c(
        nrow(apache.t1t2),
        nrow(apache.t3t4),
        nrow(netbeans.t1t2),
        nrow(netbeans.t3t4),
        nrow(all.t1t2),
        nrow(all.t3t4)
      ), nrow=3)
    )$p.value,
    digits = 3
  ))

  chisqCombinedTwo <- effectSizeValue(round(
    chisq.test(
      matrix(
      c(
        nrow(apache.t1t3),
        nrow(apache.t2t4),
        nrow(netbeans.t1t3),
        nrow(netbeans.t2t4),
        nrow(all.t1t3),
        nrow(all.t2t4)
      ), nrow=3)
    )$p.value,
    digits = 3
  ))

  rqOneMatrix <- matrix(
    c(
      "Ecosystem", "T1","T2","T3","T4", "chisq",
      # Ends of head line
      "Apache",
      paste(nrow(apache.t1), " (", round(nrow(apache.t1)/sumApache*100, digits=1), "%)"),
      paste(nrow(apache.t2), " (", round(nrow(apache.t2)/sumApache*100, digits=1), "%)"),
      paste(nrow(apache.t3), " (", round(nrow(apache.t3)/sumApache*100, digits=1), "%)"),
      paste(nrow(apache.t4), " (", round(nrow(apache.t4)/sumApache*100, digits=1), "%)"),
      chisqAll,
      # Ends of first line about APache
      # Line about netbeans
      "Netbeans",
      paste(nrow(netbeans.t1), " (", round(nrow(netbeans.t1)/sumNetbeans*100, digits=1), "%)"),
      paste(nrow(netbeans.t2), " (", round(nrow(netbeans.t2)/sumNetbeans*100, digits=1), "%)"),
      paste(nrow(netbeans.t3), " (", round(nrow(netbeans.t3)/sumNetbeans*100, digits=1), "%)"),
      paste(nrow(netbeans.t4), " (", round(nrow(netbeans.t4)/sumNetbeans*100, digits=1), "%)"),
      chisqAll,
      # Ends of first line about netbeans
      # Line about overall
      "Overall",
      paste(nrow(all.t1), " (", round(nrow(all.t1)/sumAll*100, digits=1), "%)"),
      paste(nrow(all.t2), " (", round(nrow(all.t2)/sumAll*100, digits=1), "%)"),
      paste(nrow(all.t3), " (", round(nrow(all.t3)/sumAll*100, digits=1), "%)"),
      paste(nrow(all.t4), " (", round(nrow(all.t4)/sumAll*100, digits=1), "%)"),
      chisqAll,
      # Ends of first line about overall
      # Heads line combining
      "Ecosystem", "T1T2", "", "T3T4", "", "chisq",
      #Combined APache
      "Apache",
      paste(nrow(apache.t1t2), " (", round(nrow(apache.t1t2)/sumApache*100, digits=1), "%)"), "",
      paste(nrow(apache.t3t4), " (", round(nrow(apache.t3t4)/sumApache*100, digits=1), "%)"), "",
      chisqCombined,
      # Ends of first line about APache
      #Combined Netbeans
      "Netbeans",
      paste(nrow(netbeans.t1t2), " (", round(nrow(netbeans.t1t2)/sumNetbeans*100, digits=1), "%)"), "",
      paste(nrow(netbeans.t3t4), " (", round(nrow(netbeans.t3t4)/sumNetbeans*100, digits=1), "%)"), "",
      chisqCombined,
      # Ends of first line about Netbeans
      #Combined All
      "All",
      paste(nrow(all.t1t2), " (", round(nrow(all.t1t2)/sumAll*100, digits=1), "%)"), "",
      paste(nrow(all.t3t4), " (", round(nrow(all.t3t4)/sumAll*100, digits=1), "%)"), "",
      chisqCombined,
      # Ends of first line about All
      # Heads line combining
      "Ecosystem", "T1T3", "", "T2T4", "", "chisq",
      #Combined APache
      "Apache",
      paste(nrow(apache.t1t3), " (", round(nrow(apache.t1t3)/sumApache*100, digits=1), "%)"), "",
      paste(nrow(apache.t2t4), " (", round(nrow(apache.t2t4)/sumApache*100, digits=1), "%)"), "",
      chisqCombinedTwo,
      # Ends of first line about APache
      #Combined Netbeans
      "Netbeans",
      paste(nrow(netbeans.t1t3), " (", round(nrow(netbeans.t1t3)/sumNetbeans*100, digits=1), "%)"), "",
      paste(nrow(netbeans.t2t4), " (", round(nrow(netbeans.t2t4)/sumNetbeans*100, digits=1), "%)"), "",
      chisqCombinedTwo,
      # Ends of first line about Netbeans
      #Combined All
      "All",
      paste(nrow(all.t1t3), " (", round(nrow(all.t1t3)/sumAll*100, digits=1), "%)"), "",
      paste(nrow(all.t2t4), " (", round(nrow(all.t2t4)/sumAll*100, digits=1), "%)"), "",
      chisqCombinedTwo
      # Ends of first line about All
    ),
    nrow=12,
    ncol=6,
    byrow=TRUE
  )

  write.table(rqOneMatrix, file="rqOneMatrix.csv", quote = FALSE, sep = ";", row.names = FALSE,col.names = FALSE)
  print(rqOneMatrix)
}

#Builds the results matrixes
buildRQTwoMatrix <- function(rDup,rTime,rCom,rReop,rFiles,rSeverity, rChange,rHunks,rChurns){


  matrix <- matrix(
    c("Ecosys","Types","Metric","μ", "∑", "x", "σX", "%","T1","T2","T3","T4"),
    nrow=109,
    ncol=12,
    byrow = TRUE
  )

  matrixCombined <- matrix(
    c("Ecosys", "metric", "t1t2", "","","","", "t3t4", "","","","", "wilcox",  #15
      "", "", "μ", "∑", "x", "σX", "%", "μ", "∑", "x", "σX", "%", ""
    ),
    nrow=30,
    ncol=13,
    byrow=TRUE
  )

  matrixCombinedTwo <- matrix(
    c("Ecosys", "metric", "t1t3", "","","","", "t2t4", "","","","", "wilcox",  #15
      "", "", "μ", "∑", "x", "σX", "%", "μ", "∑", "x", "σX", "%", ""
    ),
    nrow=30,
    ncol=13,
    byrow=TRUE
  )

  matrixChisq <- matrix(
    c("Ecosys", "metric", "p-value all", "p-value t1t2 vs t3t4", "p-value t1t3 vs t2t4"),
    nrow=28,
    ncol=5,
    byrow=TRUE
  )

  na <- "n.a"
  types <- 1:4
  combinedType <- c("t1t2", "t2t3")
  datasets <- c("aWilcox", "nWilcox", "allWilcox")
  metrics <- c("rDup","rTime","rCom","rReop","rFiles","rSeverity", "rChange","rHunks","rChurns")
  metricsName <- c("Dup.","Tim.","Com.","Reo.","Fil.","Sev.", "Cha.","Hun.","Chur.")
  currRow <- 1
  currCombinedRow <- 2

  for(dataset in datasets) {

    currMetricName <- 0

    for (metric in metrics) {

      currCombinedRow <- currCombinedRow + 1
      currMetricName <- currMetricName + 1

      # Generate table of chi-square tests for all combination
      matrixChisq[currCombinedRow-1, ] = c(
        dataset,
        metricsName[currMetricName],
        eval(parse(text=paste("effectSizeValue(", metric, "$chisq.sum)", sep = ""))),
        eval(parse(text=paste("effectSizeValue(", metric, "$chisq.cumul.sum)", sep = ""))),
        eval(parse(text=paste("effectSizeValue(", metric, "$chisq.cumul.two.sum)", sep = "")))
      )

      #Generate comparative table for t1t2 v. t3t4
      matrixCombined[currCombinedRow, ] = c(
        dataset,
        metricsName[currMetricName],
        eval(parse(text=evalDescriptiveMetric(metric, "mean", dataset, "1t2"))),
        eval(parse(text=evalDescriptiveMetric(metric, "sum", dataset, "1t2"))),
        eval(parse(text=evalDescriptiveMetric(metric, "median", dataset, "1t2"))),
        eval(parse(text=evalDescriptiveMetric(metric, "std", dataset, "1t2"))),
        eval(parse(text=evalDescriptiveMetric(metric, "perc", dataset, "1t2"))),
        eval(parse(text=evalDescriptiveMetric(metric, "mean", dataset, "3t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "sum", dataset, "3t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "median", dataset, "3t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "std", dataset, "3t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "perc", dataset, "3t4"))),
        eval(parse(text=evalQuantitativeMetric(metric, "1t2v", "3t4", dataset)))
      )

      #Generate comparative table for t1t3 v. t2t4
      matrixCombinedTwo[currCombinedRow, ] = c(
        dataset,
        metricsName[currMetricName],
        eval(parse(text=evalDescriptiveMetric(metric, "mean", dataset, "1t3"))),
        eval(parse(text=evalDescriptiveMetric(metric, "sum", dataset, "1t3"))),
        eval(parse(text=evalDescriptiveMetric(metric, "median", dataset, "1t3"))),
        eval(parse(text=evalDescriptiveMetric(metric, "std", dataset, "1t3"))),
        eval(parse(text=evalDescriptiveMetric(metric, "perc", dataset, "1t3"))),
        eval(parse(text=evalDescriptiveMetric(metric, "mean", dataset, "2t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "sum", dataset, "2t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "median", dataset, "2t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "std", dataset, "2t4"))),
        eval(parse(text=evalDescriptiveMetric(metric, "perc", dataset, "2t4"))),
        eval(parse(text=evalQuantitativeMetric(metric, "1t3v", "2t4", dataset)))
      )

    }

    for(type in types) {

      currMetricName <- 0

      for (metric in metrics) {

          currRow <- currRow + 1
          currMetricName <- currMetricName + 1

          #Generate the comparative table for each type
          matrix[currRow, ] = c(
            dataset,
            paste("T", type, sep=""),
            metricsName[currMetricName],
            eval(parse(text=evalDescriptiveMetric(metric, "mean", dataset, type))),
            eval(parse(text=evalDescriptiveMetric(metric, "sum", dataset, type))),
            eval(parse(text=evalDescriptiveMetric(metric, "median", dataset, type))),
            eval(parse(text=evalDescriptiveMetric(metric, "std", dataset, type))),
            eval(parse(text=evalDescriptiveMetric(metric, "perc", dataset, type))),
            eval(parse(text=evalQuantitativeMetric(metric, type, 1, dataset))),
            eval(parse(text=evalQuantitativeMetric(metric, type, 2, dataset))),
            eval(parse(text=evalQuantitativeMetric(metric, type, 3, dataset))),
            eval(parse(text=evalQuantitativeMetric(metric, type, 4, dataset)))
          )
      }
    }
  }

  #Write the results to csv
  write.table(matrix, file="result.csv", quote = FALSE, sep = ";", row.names = FALSE,col.names = FALSE)

  write.table(matrixCombined, file="resultCombined.csv", quote = FALSE, sep = ";", row.names = FALSE,col.names = FALSE)

  write.table(matrixCombinedTwo, file="resultCombinedTwo.csv", quote = FALSE, sep = ";", row.names = FALSE,col.names = FALSE)

  write.table(matrixChisq, file="resultChisq.csv", quote = FALSE, sep = ";", row.names = FALSE,col.names = FALSE)

  #Print the results to the consol
  print(matrix)
  print(matrixCombined)
  print(matrixCombinedTwo)
  print(matrixChisq)

}

buildRQOneMatrix()


rDup <- statsTest("DUPLICATE_BY")
print("DUPLICATE_BY")
rTime <- statsTest("FIXING_TIME")
print("FIXING_TIME")
rCom <- statsTest("COMMENTS")
print("COMMENTS")
rReop <- statsTest("REOPENNED")
print("REOPENNED")
rFiles <- statsTest("FILES_IMPACTED")
print("FILES_IMPACTED")
rSeverity <- statsTest("SEVERITY")
print("SEVERITY")
rChange <- statsTest("CHANGESET_REQUIRED")
print("CHANGESET_REQUIRED")
rHunks <- statsTest("HUNKS")
print("HUNKS")
rChurns <- statsTest("CHURNS")
print("CHURNS")

buildRQTwoMatrix(rDup,rTime,rCom,rReop,rFiles,rSeverity, rChange,rHunks,rChurns)

print(paste(round(stats.sig/(stats.sig+stats.unsig)*100, digits=2), "% statistically significant (", stats.sig/4, "/", (stats.unsig+stats.sig)/4, ")",sep=""))

#printResult("rDup", rDup)
#printResult("rTime", rTime)
#printResult("rCom", rCom)
#printResult("rReop", rReop)
#printResult("rFiles", rFiles)
#printResult("rChange", rChange)
#printResult("rHunks", rHunks)
#printResult("rChurns", rChurns)
