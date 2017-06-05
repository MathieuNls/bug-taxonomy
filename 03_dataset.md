# Dataset 

In this section, we present our datasets in length.
In this presentation we explore the proportion of each type of bug as well as the complexity of each type.

## Context Selection\label{sec:context-selection}

The context of this study consists of the change history of 388 projects belonging to two software ecosystems, namely, Apache and Netbeans.
Table \ref{table:datasets} reports, for each of them, (i) the number of resolved-fixed reports, (ii) the number of commits, (iii) the overall number of files, and (iv) the number of projects analyzed.

\begin{table}[h]
\begin{center}
\begin{tabular}{@{}c|c|c|c|c@{}}
\textbf{Dataset} & \textbf{R/F BR} & \textbf{CS} & \textbf{Files} & \textbf{Projects} \\ \hline \hline
Netbeans         & 53,258          & 122,632     & 30,595         & 39                \\
Apache           & 49,449          & 106,366     & 38,111         & 349               \\
Total            & 102,707         & 229,153     & 68,809         & 388               \\ \hline \hline

\end{tabular}
\end{center}

\caption{Datasets\label{table:datasets}}
\end{table}


All the analyzed projects are hosted in *Git* or *Mercurial* repositories and have either a *Jira* or a *Bugzilla* issue tracker associated with them.
The Apache ecosystem consists of 349 projects written in various programming languages (C, C++, Java, Python, ...) and uses *Git* with *Jira*.
These projects represent the Apache ecosystem in its entirety. We did not exclude any system from our study.
The complete list can be found online\footnote{https://projects.apache.org/projects.html?name}.
The Netbeans ecosystem consists of 39 projects, mostly written in Java.
Similar to the Apache ecosystem, we selected all the projects belonging to the Netbeans ecosystem.
The Netbeans community uses *Bugzilla* with *Mercurial*.

The choice of these two ecosystems is driven by the motivation to consider projects having (i) different sizes, (ii) different architectures, and (iii) different development bases and processes. 
Apache projects vary significantly in terms of the size of the development team, purpose and technical choices [@Bavota2013]. On the other side, Netbeans has a relatively stable list of core developers and a common vision shared by the 39 related projects [@Wang2011].

Cumulatively, these datasets span from 2001 to 2014. In summary, our consolidated dataset contains 102,707 closed issues, 229,153 changesets, 68,809 files that have been modified to fix the bugs, 462,848 comments, and 388 distinct systems.
We also collected 221 million lines of code modified to fix bugs, identified 3,284 sub-projects, and 17,984 unique contributors to these bug reports and source code version management systems.
The cumulated opening time for all the bugs reaches 10,661 working years (3,891,618 working days). 
The raw size of the cloned source code alone, excluding binaries, images, and other non-text file, is 163 GB.

To assign commits to issues we used the regular expression based approach proposed by Fischer et al. [@Fischer], which  matches the issue ID in the commit note to the commit.
Using this technique, we were able to link almost 40\% (40,493 out of 102,707) of our resolved/fixed issues to 229,153 commits. Note that an issue can be fixed using several commits.

## Dataset Analysis\label{sec:context-selection}

Using our dataset, we extracted the files $f_i$ impacted by each commit $c_i$ for each one of our 388 projects. 
Then, we classified the bugs according to each type, which we formulate as follows: 

- **Type 1:** A bug is tagged T1 if it is fixed by modifying a file $f_i$, and $f_i$ is not involved in any other bug fix.
- **Type 2:** A bug is tagged T2 if it is fixed by modifying by n files, $f_{i..n}$, where n > 1, and the files $f_{i..n}$ are not involved in any other bug fix.
- **Type 3:** A bug is tagged T3 if it is fixed by modifying a file $f_{i}$ and the file $f_{i}$ is involved in fixing other bugs.
- **Type 4:** A bug is tagged T4 if it is fixed by modifying several files $f_{i..n}$ and the files $f_{i..n}$ are involved in any other bug fix.

\input{tex_tables/bugProportion}

Table \ref{tab:contingency-table} presents the contingency table and the results of the Pearson's chi-squared tests we performed on each type of bug.
We can see that the proportion of T4 (61.2\%) largely higher than that of T1 (6.8\%), 2 (3.7\%) and 3 (28.3\%) and that the difference is significant according to the Pearson's chi-squared test. 

Pearson's chi-squared independence test is used to analyze the relationship between two qualitative data, in our study the type bugs and the studied ecosystem. 
The results of Pearson's chi-squared independence tests are considered statistically significant at = 0.05. 
If p-value $\leq$ 0.05, we can conclude that the proportion of each type is significantly different.


we analyze the complexity of each bug in terms of duplication, fixing time, number of comments, number of time a bug is reopened, files impacted, severity, changesets, hunks, and chunks.

Complexity metrics are divided into two groups: (a) process and (b) code metrics.
Process metrics refer to metrics that have been extracted from the project tracking system (i.e., fixing time, comments, reopening and severity).
Code metrics are directly computed using the source code used to fix a given bug (i.e., files impacted, changesets required, hunks and chunks).
We acknowledge that these complexity metrics only represent an abstraction of the actual complexity of a given bug as they cannot account for the actual thought process and expertise required to craft a fix.
However, we believe that they are an accurate abstraction. Moreover, they are used in several studies in the field to approximate the complexity of a bug [@Weiß2007; @Saha2014; @Nam2013; @Anvik2006; @Nagappan].

Tables \ref{tab:apache-eco}, \ref{tab:netbeans-eco} and \ref{tab:overall-eco} present descriptive statistics about each metric for each bug type per ecosystem and for both ecosystems combined.
The descriptive statistics used are $\mu$:mean, $\sum$:sum, $\hat{x}$:median, $\sigma$:standard deviation and $\%$:percentage.
We also show the results of Mann-Whitney test for each metric and type.
We added the \checkmark symbol to the Mann-Whitney tests results columns when the value is statistically significant (e.g. $\alpha \textless 0.05$) and \xmark otherwise.

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

Overall, the complexity of bug types in terms of the number of duplicates is as follows:  $T4_{dup}^{1} \gg T1_{dup}^{3} > T3_{dup}^{2} \gg T2_{dup}^{4}$.

### Fixing time

The fixing time metric represents the time it took for the bug report to go from the  *new* state to the  *closed* state.
If the bug report is reopened, then the time it took for the bug to go from the  *assigned* state to the  *closed* state is added to the first time.
A bug report can be reopened several times and all the times are added.
In this section, the time is expressed in days [@Weiss2007; @Zhang2012; @Zhang2013].

When combined, both ecosystem amounts in the following order $T2_{time}^4 > T4_{time}^1 \gg T1_{time}^3 \gg T3_{time}^2$.
This contradicts the finding of Saha  *et al.*, however, they did not study the Netbeans ecosystem in their paper [@Saha2014].

### Comments

The "number of comments" metric refers to the comments that have been posted by the community on the project tracking system.
This third process metric evaluates the complexity of a given bug in a sense that if it takes more comments (explanation) from the reporter or the assignee to provide a fix, then the bug must be more complex to understand.
The number of comments has been shown to be useful in assessing the complexity of bugs [@Zhang2013; @Zhang2012]. 
It is also used in bug prediction approaches [@DAmbros2010; @Bhattacharya2011].

When combining both ecosystems, the results are: $T4_{comment}^1 \gg T2_{comment}^4 > T3_{comment}^2 \gg T1_{comment}^3$.

### Bug Reopening

The bug is reopening metric counts how many times a given bug gets reopened.If a bug report is reopened, it means that the fix was arguably hard to come up with or the report was hard to understand [@Zimmermann2012; @Shihab2010; @Lo2013].

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

Overall, T4 impacts more files than T2 while T1 and T2 impacts only 1 file ($T4_{files}^1 \gg T2_{files}^3 \gg T3_{files}^2 < = > T1_{files}^4$).

### Changesets

The changeset metrics registers how many changesets (or commits/patch/fix) have been required to close the bug report.
In the project tracking system, changesets to resolve the bug are proposed and analyzed by the community, automated quality insurance tools and the quality insurance team itself.
Each changeset can be either accepted and applied to the source code or dismissed.
The number of changesets (or versions of a given changeset) it takes before an integration can hint us about the complexity of the fix.
In case the bug report gets reopen, and new changesets proposed, the new changesets (after the reopening) are added to the old ones (before the reopening).

Overall, T4 bugs are the most complex bugs in terms of the number of submitted changesets ($T4_{changesets}^1 \gg T2_{changesets}^3 \gg T3_{changesets}^2 \gg T1_{changesets}^4$).

While results have been published on the bug-fix patterns [@Pan2008], smell introduction [@Tufano2015; @Eyolfson2011], to the best of our knowledge, no one interested themselves in how many iterations of a patch was required to close a bug report beside us.

### Hunks

The hunks metric counts the number of consecutive code blocks of modified, added or deleted lines in textual files.
Hunks are used to determine, in each file, how many different places a developer has modified.
This metric is widely used for bug insertion prediction [@Kim2006; @Jung2009; @Rosen2015] and bug-fix comprehension [@Pan2008].
In our ecosystems, there is a relationship between the number of files modified and the hunks.
The number of code blocks modified is likely to rise as to the number of modified files as the hunks metric will be at least 1 per file.

We found that T2 and T4 bugs, that requires many files to get fixed, are the ones that have significantly higher scores for the hunks metric; Apache ecosystem: $T4_{hunks}^1 \gg T2_{hunks}^2 \gg T3_{hunks}^3 \gg T1_{hunks}^4$, Netbeans ecosystem: $T4_{hunks}^1 \gg T2_{hunks}^3 \gg T3_{hunks}^2 \gg T1_{hunks}^4$, and overall $T4_{hunks}^1 \gg T2_{hunks}^2 \gg T1_{hunks}^4 \gg T3_{hunks}^3$.

### Churns

The last metric, churns, counts the number of lines modified.
The churn value for a line change should be at least two as the line has to be deleted first and then added back with the modifications.
Once again, this is a widely used metric in the field [@Kim2006; @Pan2008; @Jung2009; @Rosen2015].

Once again, T4 and T2 are the ones with the most churns; Apache ecosystem $T4_{churns}^1 \gg T2_{churns}^2 \gg T1_{churns}^4 > T3_{churns}^3$, Netbeans ecosystem: $T4_{churns}^1 \gg T2_{churns}^3 \gg T3_{churns}^2 \gg T1_{churns}^4$ and overall : $T4_{churns}^1 \gg T2_{churns}^2 \gg T1_{churns}^4 \gg T3_{churns}^3$.

In order to determine which type is the most complex, we counted how many times each bug type obtained each position in our nine rankings and multiply them by 4 for the first place, 3 for the second, 2 for the third and 1 for the fourth place.

We did the same simple analysis of the rank of each type for each metric, to take into account the frequency of bug types in our calculation, and multiply both values.
The complexity scores we calculated are as follows: 1330, 1750, 2580 and 7120 for T1, T2, T3 and T4 bugs, respectively.

Considering that type 4 bugs are (a) the most common, (b) the most complex and (c) not a type we intuitively know about; we decided to kick start our research into the different type of bugs and their impact by predicting wether an incoming bug report is type 4 or not.

