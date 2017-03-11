# Analysis of the Results

This section reports the analysis of the results aiming at answering our three research questions.

## What are the proportions of different types of bugs?

\input{tex_tables/bugProportion}

Table \ref{tab:contingency-table} presents a contingency table and the results of the Pearson's chi-squared tests we performed on each type of bug.
In addition to presenting bug types 1 to 4,  Table \ref{tab:contingency-table} also presents a grouping of bug types:
Types 1 and 2 versus Types 3 and 4.

Types 3 (22.6\% and 54\%) and 4 (31.3\% and 64.9\%) are predominant compared to types 1 (14.3\% and 9.1\%) and 2 (6.8\% and 3.7\%) for the Apache and the Netbeans ecosystems, respectively.
Overall, the proportion of different types of bug is as follows: 6.8\%, 3.7\%, 28.3\%, 61.2\% for types 1, 2, 3 and 4, respectively.
The result of the Pearson's test is below 0.01.
As a reminder, we consider results of Pearson's tests statistically significant at $\alpha \textless0.05$.
Consequently, we reject to null hypothesis $H_{01}$ and conclude that there is a predominance of Types 3 and 4 in all different ecosystems and this observation is not related to a specific ecosystem.
When combined into our first group, Types 1 \& 2 versus Types 3 \& 4, there are significantly more Types 3 and 4 (89.5 \%) than Types 1 and 2 (10.5 \%).

## How complex is each type of bugs?

To answer**RQ$_2$**, we analyze the complexity of each bug in terms of duplication, fixing time, comments, reopening, files impacted, severity, changesets, hunks, and chunks.

Figure \ref{fig:boxplots} presents nine boxplots describing our complexity metric for each type of each ecosystem.
In each sub-figure, the bookplates are organized as follows: (a) Types 1 to 4 bugs for the Apache ecosystem, (b) Types 1 to 4 bugs for the Netbeans ecosystem and (c) Types 1 to 4 bugs for both ecosystems combined.
For all the metrics, except the severity, the median is close to zero, and we can observe many outliers.
Tables \ref{tab:apache-eco}, \ref{tab:netbeans-eco} and \ref{tab:overall-eco} present descriptive statistics about each metric for each type for the Apache ecosystem, the Netbeans ecosystem, and both ecosystems combined, respectively.
The descriptive statistics used are $\mu$:mean, $\sum$:sum, $\hat{x}$:median, $\sigma$:standard deviation and $\%$:percentage.
Also, to the descriptive statistics, these tables show matrices of Mann-Whitney test for each metric and type.
We added the \checkmark~symbol to the Mann-Whitney tests results columns when the value is statistically significant (e.g. $\alpha \textless 0.05$) and \xmark otherwise.

Finally, Table \ref{tab:chi-rq2} presents the Pearson's chi-squared test results for each complexity metric for Types 1 to 4 and our two types combination.
In what follows, we present our findings for each complexity metric.
Complexity metrics are divided into two groups: (a) process and (b) code metrics.
Process metrics refer to metrics that have been extracted from the project tracking system (i.e., fixing time, comments, reopening and severity).
Code metrics are directly computed using the source code used to fix a given bug (i.e., files impacted, changesets required, hunks and chunks).
We acknowledge that these complexity metrics only represent an abstraction of the actual complexity of a given bug as they cannot account for the actual thought process and expertise required to craft a fix.
However, we believe that they are an accurate abstraction. Moreover, they are used in several studies in the field to approximate the complexity of a bug [@Weiß2007; @Saha2014; @Nam2013; @Anvik2006; @Nagappan].

\begin{figure*}
\centering
\includegraphics[page=1, width=0.45\textwidth]{extract/Rplots}
\includegraphics[page=2, width=0.45\textwidth]{extract/Rplots} \\
\includegraphics[page=3, width=0.45\textwidth]{extract/Rplots}
\includegraphics[page=4, width=0.45\textwidth]{extract/Rplots} \\
\includegraphics[page=5, width=0.45\textwidth]{extract/Rplots}
\includegraphics[page=6, width=0.45\textwidth]{extract/Rplots}
\label{fig:boxplots}
\end{figure*}

