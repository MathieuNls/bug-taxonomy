# Introduction

Large software systems are becoming increasingly important in the daily lives of many people.
A large portion of the cost of these software systems is attributed to their maintenance.
In fact, previous studies show that more than 90% of the software development cost is spent on maintenance and evolution activities [@Erlikh2000].
A plethora of previous research was dedicated to addressing issues related to software bugs.
For example, there have been several studies (e.g., [@Weiß2007; @Zhang2013]) that study the factors that influence the bug fixing time.
These studies empirically investigate the relationship between bug report attributes (description, severity, etc.) and the fixing time.
Other studies take bug analysis to another level by investigating techniques and tools for bug prediction and reproduction (e.g., [@Chen2013; @Kim2007a; @Nayrolles2015]).

All these studies, however, treat bug as equal in a sense that they do not assume any underlying classification of bugs. 
From practice and experience, we know that bug are indeed different and, in this study, we classify different bugs based on the location of their fixes.
By a fix, we mean a modification (adding or deleting lines of code) to an existing file that is used to solve the bug. 
With this in mind, the relationship between bugs and fixes can be modelled using the UML diagram in Figure \ref{fig:bug-taxo-diag}. 
The diagram only includes bug reports that are fixed and not, for example, duplicate reports.
From this figure, we can think of four instances of this diagram, which we refer to as bug taxonomy or simply bug types (see Figure \ref{fig:bug-taxo}).

\begin{figure}[h!]
  \centering
    \includegraphics[scale=0.5]{media/bug-taxo-class-diag.png}
    \caption{Class diagram showing the relationship between bugs and fixed
    \label{fig:bug-taxo-diag}}
\end{figure}

\begin{figure}[h!]
  \centering
    \includegraphics[scale=0.6]{media/bug-taxo.png}
    \caption{Proposed Taxonomy of Bugs
    \label{fig:bug-taxo}}
\end{figure}

The first and second types are the ones we intuitively know about.
T1 refers to a bug being fixed in one single location (i.e., one file), while T2 refers to bugs being fixed in more than one location.
In Figure 2, only two locations are shown for the sake of clarity, but many more locations could be involved in the fix of a bug.
T3 refers to multiple bugs that are fixed in the same location.
T4 is an extension of T3, where multiple bugs are resolved by modifying the same set of locations.
Note that T3 and T4 bugs are not duplicates, they may occur when different features of the system fail due to the same root causes (faults).

In our dataset, composed of 388 projects and presented in section \ref{context-selection}, the proportion of each type of bug is as follows: T1 6.8 \%, T2 3.7 \%, T3 28.3 \% and T4 61.2 \%. 
Also, classical measures of complexity such as duplication, fixing time, number of comments, number of time a bug is reopened, files impacted, severity, changesets, hunks, and chunks, also presented in section \ref{context-selection}, show that type 4 are significantly more complex than types 1, 2 and 3.

The existence of a high number of T4 bugs and the fact that they are more complex call for techniques that can effectively tag bug report as T4 at submission time for enhanced triaging. More particularly, we are interested in the following research questions:


- **RQ1:** *Are T4 bug predictable at submission time?* In this research question, we investigate if and how to predict the type of a bug report at submission time. Being able to build accurate classifiers predicting the bug type at submission time will allow improving the triaging and the bug handling process.
- **RQ2:** *What are the best predictors of type 4 bugs ?* This second research question aims to investigate what are the markup that allows for accurate prediction of type 4 bugs. 


Our objective is to propose a classification that can allow researchers in the field of mining bug repositories to use the taxonomy as a new criterion in triaging, prediction, and reproduction of bugs.
By analogy, we can look at the proposed bug taxonomy similarly as the clone taxonomy presented by Kapser and Godfrey [@CoryKapser].
The authors proposed seven types of source code clones and then conducted a case study, using their classification, on the file system module of the Linux operating system.
This clone taxonomy continues to be used by researchers to build better approaches for detecting a given clone type and being able to compare approaches with each other effectively.
Moreover, we build upon this proposed classification and predict the type of incoming bugs with a 65.40\% precision 94.16\% recall for $f\_1$ measure of 77.19\%.

