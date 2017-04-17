# Results and Analysis

In this section, we present the results of our experiences and interpret them to answer our three research questions.

## What are the proportions of different types of bugs?

\input{tex_tables/bugProportion}

Table \ref{tab:contingency-table} presents the contingency table and the results of the Pearson's chi-squared tests we performed on each type of bug.
In addition to analyzing bug types independently, we also present the result by analyzing T1 and T2 bugs with T3 and T4 bugs. 
This grouping represents the bug we know intuitively about (i.e. T1: one bug, one fault and T2: one bug, many faults) vs. the less intuitive bugs (i.e. T3: many bug, one root fault and T4: many bugs sharing the same root faults).

[Wahab: add a sentence here explaining why this grouping is important]
[Mathieu: Done]

We can see that the proportion of T3 (22.6\% and 54\%) and T4 (31.3\% and 64.9\%) bugs is largely higher than that of T1 (14.3\% and 9.1\%) and 2 (6.8\% and 3.7\%) for both the Apache and the Netbeans ecosystems. Overall, the proportion of different types of bug is as follows: 6.8\%, 3.7\%, 28.3\%, 61.2\% for T1, T2, T3 and T4, respectively. The result of the Pearson's test is below 0.01. Therefore, we reject to null hypothesis $H_{01}$ and conclude that:

[Wahab: you can put the following result in a bordered rectangle]
[Mathieu: Done]

\fbox{%
\parbox{0.9\textwidth}{%
The number of T3 and T4 bugs is considerably higher than the number of T1 and T2 bugs. When combined into  groups, there are significantly more T3 and T4 (89.5 \%) than T1 and T2 (10.5 \%) bugs.}%
}

## How complex is each type of bugs?

To answer **RQ$_2$**, we analyze the complexity of each bug in terms of duplication, fixing time, number of comments, number of time a bug is reopened, files impacted, severity, changesets, hunks, and chunks.

[Wahab Label (A) ... See the next comment to understand this label]
[Wahab: You need to move the following paragraph to Label (A)]
[Mathieu: Done]

Complexity metrics are divided into two groups: (a) process and (b) code metrics.
Process metrics refer to metrics that have been extracted from the project tracking system (i.e., fixing time, comments, reopening and severity).
Code metrics are directly computed using the source code used to fix a given bug (i.e., files impacted, changesets required, hunks and chunks).
We acknowledge that these complexity metrics only represent an abstraction of the actual complexity of a given bug as they cannot account for the actual thought process and expertise required to craft a fix.
However, we believe that they are an accurate abstraction. Moreover, they are used in several studies in the field to approximate the complexity of a bug [@Weiß2007; @Saha2014; @Nam2013; @Anvik2006; @Nagappan].

Figure \ref{fig:boxplots} presents nine boxplots describing the complexity metrics we used in this paper for each type of bug and for each ecosystem.
In each sub-figure, the bookplates are organized as follows: (a) T1 to T4 bugs for the Apache ecosystem, (b) T1 to T4 bugs for the Netbeans ecosystem and (c) T1 to T4 bugs for both ecosystems combined.
Except for the severity metric, the median for all other metrics is close to zero.
Tables \ref{tab:apache-eco}, \ref{tab:netbeans-eco} and \ref{tab:overall-eco} present descriptive statistics about each metric for each bug type per ecosystem and for both ecosystems combined.
The descriptive statistics used are $\mu$:mean, $\sum$:sum, $\hat{x}$:median, $\sigma$:standard deviation and $\%$:percentage.
We also show the results of Mann-Whitney test for each metric and type.
We added the \checkmark symbol to the Mann-Whitney tests results columns when the value is statistically significant (e.g. $\alpha \textless 0.05$) and \xmark otherwise.

Finally, Table \ref{tab:chi-rq2} presents the Pearson's chi-squared test results for each complexity metric for T1 to T4 and for T1 and T2 together, and T3 and T4.
In what follows, we present our findings for each complexity metric.

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

[Wahab: I noticed that you are using T3, T2, etc. Earlier you were using Type 3, etc. I suggest to using T1, T2, T3, T4 from the beginning].
[Mathieu: Done]