\begin{figure*}
\centering
\includegraphics[page=7, width=0.45\textwidth]{extract/Rplots}
\includegraphics[page=8, width=0.45\textwidth]{extract/Rplots} \\
\includegraphics[page=9, width=0.45\textwidth]{extract/Rplots}
\caption{Complexity metrics boxplots. From left to right and top to bottom: Duplicate, Fixing time, Comments, Reopening, Files impacted, Severity, Changesets, Hunks and Chunks.
\label{fig:boxplots}}

\end{figure*}

\input{tex_tables/apache-types}
\input{tex_tables/netbeans-types}
\input{tex_tables/overall-types}

### Duplicate
The duplicate metric represents the number of times a bug gets resolved using the  *duplicate* label while referencing one of the  *resolved/fixed* bug of our dataset.
The process metric is useful to approximate the impact of a given bug on the community.
For a bug to be resolved using the  *duplicate*, it means that the bug has been reported before.
The more a bug gets reported by the community, the more people are impacted enough to report it.
Note that, for a bug$\_a$ to be resolved using the  *duplicate* label and referencing bug$\_b$, bug$\_b$ does not have to be resolved itself.
Indeed, bug$\_b$ could be under investigation (i.e.  *unconfirmed*) or being fixed (i.e.  *new* or  *assigned*).
Automatically detecting duplicate bug report is a very active research field [@Sun2011; @Bettenburg2008a; @Nguyen2012; @Jalbert2008; @Tian2012a; @Runeson2007] and a well-known measure for bug impact.

In the Apache ecosystem, the types that are  most likely to get duplicated, ordered by ascending mean duplication rate, are T3 (0.016) $\textless$ T2 (0.022) $\textless$ T1 (0.026) $\textless$ T4 (0.029) and they represent 14.8\%, 8.1\%, 14.5\% and 62.6\% of the total duplications, respectively.
The differences between duplication means by types, however, are only significant in 33.33\% (4/12) of the case.
Indeed, the mean duplication is only significant in the following cases: T1 vs. T3, T3 vs. T4.
For the Apache ecosystem, we can conclude that $T4_{dup}^1 \gg T1_{dup}^2 \gg T3_{dup}^4$.
We use the notation  $x_{m}^r \gg y_{m}^r$ ($x_{m}^r \ll y_{m}^r$) to represent that $x$, along the metric $m$, is significantly greater (lower) than $y$, along the same metric, according to the mann-whitney tests ($\alpha \textless 0.05$).
$r$ represents the rank of $x$ ($y$) according to $m$ from 1 (higher percentage) to 4 (lower percentage).
In the netbeans ecosystem, we have a different order with T2 (0.067) \textless T3 (0.074) \textless T1 (0.086) \textless T4 (0.113) and they represent 0.6\%, 23.3\%, 2.5\% and 73.6\% of the overall duplication, respectively. Also, we have $T4_{dup}^1 \gg T3_{dup}^2$ for the netbeans ecosystem.

Overall, the complexity of bug types in terms of the number of duplicates is as follows:  $T4_{dup}^{1} \gg T1_{dup}^{3} > T3_{dup}^{2} \gg T2_{dup}^{4}$.


### Fixing time
The fixing time metric represents the time it took for the bug report to go from the  *new* state to the  *closed* state.
If the bug report is reopened, then the time it took for the bug to go from the  *assigned* state to the  *closed* state is added to the first time.
A bug report can be reopened several times and all the times are added.
In this section, the time is expressed in days [@Weiss2007; @Zhang2012; @Zhang2013}.

In the Apache ecosystem, the types that take the most time to fix are $T2_{time}^3 \gg T1_{time}^2 \gg T4_{time}^1 \gg T3_{time}^4$

The results for the Apache ecosystem might appear surprising at first sight.
Indeed, the types requiring the fewer fix location to take longer to fix.
However, this is concordant to the finding of Saha  *et al.* on long-lived bugs [@Saha2014] where the authors discovered that bugs that stay open the longest are, in fact, bugs that take the fewest locations to fix.
In the Netbeans ecosystem, however, the order of bug type along the fixing time metric is different: $T4_{time}^1 > T2_{time}^4 \gg T1_{time}^3 > T3_{time}^2$.
This contradicts the finding of Saha  *et al.*, however, they did not study the Netbeans ecosystem in their paper [@Saha2014].
When combined, both ecosystem amounts in the following order $T2_{time}^4 > T4_{time}^1 \gg T1_{time}^3 \gg T3_{time}^2$.

