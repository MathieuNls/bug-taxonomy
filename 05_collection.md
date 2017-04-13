
## Data Extraction and Analysis

This subsection describes the data extraction and analysis process that we followed to answer our research questions.

### What are the proportions of different types of bugs? 

To answer **RQ$_1$**, we cloned the 349 *git* repositories belonging to the Apache ecosystem and the 39 *mercurial* repositories belonging to the Netbeans ecosystem.
The raw size of the cloned source code alone, excluding binaries, images, and other non-text file, is 163 GB.
Then, we extracted all the 102,707 closed issues that have been resolved using the *RESOLVED FIXED* tags since this study aims to classify bugs according to their fix locations.
If an issue is fixed by other means than *fixing* the source code, then, it falls outside the scope our study.
To assign commits to issues we used the regular expression based approach proposed by Fischer et al. [@Fischer], which  matches the issue ID in the commit note to the commit.
Using this technique, we were able to link almost 40\% (40,493 out of 102,707) of our resolved/fixed issues to 229,153 commits. Note that an issue can be fixed using several commits.

[Wahab: I would remove the paragraph below.... some reviewers may be picky on using Relink and would argue that 40K issues may not be enough.]
There exist other techniques that help link commits to issues, like ReLink, an approach proposed by Wu et al.[@Wu2011]. This technique, however, operates under several constraints: (i) matching the committer/authors with issue tracking contributor name/email; (ii) the time interval between the commit and the last comment posted by the same author/contributor on the issue tracker must be less than seven days; and (iii) Vector Space Model (VSM) cosine similarity between the commit note and the last comment referred above or greater than 0.7. We did not use such techniques. We believe that  mining more than forty thousand issues is  significant enough for this study.

Using our generated consolidated dataset, we extracted the files $f_i$ impacted by each commit $c_i$ for each one of our 388 projects. Then, we classified the bugs according to each type, which we formulate as follows:


- **Type 1:** A bug is tagged Type 1 if it is fixed by modifying a file $f_i$, and $f_i$ is not involved in any other bug fix.
- **Type 2:** A bug is tagged Type 2 if it is fixed by modifying by n files, $f_{i..n}$, where n > 1, and the files $f_{i..n}$ are not involved in any other bug fix.
- **Type 3:** A bug is tagged Type 3 if it is fixed by modifying a file $f_{i}$ and the file $f_{i}$ is involved in fixing other bugs.
- **Type 4:** A bug is tagged Type 4 if it is fixed by modifying several files $f_{i..n}$ and the files $f_{i..n}$ are involved in any other bug fix.

To answer **RQ$_1$**, we analyze whether any type is predominant in the studied ecosystem, by testing the null hypothesis:

[Wahab: I wonder if we should not change the question to include significance.]

- $H_{01}$ : The proportion of types does not change significantly across the studied ecosystems.

We test this hypothesis by observing both a ''global'' (across ecosystem) and a ''local'' predominance (per ecosystem) of the different types of bugs.
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

To answer **RQ$_2$**, we went through the 40,493 resolved/fixed issues and the linked 229,153 commits to compute code and process metrics for each of them. These metrics are discussed thoroughly in related work [REF].

[Wahab: We need a paragraph that discusses why these metrics only.]
The process metrics we used in this paper are:

- The time $t$ it took to resolve issue $i$.
- The number of issues $dup$ tagged as a duplicate of issue $i$.
- The number of time issue $i$ was reopened $reop$.
- The number of comments $comment$ entered by developers regarding issue $i$.
- The severity $sev$ of the issue $i$.

The code metrics we used are:

- The number of files $f$ impacted by issue $i$.
- The number of commit $c$ required to fix the issue $i$.
- The number of hunks $h$ required to fix the issue $i$.
- The number of churns $ch$ required to fix the issue $i$.


We address the relation between types and the complexity of the bugs using our metrics.


- $H_{02}$:  The complexity of bug types is not significantly different from one type to another one.


To test our hypothesis, we build a contingency table with the qualitative variables and the dependent variable for each type. [Wahab: What are the qualitative and dependent variables. You should say this before]

We use the Pearson's chi-squared test to accept or reject the null hypothesis $H_{02}$.
The results of Pearson's chi-squared independence tests are considered statistically significant at $\alpha$ = 0.05.
If a p-value $\le$ 0.05, we reject the null hypothesis $H_{02}$ and conclude that the complexity of bug is related to its type.


### Are bug types predictable?  [Wahab: You should use either submission time or opening time. In fact, these are different. Maybe you should refer to opening time or forget all this together and discuss whether or time we can predict the type of an incoming bug report during triaging?]

To answer this question, we used as features the word in the bug description contained in a bug report and the text from the comment posted by the triaging team after opening the bug. This is because it is likely that triager provide additional information about the bug itself before deciding to direct it to a developer. We removed he stopwords (i.e. the, or, she, he) and truncated the remaining words to their roots (i.e. writing becomes write, failure becomes fail and so on). We experimented with 1-gram, 2-gram, and 3-gram words weighted using tf-idf. To build the classifier, we examined three machine learning techniques that have shown to yield satisfactory results in related studies [REF]: SVM, Random forest and linear regression.

[Wahab: We don't need a hypothesis here]
We analyze whether bug types are predictable by testing the null hypothesis:
- $H_{03}$:  Bug types classifiers are not accurate.

In addition, we only focused on predicting  the bug type that is deemed the most complex type according to **RQ$_2$**.  