In the Apache ecosystem, the types for which the bugs  are  most likely to have duplicates, ordered by ascending mean duplication rate, are T3 (0.016) $\textless$ T2 (0.022) $\textless$ T1 (0.026) $\textless$ T4 (0.029) and they represent 14.8\%, 8.1\%, 14.5\% and 62.6\% of the total duplications, respectively.
The differences between duplication means by types, however, are only significant in 33.33\% (4/12) of the case.
Indeed, the mean duplication is only significant in the following cases: T1 vs. T3, T3 vs. T4.
For the Apache ecosystem, we can conclude that $T4_{dup}^1 \gg T1_{dup}^2 \gg T3_{dup}^4$.
We use the notation  $x_{m}^r \gg y_{m}^r$ ($x_{m}^r \ll y_{m}^r$) to represent that $x$, along the metric $m$, is significantly greater (lower) than $y$, along the same metric, according to the mann-whitney tests ($\alpha \textless 0.05$).
$r$ represents the rank of $x$ ($y$) according to $m$ from 1 (higher percentage) to 4 (lower percentage).
In the netbeans ecosystem, we have a different order with T2 (0.067) \textless T3 (0.074) \textless T1 (0.086) \textless T4 (0.113) and they represent 0.6\%, 23.3\%, 2.5\% and 73.6\% of the overall duplication, respectively. Also, we have $T4_{dup}^1 \gg T3_{dup}^2$ for the netbeans ecosystem.

Overall, the complexity of bug types in terms of the number of duplicates is as follows:  $T4_{dup}^{1} \gg T1_{dup}^{3} > T3_{dup}^{2} \gg T2_{dup}^{4}$.


### Fixing time


In the Apache ecosystem, the types that take the most time to fix are $T2_{time}^3 \gg T1_{time}^2 \gg T4_{time}^1 \gg T3_{time}^4$

The results for the Apache ecosystem might appear surprising at first sight.
Indeed, the types requiring the fewer fix location to take longer to fix.
However, this is concordant to the finding of Saha  *et al.* on long-lived bugs [@Saha2014] where the authors discovered that bugs that stay open the longest are, in fact, bugs that take the fewest locations to fix.
In the Netbeans ecosystem, however, the order of bug type along the fixing time metric is different: $T4_{time}^1 > T2_{time}^4 \gg T1_{time}^3 > T3_{time}^2$.
This contradicts the finding of Saha  *et al.*, however, they did not study the Netbeans ecosystem in their paper [@Saha2014].
When combined, both ecosystem amounts in the following order $T2_{time}^4 > T4_{time}^1 \gg T1_{time}^3 \gg T3_{time}^2$.

### Comments
[Wahab: The definition of these metric can be moved to the place where you introduced them. You have bullet point there that can be extended]
[Mathieu: Done]

The analysis of the Mann-Whitney test matrix, in respect of comments, for the Apache ecosystem provides the following results:
$T4_{comment} ^1 \gg T2_{comment}^4 \gg T3_{comment}^2 > T1_{comment}^3$.

In the Netbeans ecosystem, the bug types follows a different result: $T4_{comment}^1 \gg T3_{comment}^2 > T1_{comment}^3 \gg T2_{comment}^4$.

When combining both ecosystems, the results are: $T4_{comment}^1 \gg T2_{comment}^4 > T3_{comment}^2 \gg T1_{comment}^3$.

### Bug Reopening

In the Apache and Netbeans ecosystems, we found that the order bug types of the bugs that are reopened is the same: $T4_{reop}^1 > T2_{reop}^4 \gg T3_{reop}^3 \gg T1_{reop}^2$ and $T4_{reop}^1 > T2_{reop}^4 > T3_{reop}^2 > T1_{reop}^3$, respectively.

When combined, however, the order does change: $T4_{reop}^1 > T2_{reop}^4  > T1_{reop}^3 \gg T3_{reop}^2$.

### Severity


The bug type ordering according to the severity metrics is: $T4_{sev}^1 \gg T3_{sev}^2 \gg T2_{sev}^4 > T1_{sev}^3$, $T2_{sev}^4 > T1_{sev}^3 \gg T3_{sev}^2 \gg T4_{sev}^1$ and $T4_{sev}^1 \gg T3_{sev}^2 > T1_{sev}^3 > T2_{sev}^4$ for Apache, Netbeans, and both combined, respectively.

