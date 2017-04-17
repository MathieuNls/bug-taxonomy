# Study Design

The goal of this study is to analyze the location of bug fixes with the purpose of classifying bug fixes into types. More specifically, this study aims to answer the following three research questions:


- **RQ$_1$:** *What are the proportions of different types of bugs?* This research question aims to measure the  proportion of each bug type. Understanding the distribution of bugs based on the proposed types is an important step towards building better triaging and bug handling approaches.

- **RQ$_2$:** *How complex is each type of bugs?* This second research question aims to investigate the complexity of the different types of bug. To this end, we analyze and discuss the complexity of different types of bugs using typical code and process metrics [@Rosen2015b; @Kamei2013; @Shihab2010]. For code metrics, we compute the number of different files impacted by the fix and the number of hunks and churns. For process metrics, we analyze the severity of the bug, the number of duplicate bug report submitted, the number of times a bug report is reopened, the number of comments, and the time required to fix the bug.

- **RQ$_3$:** *Are bug types predictable?* In this research question, we investigate if and how  to predict the type of a bug report at submission time. Being able to build accurate classifiers predicting the bug type at submission time will allow improve the triaging and the bug handling process. Combining the results of our second research question with an accurate classifier will, for example, allow triaging approaches to assign complex bug reports based on their type to experienced developers within the organization. 
