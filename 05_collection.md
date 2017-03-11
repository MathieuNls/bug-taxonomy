
## Data Extraction and Analysis

This subsection describes the data extraction and analysis process that we followed to answer our research questions.

### What are the proportions of different types of bugs? 

To answer **RQ$_1$**, we cloned the 349 *git* repositories belonging to the Apache ecosystem and the 39 *mercurial* repositories belonging to the Netbeans ecosystem.
The raw size of the cloned source code alone, excluding binaries, images, and other non-text file, is 163 GB.
Then, we extracted all the 102,707 closed issues that have been resolved using the *RESOLVED FIXED* tags.
Indeed, this study aims to classify bugs according to their fix locations.
If an issue is fixed by other means than *fixing* the source code, then, it falls outside the scope our study.
To assign commits to issues we used is the regular expression-based approach by Fischer et al. [@Fischer] matching the issue ID in the commit note.
Using this technique, we were able to link almost 40\% (40,493 out of 102,707) of our resolved/fixed issues to 229,153 commits.
An issue can be fixed with several commits.

We choose not to use more complex technics like ReLink, an approach proposed by Wu et al.[@Wu2011], which considers the following constraints: (i) matching the committer/authors with issue tracking contributor name/email; (ii) the time interval between the commit and the last comment posted by the same author/contributor on the issue tracker must be less than seven days; and (iii) Vector Space Model (VSM) cosine similarity between the commit note and the last comment referred above or greater than 0.7 because we believe that mining more than forty thousand issues is enough to be significant.

Using our generated consolidated dataset, we extracted the files $f_i$ impacted by each commit $c_i$ for each one of our 388 projects.
Then, we classify the bugs according to the following:


- **Type 1:** A bug is tagged type 1 if it is fixed by modifying a file $f_i$ and $f_i$ is not involved in any other bug fix.
- **Type 2:** A bug is tagged type 2 if it is fixed by modifying several files $f_{i..n}$ and the files $f_{i..n}$ are not involved in any other bug fix.
- **Type 3:** A bug is tagged type 3 if it is fixed by modifying a file $f_{i}$ and the file $f_{i}$ is involved in fixing other bugs.
- **Type 4:** A bug is tagged type 4 if it is fixed by modifying several files $f_{i..n}$ and the files $f_{i..n}$ are involved in any other bug fix.

To answer this question, we analyze whether any type is predominant in the studied ecosystem, by testing the null hypothesis:

- $H_{01}$ : The proportion of types does not change significantly across the studied ecosystems.

We test this hypothesis by observing both a ''global'' (across ecosystem) and a ''local'' predominance (per ecosystem) of the different types of bugs.
We must observe these two aspects to ensure that the predominance of a particular type of bug is not circumstantial (in few given systems only) but is also not due to some other, unknown factors (in all systems but not in a particular ecosystem).

We answer **RQ$_1$** in two steps.
The first step is to use descriptive statistics; we compute the ratio of each type to the total number of bugs in the dataset.

In the second step, we compare the proportions of the different types of bugs with respect to the ecosystem where the bugs were found.
We build the contingency table with these two qualitative variables (the type and studied ecosystem) and test the null hypothesis **H$_{01A}$** to assess whether the proportion of a particular type of bugs is related to a specific ecosystem or not.

We use the Pearson's chi-squared test to reject the null hypothesis $H_{01A}$.
Pearson's chi-squared independence test is used to analyze the relationship between two qualitative data, in our study the type bugs and the studied ecosystem.
The results of Pearson's chi-squared independence tests are considered
statistically significant at $\alpha$ = 0.05.
If p-value $\le$ 0.05, we reject the null hypothesis $H_{01A}$ and conclude that the proportion of each type is different for each ecosystem.

Overall, the data extraction and manipulation for **RQ$_1$** (i.e., cloning repositories, linking commits to issues and tagging issues by type) took thirteen weeks on two Linux servers having 1 quadcore 3.10 GHz CPU and 12 GB of RAM each.

### How complex is each type of bugs?

To answer **RQ$_2$** we went through the 40,493 resolved/fixed issues and the linked 229,153 commits to compute code and process metrics for each of them.
These metrics will then be used to assess the complexity of a bug.
The computed process metrics are:


- The time $t$ it took to resolve issue $i$.
- The number of issues $dup$ tagged as a duplicate of issue $i$.
- The number of time issue $i$ got reopen $reop$.
- The number of comments $comment$ on issue $i$.
- The severity $sev$ of the issue $i$.

The computed code metrics are:

- The number of files $f$ impacted by issue $i$.
- The number of commit $c$ required to fix the issue $i$.
- The number of hunks $h$ required to fix the issue $i$.
- The number of churns $ch$ required to fix the issue $i$.


We address the relation between types and the complexity of the bugs in using our metrics.
We analyze whether Types 2 and 4 bugs are more complex to handle than Types 1 and 3 bugs, by testing the null hypotheses:


- $H_{02}$:  The complexity of bug types is not significantly different from type to type.


To test our hypothesis, we build a contingency table with the qualitative variables and the dependent variable for each type.

We use the Pearson's chi-squared test to reject the null hypothesis $H_{02}$.
The results of Pearson's chi-squared independence tests are considered statistically significant at $\alpha$ = 0.05.
If a p-value $\le$ 0.05, we reject the null hypothesis $H_{02}$ and conclude that the complexity of bug is related to its type.


### Are bug types predictable at opening time?

This third research question aims at determining the predictability of bug types. In details, we investigate what are the best ways to predict the type of a bug report at submit time. Being able to build accurate classifiers predicting the bug type at submit time will allow the researcher to enhance triaging approaches.
Indeed, combining the results of our second research question with an accurate classifier will, for example, allow triaging approaches to assign more complex bug reports, based on their types, to experienced developers within the organization. 
To answer this question, we used the text contained in the bug report, and the text from the comment posted the first 48 hours after the report's opening as they are likely to give some additional information about the bug itself.
Then, we removed all the stopwords (i.e. the, or, she, he) and truncated the remaining words to their roots (i.e. writing becomes write, failure becomes fail and so on).
Finally, we apply the compute tfidf on the transformed text and create three different datasets using the n-grams technique. 
The datasets are 1, 2 and 3-grams.
To build the classifier, we use three well-known machine learning techniques that are proven to yield satisfactory results while working on bug reports: SVM, Random forest and linear regression.

We analyze whether bug types are predictable by testing the null hypothesis:

- $H_{03}$:  Bug types classifiers are not accurate.

To test our hypothesis, we predict the bug type of the most complex type, according to **RQ$_2$**, in ten different projects.
The results of the prediction tests are considered pertinent if they significantly improve upon a random classifier.

