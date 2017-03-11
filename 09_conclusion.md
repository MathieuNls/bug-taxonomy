# Conclusion

In this paper, we proposed a taxonomy of bugs and performed an empirical study on two large open source datasets: the Netbeans IDE and the Apache Software Foundation's projects. 
Our study aimed to analyse: (1) the proportion of each type of bugs; (2) the complexity of each type in terms of severity, reopening and duplication; and (3) the predictability of bug types at opening time.

The key findings are: 
- Types 3 and 4 account for 89.5% of the bugs. This is particularly important considering that the types we intuitively know about and are targeted by approaches in triaging and bug prediction are types 1 and 2.
- Types 3 and 4 are more complex than to Types 1 and 3.

Our taxonomy and results can be used to classify past and new researches in several active areas such as bug reproduction and triaging, bug prediction, and detection of duplicate bug reports. 
Moreover, we took a step towards predicting type of a bug at submission time by accurately classifying type 4 bug. 
We believe that most of these areas could be improved since we can use results of fixing old bugs when new and related bugs arrive. As future work, we plan to test our taxonomy on additional opensource systems such as Eclipse or Linux. 
In addition, we will experiment with proprietary systems at Ericsson and report the differences between open source and proprietary systems.

# Reproduction Package

We provide a reproduction package that is publicly available at [link].
All the instructions needed to reproduce our results are self contained in the provided archive.