### Files impacted
The number of files impacted measures how many files have been modified for the bug report to be closed.
Unsurprisingly, T4 and T2 are the ones with the most files impacted.
Indeed, according to their definitions, presented in Figure \ref{fig:bug-taxo}, T1 and T3 only need a modification in one location. This metric is, therefore, applicable to T2 and T4 bug  only.
In Apache, T4 structures are wider than T2 ($T4_{files}^1 \gg T2_{files}^2 \gg T3_{files}^3 < = > T1_{files}^4$) while in Netbeans, T2 are wider ($T2_{files}^3 \gg T4_{files}^1 \gg T3_{files}^2 < = > T1_{files}^4$).

Overall, T4 impacts more files than T2 while T1 and T2 impacts only 1 file ($T4_{files}^1 \gg T2_{files}^3 \gg T3_{files}^2 < = > T1_{files}^4$).

### Changesets

For the Apache ecosystem, we found the following: $T4_{changesets}^1 \gg T2_{changesets}^2 \gg T1_{changesets}^4 <=> T3_{changesets}^3$.

In the Netbeans ecosystem, the order stays the same at the exception of T1 and T2 that switch position from 3 to 2 and 2 to 3, respectively ($T4_{changesets}^1 \gg T1_{changesets}^3 > T2_{changesets}^4 > T3_{changesets}^2$).

Overall, T4 bugs are the most complex bugs in terms of the number of submitted changesets ($T4_{changesets}^1 \gg T2_{changesets}^3 \gg T3_{changesets}^2 \gg T1_{changesets}^4$).

While results have been published on the bug-fix patterns [@Pan2008], smell introduction [@Tufano2015; @Eyolfson2011], to the best of our knowledge, no one interested themselves in how many iterations of a patch was required to close a bug report beside us.

### Hunks

We found that T2 and T4 bugs, that requires many files to get fixed, are the ones that have significantly higher scores for the hunks metric; Apache ecosystem: $T4_{hunks}^1 \gg T2_{hunks}^2 \gg T3_{hunks}^3 \gg T1_{hunks}^4$, Netbeans ecosystem: $T4_{hunks}^1 \gg T2_{hunks}^3 \gg T3_{hunks}^2 \gg T1_{hunks}^4$, and overall $T4_{hunks}^1 \gg T2_{hunks}^2 \gg T1_{hunks}^4 \gg T3_{hunks}^3$.

### Churns

Once again, T4 and T2 are the ones with the most churns; Apache ecosystem $T4_{churns}^1 \gg T2_{churns}^2 \gg T1_{churns}^4 > T3_{churns}^3$, Netbeans ecosystem: $T4_{churns}^1 \gg T2_{churns}^3 \gg T3_{churns}^2 \gg T1_{churns}^4$ and overall : $T4_{churns}^1 \gg T2_{churns}^2 \gg T1_{churns}^4 \gg T3_{churns}^3$.

\input{tex_tables/chisq}
\input{tex_tables/combined}

