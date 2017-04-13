## Version control systems\label{sec:version-control}
[WAHAB: If we need to reduce the number of pages, you can remove this section.]
Version control consists of maintaining the versions of files --- such as source code and other software artifacts [@Zeller1997]. Version control tools have been created to help practitioners manage the version of their software artifacts.
Each evolution of software is a version (or revision), and each version (revision) is linked to the one before through modifications of software artifacts.
These modifications consist of updating, adding or deleting software artifacts.
They can be referred as diff, patch or commit\footnote{These names are not to be used interchangeably as a difference exists.}.
Each diff, patch or commit have the following characteristics:


- Number of Files: The number of software files that have been modified, added or deleted.
- Number of Hunks: The number of consecutive code blocks of modified, added or deleted lines in textual files. Hunks are used to determine, in each file, how many different places the developer has modified.
- Number of Churns:  The number of lines modified. However, the churn value for a line change should be at least two as the line has to be deleted first and then added back with the modifications.

In modern version control systems, modifications to the source code is done through the commit mechanism.
The commit operation will version the modifications applied to one or many files.

Figure \ref{fig:branching} presents the data structure used to store a commit.
Each commit is represented as a tree.
The root leaf (green) contains the commit, tree and parent hashes as same as the author and the description associated with the commit.
The second leaf (blue) contains the leaf hash and the hashes of the files of the project.

\begin{figure}[h!]
  \centering
    \includegraphics[scale=0.20]{media/commit-datastructure.png}
    \caption{Data structure of a commit.
    \label{fig:branching}}
\end{figure}

In this example, we can see that author "Mathieu" has created the file $file1.java$ with the message "project init".

\subsection{Project Tracking Systems\label{sec:issue-tracking}}

Project tracking systems allow end users to create bug reports (BRs) to report unexpected system behavior.
These systems are also used by development teams to keep track of the modifications induced by a bug and bug reports, and keep track of the fixes.

\begin{figure}[h!]
	\centering
	\includegraphics[scale=0.5]{media/bzLifecycle.png}
	\caption{Lifecyle of a report [@Bugzilla2008]}
	\label{fig:bug-lifecyle}
\end{figure}

Figure \ref{fig:bug-lifecyle} presents the life cycle of a report.
When a report is submitted by an end-user, it is set to the *UNCONFIRMED* state until it receives enough votes or that a user with the proper permissions modifies its status to *NEW*.
The report is then assigned to a developer to be fixed.
When the report is in the *ASSIGNED* state, the assigned developer(s) starts working on the report.
A fixed report moves to the *RESOLVED* state. Developers have five different possibilities to resolve a report: *FIXED*, *DUPLICATE*, *WONTFIX*, *WORKSFORME* and *INVALID* [@Koponen2006].


- RESOLVED/FIXED: A modification to the source code has been pushed, i.e., a changeset (also called a patch) has been committed to the source code management system and fixes the root problem described in the report.
- RESOLVED/DUPLICATE: A previously submitted report is being processed. The report is marked as a duplicate of the original report.
- RESOLVED/WONTFIX: This is applied in the case where developers decide that a given report will not be fixed.
- RESOLVED/WORKSFORME: If the root problem described in the report cannot be reproduced on the reported OS/hardware.
- RESOLVED/INVALID: If the report is not related to the software itself.


Finally, the report is *CLOSED* after it is resolved.
A report can be reopened (sent to the *REOPENED* state) and then assigned again if the initial fix was not adequate (the fix did not resolve the problem).
The elapsed time between the report marked as the new one and the resolved status are known as the *fixing time*, usually in days.
In the case of task branching, the branch associated with the report is marked as ready to be merged.
Then, the person in charge (quality assurance team, manager, etc...) will be able to merge the branch with the main line.
If the report is reopened: the days between the time the report is reopened and the time it is marked again as *RESOLVED FIXED* are cumulated.
Reports can be reopened many times.

Tasks follow a similar life cycle with the exception of the *UNCONFIRMED* and *RESOLVED* states.
Tasks are created by management and do not need to be confirmed to be *OPEN* and *ASSIGNED* to developers.
When a task is complete, it will not go to the *RESOLVED* state, but to the *IMPLEMENTED* state.
Bug and crash reports are considered as problems to eradicate in the program.
Tasks are considered as new features or amelioration to include in the program.

Reports and tasks can have a severity [@Bettenburg2008].
The severity is a classification to indicate the degree of impact on the software.
The possible severities are:


- blocker: blocks development and/or testing work.
- critical: crashes, loss of data, severe memory leak.
- major: major loss of function.
- normal: regular report, some loss of functionality under specific circumstances.
- minor: minor loss of function, or other problem where easy workaround is present.
- trivial: cosmetic problems like misspelled words or misaligned text.

The relationship between an report or a task and the actual modification can be hard to establish, and it has been a subject of various research studies (e.g., [@Antoniol2002; @Bachmann2010; @Wu2011]).
This reason is that they are in two different systems: the version control system and the project tracking system.
While it is considered a good practice to link each report with the versioning system by indicating the report $\#id$ on the modification message, it has been shown than more than half of the submitted reports are not linked to their corresponding source code changes [@Wu2011].