### Comments
The number of comments metric refers to the comments that have been posted by the community on the project tracking system.
This third process metric evaluates the complexity of a given bug in a sense that if it takes more comments (explanation) from the reporter or the assignee to provide a fix, then the bug must be more complex to understand.
The number of comments has been shown to be useful in assessing the complexity of bugs [@Zhang2013; @Zhang2012]. 
It is also used in bug prediction approaches [@DAmbros2010; @Bhattacharya2011].

The analysis of the Mann-Whitney test matrix, in respect of comments, for the Apache ecosystem provides the following results:
$T4_{comment} ^1 \gg T2_{comment}^4 \gg T3_{comment}^2 > T1_{comment}^3$.

In the Netbeans ecosystem, the bug types follows a different result: $T4_{comment}^1 \gg T3_{comment}^2 > T1_{comment}^3 \gg T2_{comment}^4$.

When combining both ecosystems, the results are: $T4_{comment}^1 \gg T2_{comment}^4 > T3_{comment}^2 \gg T1_{comment}^3$.

### Bug Reopening
The bug is reopening metric counts how many times a given bug gets reopened.If a bug report is reopened, it means that the fix was arguably hard to come up with or the report was hard to understand [@Zimmermann2012; @Shihab2010; @Lo2013].
In the Apache and Netbeans ecosystems, we found that the order bug types of the bugs that are reopened is the same: $T4_{reop}^1 > T2_{reop}^4 \gg T3_{reop}^3 \gg T1_{reop}^2$ and $T4_{reop}^1 > T2_{reop}^4 > T3_{reop}^2 > T1_{reop}^3$, respectively.

When combined, however, the order does change: $T4_{reop}^1 > T2_{reop}^4  > T1_{reop}^3 \gg T3_{reop}^2$.

### Severity

The severity metric reports the degree of impact of the report on the software.
Predicting the severity of a given report is an active research field
[@Menzies2008; Guo2010; @Lamkanfi2010; @Tian2012; @ValdiviaGarcia2014; @Havelund2015] and it helps to prioritization of fixes [@Xuan2012].
The severity is a textual value (blocker, critical, major, normal, minor, trivial) and the Mann-Whitney test only accepts numerical input.
Consequently, we had to assign numerical values to each severity.
We chose to assign values from 1 to 6 for trivial, minor, normal, major, critical and blocker severities, respectively.
The bug type ordering according to the severity metrics is: $T4_{sev}^1 \gg T3_{sev}^2 \gg T2_{sev}^4 > T1_{sev}^3$, $T2_{sev}^4 > T1_{sev}^3 \gg T3_{sev}^2 \gg T4_{sev}^1$ and $T4_{sev}^1 \gg T3_{sev}^2 > T1_{sev}^3 > T2_{sev}^4$ for Apache, Netbeans, and both combined, respectively.

### Files impacted
The number of files impacted measures how many files have been modified for the bug report to be closed.
Unsurprisingly, Types 4 and 2 are the ones with the most files impacted.
Indeed, according to their definitions, presented in Figure \ref{fig:bug-taxo}, Types 1 and 3 only need a modification in one location. This metric is, therefore, applicable to bug Types 2 and 4 only.
In Apache, type 4 structures are wider than type 2 ($T4_{files}^1 \gg T2_{files}^2 \gg T3_{files}^3 < = > T1_{files}^4$) while in Netbeans, type 2 are wider ($T2_{files}^3 \gg T4_{files}^1 \gg T3_{files}^2 < = > T1_{files}^4$).

Overall, types 4 impacts more files than types 2 while types 1 and 2 impacts only 1 file ($T4_{files}^1 \gg T2_{files}^3 \gg T3_{files}^2 < = > T1_{files}^4$).

### Changesets
The changeset metrics registers how many changesets (or commits/patch/fix) have been required to close the bug report.
In the project tracking system, changesets to resolve the bug are proposed and analyzed by the community, automated quality insurance tools and the quality insurance team itself.
Each changeset can be either accepted and applied to the source code or dismissed.
The number of changesets (or versions of a given changeset) it takes before an integration can hint us about the complexity of the fix.
In case the bug report gets reopen, and new changesets proposed, the new changesets (after the reopening) are added to the old ones (before the reopening).
For the Apache ecosystem, we found the following: $T4_{changesets}^1 \gg T2_{changesets}^2 \gg T1_{changesets}^4 <=> T3_{changesets}^3$.