Assuming that the complexity metrics have equal weight when assessing the complexity of a given bug, we scored each type with a simple system. [Wahab: I don't understand this last sentence]

We counted how many times each bug type obtained each position in our nine rankings and multiply them by 4 for the first place, 3 for the second, 2 for the third and 1 for the fourth place.


We did the same simple analysis of the rank of each type for each metric, to take into account the frequency of bug types in our calculation, and multiply both values.
The complexity scores we calculated are as follows: 1330, 1750, 2580 and 7120 for T1, T2, T3 and T4 bugs, respectively.
According to these complexity scores, T3 and T4 are more complex than T1 and T2.
To confirm or infirm the validity of our complexity scores, we ran our experiments again.
This time, we combined T1 \& T2 and T3 \& T4 for the two ecosystems.
As shown by Table \ref{tab:combined-one}, our complexity scores are meaningful.
Indeed, T3 \& T4 are statistically more complex ($\gg$) than T1 \& T2 according to the duplicate, fixing time, comments, files impacted, changesets, hunks and churns complexity metrics.
Also, T3 \& T4 get reopen more than T1 \& T2, in average, but the result of the Mann-Whitney test is not conclusive (i.e. $\alpha>0.05$).
Out of our nine complexity metrics, the only one where T1 \& T2 perform *worst* than T3 \& T4 is the severity.

[Wahab: This is good, but expected]

\fbox{%
\parbox{0.9\textwidth}{%
Consequently, we reject to null hypothesis $H_{02}$ and conclude that the complexity of bug is related to its type.
Moreover, T3 and T4 bugs are more complex than T1 and T2 bugs across the ecosystems we studied.}%
}

## Are bug types predictable at opening time?

To answer **RQ$_3$**, we analyze the accuracy of predictors aiming at determining the type of a bug at submission time (i.e. when the bug report is submitted by someone).  
[Wahab: As I mentioned earlier, you need to clarify submit-time, opening-time and use one them only].
[Mathieu: Done]

Tables \ref{tab:1gram}, \ref{tab:2gram} and \ref{tab:3gram} presents the results obtained while building classifiers for the most complex type of bug. According to **RQ$_2$**, the most complex type of bug, in terms of duplicate, time to fix, comments, reopening, files changed, severity, changesets, churns, and hunks, is T4.

[Wahab: I removed the hypothesis]
[Mathieu: I adjusted the text]

To answer our research question, we built nine different classifiers using three different machine learning techniques: Linear regression, support vector machines and random forest for ten different projects (5 from each ecosystem).

We selected the top 5 projects of each ecosystem with regard to their bug report count (Ambari, Cassandra, Flume, HBase and Hive for Apache; Cnd, Editor, Java, JavaEE and Platform for Netbeans).
For each machine learning techniques, we built classifiers using the text contained in the bug report and the comment of the first 48 hours as they are likely to provide additional insights on the bug itself. 
We eliminate the stop-words of the text and trim the words to their semantical roots using wordnet.
We experimented with 1-gram, 2-gram, and 3-gram words, weighted using tf/idf. 

The feature vectors are fed to the different machine learning techniques in order to build a classifier.
The data is separated into two parts with a 60%-40% ratio.
The 60% part is used for training purposes while the 40% is used for testing purposes.
During the training process we use the ten-folds technique iteratively and, for each iteration, we change the parameters used by the classifier building process (cost, mtry, etc).
At the end of the iterations, we select the best classifier and exercise it against the second part of 40%.
The results we report in this section are the performances of the nine classifiers trained on 60% of the data and classifying the remaining 40%.
The performances of each classifier are examined in terms of true positive, true negative, false negative and false positive classifications.
True positives and negative numbers refer to the cases where the classifier correctly classify a report.
The false negative represents the number of reports that are classified as non-T4 while they are and false positive represents the number of reports classified as T4 while they are not.
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

Finally, the performances of each classifier are compared to a tenth classifier. 
This last classifier is a random classifier that randomly predicts the type of a bug.
As we are in a two-classes system (T4 and non-T4), 50% of the reports are classified as T4 by the random classifier.
The performances of the random classifier itself are presented in table \ref{tab:random}.

\input{tex_tables/1gram}

For the first three classifiers (SVM, linear regression and random forest with a 1-gram grouping of stemmed words) the best classifier the random forest one with 77.63% $F_1$ measure.
It is followed by SVM (77.19%) and, finally, linear regression (76.31%).
Regardless of the technique used to classify the report, there is no significant difference between ecosystems.
Indeed, the p-values obtained with chi-square tests are above 0.05 and a p-value below 0.05 is a marker of statistical significance.
While random forest emerges as the most accurate classifier, the difference between the three classifiers is not significant (p-value = 0.99).

\input{tex_tables/2gram}

For the second three classifiers (SVM, linear regression and random forest with 2-grams grouping of stemmed words) the best classifier is once again random forest with 77.34% $F_1$ measure.
It is followed by SVM (76.91%) and, finally, linear regression (76.25%).
As for the first three classifiers, the difference between the classifiers and the ecosystems are not significant.
Moreover, the difference in performances between 1 and 2 grams are not significant either.

\input{tex_tables/3gram}

Finally, the last three classifiers (SVM, linear regression and random forest with 3-grams grouping of stemmed words) the best classifier is once again random forest with 77.12% $F_1$ measure.
It is followed by SVM (76.72%) and, finally, linear regression (75.89%).
Again, the difference between the classifiers and the ecosystems are not significant.
Neither are the difference in results between 1, 2 and 3 grams.

\input{tex_tables/random}

Each one of our nine classifiers improves upon the random one on all projects and by a large margin ranging from 20.73% to 22.48%.

[Wahab: You can say that the conclusion is that....]
[Mathieu: Done]

\fbox{%
\parbox{0.9\textwidth}{%
The conclusion is that bug types classifiers are indeed accurate.}%
}

