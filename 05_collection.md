
## Data Extraction and Analysis

This subsection describes the data extraction and analysis process that we followed to answer our research questions.

### What are the proportions of different types of bugs? 

To answer **RQ$_1$**, we cloned the 349 *git* repositories belonging to the Apache ecosystem and the 39 *mercurial* repositories belonging to the Netbeans ecosystem.
The raw size of the cloned source code alone, excluding binaries, images, and other non-text file, is 163 GB.
Then, we extracted all the 102,707 closed issues that have been resolved using the *RESOLVED FIXED* tags since this study aims to classify bugs according to their fix locations.
If an issue is closed by other means than *fixing* the source code, then, it falls outside the scope our study.
To assign commits to issues we used the regular expression based approach proposed by Fischer et al. [@Fischer], which  matches the issue ID in the commit note to the commit.
Using this technique, we were able to link almost 40\% (40,493 out of 102,707) of our resolved/fixed issues to 229,153 commits. Note that an issue can be fixed using several commits.

[Wahab: I would remove the paragraph below.... some reviewers may be picky on using Relink and would argue that 40K issues may not be enough.]
[Mathieu: Done]

Using our consolidated dataset, we extracted the files $f_i$ impacted by each commit $c_i$ for each one of our 388 projects. Then, we classified the bugs according to each type, which we formulate as follows: 

- **Type 1:** A bug is tagged T1 if it is fixed by modifying a file $f_i$, and $f_i$ is not involved in any other bug fix.
- **Type 2:** A bug is tagged T2 if it is fixed by modifying by n files, $f_{i..n}$, where n > 1, and the files $f_{i..n}$ are not involved in any other bug fix.
- **Type 3:** A bug is tagged T3 if it is fixed by modifying a file $f_{i}$ and the file $f_{i}$ is involved in fixing other bugs.
- **Type 4:** A bug is tagged T4 if it is fixed by modifying several files $f_{i..n}$ and the files $f_{i..n}$ are involved in any other bug fix.

To answer **RQ$_1$**, we analyze whether any type is predominant in the studied ecosystem, by testing the null hypothesis:

[Wahab: I wonder if we should not change the question to include significance.]
[Mathieu: How so ?]

- $H_{01}$ : The proportion of types does not change significantly across the studied ecosystems.

We test this hypothesis by observing both a "global" (across ecosystem) and a "local" predominance (per ecosystem) of the different types of bugs.
We must observe these two aspects to ensure that the predominance of a particular type of bug is not circumstantial (in few given systems only) but is also not due to some other, unknown factors (in all systems but not in a particular ecosystem).

We answer **RQ$_1$** in two steps.
The first step is to use descriptive statistics; we compute the ratio of each type to the total number of bugs in the dataset.

In the second step, we compare the proportions of the different types of bugs with respect to the ecosystem where the bugs were found.
We build the contingency table with these two qualitative variables (the type and studied ecosystem) and test the null hypothesis **H$_{01}$** to assess whether the proportion of a particular type of bugs is related to a specific ecosystem or not.

We use the Pearson's chi-squared test to reject the null hypothesis $H_{01}$.
Pearson's chi-squared independence test is used to analyze the relationship between two qualitative data, in our study the type bugs and the studied ecosystem.
The results of Pearson's chi-squared independence tests are considered
statistically significant at $\alpha$ = 0.05.
If p-value $\le$ 0.05, we reject the null hypothesis $H_{01}$ and conclude that the proportion of each type is different for each ecosystem.

Overall, the data extraction and manipulation for **RQ$_1$** (i.e., cloning repositories, linking commits to issues and tagging issues by type) took thirteen weeks of processing time on two Linux servers having 1 quadcore 3.10 GHz CPU and 12 GB of RAM each.

### How complex is each type of bugs?

To answer **RQ$_2$**, we went through the 40,493 resolved/fixed issues and the linked 229,153 commits to compute code and process metrics for each of them. These metrics are discussed thoroughly in related work [@Rosen2015b; @Kamei2013; @Shihab2010].

[Wahab: We need a paragraph that discusses why these metrics only.]
[Math: Well, besides cyclomatic complexity of coverage, what would you add ?.]

The process metrics we used in this paper are:

- The time $t$ it took to resolve issue $i$.

The fixing time metric represents the time it took for the bug report to go from the  *new* state to the  *closed* state.
If the bug report is reopened, then the time it took for the bug to go from the  *assigned* state to the  *closed* state is added to the first time.
A bug report can be reopened several times and all the times are added.
In this section, the time is expressed in days [@Weiss2007; @Zhang2012; @Zhang2013].

- The number of issues $dup$ tagged as a duplicate of issue $i$.