In the Netbeans ecosystem, the order stays the same at the exception of Types 1 and 2 that switch position from 3 to 2 and 2 to 3, respectively ($T4_{changesets}^1 \gg T1_{changesets}^3 > T2_{changesets}^4 > T3_{changesets}^2$).

Overall, Type 4 bugs are the most complex bugs in terms of the number of submitted changesets ($T4_{changesets}^1 \gg T2_{changesets}^3 \gg T3_{changesets}^2 \gg T1_{changesets}^4$).

While results have been published on the bug-fix patterns [@Pan2008], smell introduction [@Tufano2015; @Eyolfson2011], to the best of our knowledge, no one interested themselves in how many iterations of a patch was required to close a bug report beside us.

### Hunks
The hunks metric counts the number of consecutive code blocks of modified, added or deleted lines in textual files.
Hunks are used to determine, in each file, how many different places a developer has modified.
This metric is widely used for bug insertion prediction [@Kim2006; @Jung2009; @Rosen2015] and bug-fix comprehension [@Pan2008].
In our ecosystems, there is a relationship between the number of files modified and the hunks.
The number of code blocks modified is likely to rise as to the number of modified files as the hunks metric will be at least 1 per file.
We found that Types 2 and 4 bugs, that requires many files to get fixed, are the ones that have significantly higher scores for the hunks metric; Apache ecosystem: $T4_{hunks}^1 \gg T2_{hunks}^2 \gg T3_{hunks}^3 \gg T1_{hunks}^4$, Netbeans ecosystem: $T4_{hunks}^1 \gg T2_{hunks}^3 \gg T3_{hunks}^2 \gg T1_{hunks}^4$, and overall $T4_{hunks}^1 \gg T2_{hunks}^2 \gg T1_{hunks}^4 \gg T3_{hunks}^3$.

### Churns
The last metrics, churns, counts the number of lines modified.
The churn value for a line change should be at least two as the line has to be deleted first and then added back with the modifications.
Once again, this is a widely used metric in the field [@Kim2006; @Pan2008; @Jung2009; @Rosen2015].
Once again, Types 4 and 2 are the ones with the most churns; Apache ecosystem $T4_{churns}^1 \gg T2_{churns}^2 \gg T1_{churns}^4 > T3_{churns}^3$, Netbeans ecosystem: $T4_{churns}^1 \gg T2_{churns}^3 \gg T3_{churns}^2 \gg T1_{churns}^4$ and overall : $T4_{churns}^1 \gg T2_{churns}^2 \gg T1_{churns}^4 \gg T3_{churns}^3$.

\input{tex_tables/chisq}
\input{tex_tables/combined}

Assuming that the complexity metrics are equal in terms of assessing the complexity of a given bug, we scored each type with a simple system.
We counted how many times each bug type obtained each position in our nine rankings and multiply them by 4 for the first place, 3 for the second, 2 for the third and 1 for the fourth place.
We did the same simple analysis of the rank of each type for each metric, to take into account the frequency of bug types in our calculation, and multiply both values.
The complexity scores we calculated are as follows: 1330, 1750, 2580 and 7120 for bug types 1, 2, 3 and 4, respectively.
According to these complexity scores, types 3 and 4 are more complex than types 1 and 2.
To confirm or infirm the validity of our complexity scores, we ran our experiments again.
This time, we combined types 1 \& 2 and types 3 \& 4 for the two ecosystems.
As shown by Table \ref{tab:combined-one}, our complexity scores are meaningful.
Indeed, Types 3 \& 4 are statistically more complex ($\gg$) than Types 1 \& 2 according to the duplicate, fixing time, comments, files impacted, changesets, hunks and churns complexity metrics.
Also, Types 3 \& 4 get reopen more than types 1 \& 2, in average, but the result of the Mann-Whitney test is not conclusive (i.e. $\alpha>0.05$).
Out of our nine complexity metrics, the only one where Types 1 \& 2 perform  *worst* than Types 3 \& 4 is the severity.

Consequently, we reject to null hypothesis $H_{02}$ and conclude that the complexity of bug is related to its type.
Moreover, Types 3 and 4  bugs are more complex than Types 1 and 2 bugs across the ecosystems we studied.

## Are bug types predictable at opening time?

