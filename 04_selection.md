## Context Selection

The context of this study consists of the change history of 388 projects belonging to two software ecosystem, namely, Apache and Netbeans.
Table \ref{table:datasets} reports, for each of them, (i) the number of projects analyzed, (ii) size ranges in terms of the number of classes and KLOC, (iii) the overall number of commits and issues analyzed, and (iv) the average, minimum, and maximum length of the projects' story (in years).

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


All the analyzed projects are hosted in *Git* or *Mercurial* repositories and have either a *Jira* or a *Bugzilla* issue tracker associated with it.
The Apache ecosystem consists of 349 projects written in various programming languages (C, C++, Java, Python, ...) and uses *Git* and *Jira*.
These projects represent the Apache ecosystem in its entirety; no system has been excluded from our study.
The complete list can be found online\footnote{https://projects.apache.org/projects.html?name}.
The Netbeans ecosystem consists of 39 projects, mostly written in Java.
Similarly to the Apache ecosystem, we did not select any of the projects belonging to the Netbeans ecosystem but all of them.
The Netbeans community uses *Bugzilla* and *Mercurial*.

The choice of the ecosystems to analyze is not random but rather driven by the motivation to consider projects are having (i) different sizes, (ii) different architectures, and (iii) different development bases and processes.
Indeed, Apache projects are extremely various regarding the size of the development team, purpose and technical choices [@Bavota2013].
On the other side, Netbeans has a relatively stable list of core developer and a common vision shared by the 39 related projects [@Wang2011].

Cumulatively, these datasets span from 2001 to 2014. In summary, our consolidated dataset contains 102,707 bugs, 229,153 changesets, 68,809 files that have been modified to fix the bugs, 462,848 comments, and 388 distinct systems.
We also collected 221 million lines of code modified to fix the bugs, identified 3,284 sub-projects, and 17,984 unique contributors to these bug report and source code version management systems.
The cumulated opening time for all the bugs reaches 10,661 working years (3,891,618 working days).

