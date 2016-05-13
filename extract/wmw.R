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

stats.sig <<- 0
stats.unsig <<- 0

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

boxplotEcosystem <- function(columnName){
  boxplot(
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
}

# The results are intended as statistically significant at α = 0.05.
# W. J. Conover, Practical Nonparametric Statistics, 3rd ed. Wiley, 1998
isStatisticallySignificant <- function(value){
  #print(value)
  if (value < 0.05 || is.nan(value)) {
    stats.sig <<- stats.sig + 1
    return("✓")
  } else {
    stats.unsig <<- stats.unsig + 1
    return("✕")
  }
}

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

computeDescriptiveStats <- function(t1, t2, t3, t4, ct1t2, ct1t3, ct1t4, ct3t4, ct2t4, ct2t3, columnName){

  total <- (sum(t1[[columnName]]) + sum(t2[[columnName]]) + sum(t3[[columnName]]) + sum(t4[[columnName]]))

  result <- list(

    t1 = computeDescriptiveStatForColumn(t1, columnName, total),
    t2 = computeDescriptiveStatForColumn(t2, columnName, total),
    t3 = computeDescriptiveStatForColumn(t3, columnName, total),
    t4 = computeDescriptiveStatForColumn(t4, columnName, total),
    ct1t2 = computeDescriptiveStatForColumn(ct1t2, columnName, total),
    ct1t3 = computeDescriptiveStatForColumn(ct1t3, columnName, total),
    ct1t4 = computeDescriptiveStatForColumn(ct1t4, columnName, total),
    ct3t4 = computeDescriptiveStatForColumn(ct3t4, columnName, total),
    ct2t4 = computeDescriptiveStatForColumn(ct2t4, columnName, total),
    ct2t3 = computeDescriptiveStatForColumn(ct2t3, columnName, total)
  )
}

statsTest <- function(columnName){

  #Apache
  aWilcox <- wilcoxEcosystem(apache.t1, apache.t2, apache.t3, apache.t4, apache.t1t2, apache.t1t3, apache.t1t4, apache.t3t4, apache.t2t4, apache.t2t3, columnName)

  #Netbeans
  nWilcox <- wilcoxEcosystem(netbeans.t1, netbeans.t2, netbeans.t3, netbeans.t4, netbeans.t1t2, netbeans.t1t3, netbeans.t1t4, netbeans.t3t4, netbeans.t2t4, netbeans.t2t3, columnName)

  #All
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

  data.matrix = matrix(freqs, nrow=2)
  dimnames(data.matrix) = list(ecosystem=c("Apache","Netbeans"), types=c("T1","T2","T3", "T4"))

  result <- list(
    aWilcox = aWilcox,
    nWilcox = nWilcox,
    allWilcox = allWilcox,
    mean.matrix =  data.matrix,
    chisq = round(chisq.test(data.matrix)$p.value, digits = 4)
  )

  return(result)
}

evalDescriptiveMetric <- function(metric, desc, dataset, type){
  return (paste(metric, "$", dataset, "$descriptiveStats$t", type, "$", desc,sep=""))
}

evalQuantitativeMetric <- function(metric, tin, tout, dataset){

  if(tin == tout){
    return("na")
  }else if(tout < tin){
    return(paste("isStatisticallySignificant(", metric, "$", dataset, "$t", tout, "t", tin, "$p.value)",sep=""))
  }else{
    return(paste("isStatisticallySignificant(", metric, "$", dataset, "$t", tin, "t", tout, "$p.value)",sep=""))
  }
}

buildResultMatrix <- function(rDup,rTime,rCom,rReop,rFiles,rSeverity, rChange,rHunks,rChurns){

  matrix <- matrix(
    c("Ecosys","Types","Metric","μ", "∑", "x", "σX", "%","T1","T2","T3","T4"),
    nrow=109,
    ncol=12,
    byrow = TRUE
  )
  na <- "n.a"
  types <- 1:4
  datasets <- c("aWilcox", "nWilcox", "allWilcox")
  metrics <- c("rDup","rTime","rCom","rReop","rFiles","rSeverity", "rChange","rHunks","rChurns")
  metricsName <- c("Dup","Time","Com","Reop","Files","Severity", "Change","Hunks","Churns")
  currRow <- 1

  for(dataset in datasets) {

    for(type in types) {

      currMetricName <- 0

      for (metric in metrics) {

          currRow <- currRow + 1
          currMetricName <- currMetricName + 1

        #  print(eval(parse(text=evalDescriptiveMetric(metric, "mean", dataset, type))))

        #  print(eval(parse(text=evalQuantitativeMetric(metric, type, 2, dataset))))

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





  write.table(matrix, file="result.csv", quote = FALSE, sep = ";", row.names = FALSE,col.names = FALSE)

  print(matrix)
}

printResult <- function(header, result){
  print(header)
  print(result$wilcox.matrix)
  print(result$mean.matrix)
  print(result$chisq)
}

rDup <- statsTest("DUPLICATE_BY")
rTime <- statsTest("FIXING_TIME")
rCom <- statsTest("COMMENTS")
rReop <- statsTest("REOPENNED")
rFiles <- statsTest("FILES_IMPACTED")
rSeverity <- statsTest("FILES_IMPACTED")
rChange <- statsTest("CHANGESET_REQUIRED")
rHunks <- statsTest("HUNKS")
rChurns <- statsTest("CHURNS")

buildResultMatrix(rDup,rTime,rCom,rReop,rFiles,rSeverity, rChange,rHunks,rChurns)

print(paste(round(stats.sig/(stats.sig+stats.unsig)*100, digits=2), "% statistically significant (", stats.sig/4, "/", (stats.unsig+stats.sig)/4, ")",sep=""))

#printResult("rDup", rDup)
#printResult("rTime", rTime)
#printResult("rCom", rCom)
#printResult("rReop", rReop)
#printResult("rFiles", rFiles)
#printResult("rChange", rChange)
#printResult("rHunks", rHunks)
#printResult("rChurns", rChurns)