To answer **RQ$_3$**, we analyze the accuracy of predictors aiming at determining the type of a bug at submit time (i.e. when the bug report is opened). 
Tables \ref{tab:1gram}, \ref{tab:2gram} and \ref{tab:3gram} presents the results obtained while building classifiers for the most complex type of bug.
According to **RQ$_2$**, the most complex type of bug, in terms of duplicate, time to fix, comments, reopening, files changed, severity, changesets, churns, and hunks, is type 4.

To test our null hypothesis $H_{03}$ (Bug types classifiers are not accurate), we built nine different classifiers using three different machine learning techniques: Linear regression, support vector machines and random forest for ten different projects (5 from each ecosystem).
We selected the top 5 projects of each ecosystem with regard to their bug report count (Ambari, Cassandra, Flume, HBase and Hive for Apache; Cnd, Editor, Java, JavaEE and Plateform for Netbeans).
For each machine learning techniques, we built classifiers using the text contained in the bug report and the comment of the first 48 hours as they are likely to provide additional insights on the bug itself. 
We eliminate the stop-words of the text and trim the words to their semantical roots using wordnet.
On the remaining words, we compute the tf/idf metric for groups of 1, 2 and 3 grams.
The tf/idf metric is then fed to the different machine learning techniques in order to build a classifier.
The data is separated into two parts with a 60%-40% ratio.
The 60% part is used for training purposes while the 40% is used for testing purposes.
During the training process we use the ten-folds iteratively and, for each iteration, we change the parameters used by the classifier building process (cost, mtry, etc).
At the end of the iterations, we select the best classifier and exercise it against the second part of 40%.
The results we report in this section are the performances of the nine classifiers trained on 60% of the data and classifying the remaining 40%.
The performances of each classifier are examined in terms of true positive, true negative, false negative and false positive classifications.
True positives and negative numbers refer to the cases where the classifier correctly classify a report.
The false negative represents the number of reports that are classified as non-type 4 while they are and false positive represents the number of reports classified as type 4 while they are not.
These numbers allow us to derive three common metrics: precision, recall and f_1 measure.


\begin{equation}
precision = \frac{TP+FN \cap TP+FP}{TP+FP}
\end{equation}

\begin{equation}
recall = \frac{TP+FN \cap TP+FP}{TP+FN}
\end{equation}

\begin{equation}
f_1 = \frac{2TP}{2TP + FP + FN}
\end{equation}

Finally, the performances of each classifier are compared to the tenth classifier. 
This last classifier is random classifier that will randomly predict the type of a bug.
As we are in a two-classes system (type 4 and non-type 4), 50% of the reports are classified as type 4 by the random classifier.
The performances of the random classifier itself are presented in table \ref{tab:random}.

\input{tex_tables/1gram}

For the first three classifiers (SVM, linear regression and random forest with a 1-gram grouping of stemmed words) the best classifier the random forest one with 77.63% F_1 measure.
It is followed by SVM (77.19%) and, finally, linear regression (76.31%).
Regardless of the technique used to classify the report, there is no significant difference between ecosystems.
Indeed, the p-values obtained with chi-square tests are above 0.05.
A p-value below 0.05 is a marker of statistical significance.
While random forest emerges as the most accurate classifier, the difference between the three classifiers is not significant (p-value = 0.99).

\input{tex_tables/2gram}

For the second three classifiers (SVM, linear regression and random forest with 2-grams grouping of stemmed words) the best classifier is once again random forest with 77.34% F_1 measure.
It is followed by SVM (76.91%) and, finally, linear regression (76.25%).
As for the first three classifiers, the difference between the classifiers and the ecosystems are not significant.
Moreover, the difference in performances between 1 and 2 grams are not significant either.

\input{tex_tables/3gram}

Finally, the last three classifiers (SVM, linear regression and random forest with 3-grams grouping of stemmed words) the best classifier is once again random forest with 77.12% F_1 measure.
It is followed by SVM (76.72%) and, finally, linear regression (75.89%).
Once again, the difference between the classifiers and the ecosystems are not significant.
Neither are the difference in results between 1, 2 and 3 grams.

\input{tex_tables/random}

Each one of our nine classifiers improves upon the random one on all projects and by a large margin ranging from 20.73% to 22.48%.
Hence, we can reject the $H_{03}$ null hypothesis and conclude that bug types classifiers are indeed accurate.