The duplicate metric represents the number of times a bug gets resolved using the  *duplicate* label while referencing one of the  *resolved/fixed* bug of our dataset.
The process metric is useful to approximate the impact of a given bug on the community.
For a bug to be resolved using the  *duplicate*, it means that the bug has been reported before.
The more a bug gets reported by the community, the more people are impacted enough to report it.
Note that, for a bug$\_a$ to be resolved using the  *duplicate* label and referencing bug$\_b$, bug$\_b$ does not have to be resolved itself.
Indeed, bug$\_b$ could be under investigation (i.e.  *unconfirmed*) or being fixed (i.e.  *new* or  *assigned*).
Automatically detecting duplicate bug report is a very active research field [@Sun2011; @Bettenburg2008a; @Nguyen2012; @Jalbert2008; @Tian2012a; @Runeson2007] and a well-known measure for bug impact.

- The number of time issue $i$ was reopened $reop$.

The bug is reopening metric counts how many times a given bug gets reopened.If a bug report is reopened, it means that the fix was arguably hard to come up with or the report was hard to understand [@Zimmermann2012; @Shihab2010; @Lo2013].

- The number of comments $comment$ entered by developers regarding issue $i$.

The "number of comments" metric refers to the comments that have been posted by the community on the project tracking system.
This third process metric evaluates the complexity of a given bug in a sense that if it takes more comments (explanation) from the reporter or the assignee to provide a fix, then the bug must be more complex to understand.
The number of comments has been shown to be useful in assessing the complexity of bugs [@Zhang2013; @Zhang2012]. 
It is also used in bug prediction approaches [@DAmbros2010; @Bhattacharya2011].

- The severity $sev$ of the issue $i$.

The severity metric reports the degree of impact of the report on the software.
Predicting the severity of a given report is an active research field
[@Menzies2008; Guo2010; @Lamkanfi2010; @Tian2012; @ValdiviaGarcia2014; @Havelund2015] and it helps to prioritization of fixes [@Xuan2012].
The severity is a textual value (blocker, critical, major, normal, minor, trivial) and the Mann-Whitney test only accepts numerical input.
Consequently, we had to assign numerical values to each severity.
We chose to assign values from 1 to 6 for trivial, minor, normal, major, critical and blocker severities, respectively.

The code metrics we used are:

- The number of files $f$ impacted by issue $i$.

The number of files impacted measures how many files have been modified for the bug report to be closed.

- The number of changeset $c$ required to fix the issue $i$.

The changeset metrics registers how many changesets (or commits/patch/fix) have been required to close the bug report.
In the project tracking system, changesets to resolve the bug are proposed and analyzed by the community, automated quality insurance tools and the quality insurance team itself.
Each changeset can be either accepted and applied to the source code or dismissed.
The number of changesets (or versions of a given changeset) it takes before an integration can hint us about the complexity of the fix.
In case the bug report gets reopen, and new changesets proposed, the new changesets (after the reopening) are added to the old ones (before the reopening).

- The number of hunks $h$ required to fix the issue $i$.

The hunks metric counts the number of consecutive code blocks of modified, added or deleted lines in textual files.
Hunks are used to determine, in each file, how many different places a developer has modified.
This metric is widely used for bug insertion prediction [@Kim2006; @Jung2009; @Rosen2015] and bug-fix comprehension [@Pan2008].
In our ecosystems, there is a relationship between the number of files modified and the hunks.
The number of code blocks modified is likely to rise as to the number of modified files as the hunks metric will be at least 1 per file.

- The number of churns $ch$ required to fix the issue $i$.

The last metrics, churns, counts the number of lines modified.
The churn value for a line change should be at least two as the line has to be deleted first and then added back with the modifications.
Once again, this is a widely used metric in the field [@Kim2006; @Pan2008; @Jung2009; @Rosen2015].

We address the relation between types and the complexity of the bugs using our metrics.


- $H_{02}$:  The complexity of bug types is not significantly different from one type to another one.


To test our hypothesis, we build a contingency table with the qualitative variables (duplicate, fixing time, comments, reopening, severity, files impacted, changeset, hunks and churns)   and the dependent variables for each type (ecosystem). 
[Wahab: What are the qualitative and dependent variables. You should say this before]
[Mathieu: Done]

We use the Pearson's chi-squared test to accept or reject the null hypothesis $H_{02}$.
The results of Pearson's chi-squared independence tests are considered statistically significant at $\alpha$ = 0.05.
If a p-value $\le$ 0.05, we reject the null hypothesis $H_{02}$ and conclude that the complexity of bug is related to its type.


### Are bug types predictable at submission time?  

[Wahab: You should use either submission time or opening time. In fact, these are different. Maybe you should refer to opening time or forget all this together and discuss whether or time we can predict the type of an incoming bug report during triaging?]
[Mathieu: Adjusted]

To answer this question, we used as features the words in the bug description contained in a bug report. We removed he stopwords (i.e. the, or, she, he) and truncated the remaining words to their roots (i.e. writing becomes write, failure becomes fail and so on). We experimented with 1-gram, 2-gram, and 3-gram words weighted using tf-idf. To build the classifier, we examined three machine learning techniques that have shown to yield satisfactory results in related studies: SVM, Random forest and linear regression [@Weiß2007; @Alencar2014; @Nam2013]

[Wahab: We don't need a hypothesis here]
[Mathieu: Deleted]

In addition, we only focused on predicting the bug type that is deemed the most complex type according to **RQ$_2$**.  


