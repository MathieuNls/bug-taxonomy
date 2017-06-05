# Experimentations

In this section, we present the results of our experiences and interpret them to answer our two research questions.

## Are T4 bug predictable at submission time?

To answer this question, we used as features the words in the bug description contained in a bug report. We removed he stopwords (i.e. the, or, she, he) and truncated the remaining words to their roots (i.e. writing becomes write, failure becomes fail and so on). We experimented with 1-gram, 2-gram, and 3-gram words weighted using tf-idf. To build the classifier, we examined three machine learning techniques that have shown to yield satisfactory results in related studies: SVM, Random forest and linear regression [@Weiß2007; @Alencar2014; @Nam2013]

To answer **RQ$_1$**, we analyze the accuracy of predictors aiming at determining the type of a bug at submission time (i.e. when the bug report is submitted by someone).  

Tables \ref{tab:1gram}, \ref{tab:2gram} and \ref{tab:3gram} presents the results obtained while building classifiers for the most complex type of bug. According to **RQ$_2$**, the most complex type of bug, in terms of duplicate, time to fix, comments, reopening, files changed, severity, changesets, churns, and hunks, is T4.

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


https://stats.stackexchange.com/questions/82162/cohens-kappa-in-plain-english + random

\fbox{%
\parbox{0.9\textwidth}{%
The conclusion is that bug types classifiers are indeed accurate.}%
}

## What are the best predictors of type 4 bugs ?

In this section we answer our second research question: *What are the best predictors of type 4 bugs*. 
To do so, we extracted the best predictor of type 4 bugs for each one of the extracted grams (1, 2 and 3) for each of our ten test projects (Five Apache, Five Netbeans).
Then, we manually investigate the source code and the reports of these ten software projects in order to determine why a given word is a good predictor of type 4 bug.
In the remaining of this section we present our findings by project and then provide a conclusion on the best predictors of type 4 bugs.

### Ambari

Ambari is aimed at making Hadoop management simpler by developing software for provisioning, managing, and monitoring Apache Hadoop clusters.
One of the most acclamed feature of Ambari is the ability to visualize clusters' health, according to user-defined metric, with heatmaps.
These heatmaps give a quick overview of the system.

Figure \ref{fig:ambari-heatmap} shows a screenshot of such a heatmap.

\begin{figure}[h!]
  \centering
    \includegraphics[scale=0.6]{media/ambari-heatmap.jpg}
    \caption{Ambari heatmap
    \label{fig:ambari-heatmap}}
\end{figure}

At every tested grams (i.e. 1, 2 and 3) the word "heatmap" is a strong predictor of type 4 bugs. 
The heatmap feature is a complex feature as it heavily relies on the underlying instrumentation of Hadoop and the comsumption of many log format in order to, for example, extract the remaning free space on a disk or the current load of a CPU.

Another word that is a strong predictor of type 4 bug is "nagio". 
Nagio is a log monitoring server belonging to the Apache constellation. 
It is used as optional add-on for Ambari and, as for the heatmap, is very suceptible to log format change and API breakage.

Versions of the "nagio" and "heatmap" keywords include: "heatmap displai", "ambari heatmap", "fix nagio", "nagio test", "ambari heatmap displai", "fix nagio test".

### Cassandra

Cassandra is database with high scalability and high availability without compromising performance.
While extracting the unique word combinations from the report of Cassandra, one word which is a strong predictor of type 4 bug is "snapshot".

As described in the documentation, in Cassandra terms, *a snapshot first flushes all in-memory writes to disk, then makes a hard link of the SSTable files for each keyspace. You must have enough free disk space on the node to accommodate making snapshots of your data files. A single snapshot requires little disk space. However, snapshots can cause your disk usage to grow more quickly over time because a snapshot prevents old obsolete data files from being deleted. After the snapshot is complete, you can move the backup files to another location if needed, or you can leave them in place.* [^](http://docs.datastax.com/en/archived/cassandra/2.0/cassandra/operations/ops_backup_takes_snapshot_t.html)

The definition gives the reader an insight on how complex this feature used in terms of intergration with the host system and how coupled it is to the Cassandra data model.

Other versions of the "snapshot" keyword include "snapshot sequenti", "make snapshot", "snapshot sequenti repair", "make snapshot sequenti". 

### Flume

Flume is a distributed, reliable, and available service for efficiently collecting, aggregating, and moving large amounts of log data.

One word which is a good predictor of type 4 in flume is "upgrad" and the 2-grams (upgrad flume) and the 3-grams ("upgrad flume to") versions.
Once again for the Apache dataset, a change in the software that induce a change in the underlying data model or data store, which is often the case when you upgrade flume to a new version, is a good indicator of the report complexity and the impact of said report on the sourcecode in terms of number of locations fixed.

On the reports manually analyzed, Flume's developers and users have a hard time upgrading to new versions in a sense that logs and dashboard get corrupted or disapear post-upgrade.
Significant efforts are then made in order to prevent such loses in the subsequent version.

### HBase 

HBase is a Hadoop database, a distributed, scalable, big data store provided by Apache.
The best predictor of type 4 bug in HBase is "bloom" as in "bloom filters". 
Bloom filters are a  probabilistic data structure that is used to test whether an element is a member of a set. (Network Applications of Bloom Filters: A Survey) 
Such a feature is hard to implement and hard to test because of its probabilistic nature.
A lot of feature commits (i.e. commit intended to add a feature) and fix commits (i.e. commit intended to fix a bug) beloging to the Hbase source code are related to the bloom filters.
Given the natre of the feature, it is not suprising to find the word "bloom" and its 2-, 3-grams counterparts ("on bloom", "bloom filter", "on bloom filter") as a good predictor of type 4 bug.

### Hive 

Hive is a data warehouse software facilitates reading, writing, and managing large datasets residing in distributed storage using SQL.
Hive is different from its Apache counterpart as the words that are the best predictors of type 4 bugs do not translate into a particular feature of the product but are directly the name of the incriminated part of the system: thrift. 
Thrift is a software framework, for scalable cross-language services development, combines a software stack with a code generation engine to build services that work efficiently and seamlessly between C++, Java, Python, PHP, Ruby, Erlang, Perl, Haskell, C#, Cocoa, JavaScript, Node.js, Smalltalk, OCaml and Delphi and other languages.
While Thrift is supposed to solve many compatibality issues when building clients for a product such as Hive, it is the root cause of many major problems in Hive. 
The top predictors for type 4 bugs in Hive are "thrifthttpcliservic" and "thriftbinarycliservic".

As Hive, and its client, are built on top of Thrift a it make sense that issues propagating from Thrift induce major refactoring and fixed accross the whole Hive source code.

### Cnd 

The CND projects is a part of the Netbeans IDE and provide support for C/C++.
The top two predicators of type 4 bugs are (1) parralelism and (2) obsevability of c/c++ code.
In each gram, we can find reference of the parrallel code being problematique while developed and executed via the Netbeans IDE: "parallel comput", "parallel", "parallel comput advis".
The other word, related to the observability of c/c++ code inside the Netbeans IDE is "Gizmo". "Gizmo" is the codename for the C/C++ Observability Tool built on top of D-Light Toolkit. 
We can find occurences of "Gizmo" in each gram : "gizmo" and "gizmo monitor" for example.

Once again, a complex cross-concern feature with a high impact on the end-user (i.e., the ability to code, execute and debug parrallel code inside Netbeans) is a the root cause of most of the type 4 bugs and mention of said feature in the report is a bug predictor of type of the bug.

### Editor 

The Editor component of Netbeans is the component which is handling all the textual edition, regardless of the programming language, in Netbeans.
For this component, the type 4 bugs are most likely related to the "trailling white spaces" and "spellcheck" features.

While these features do not, at first sight, be as complex as, for example, parralelism debugging, they have been the cause of the majority of type 4 bugs.
Upon manuall inspection of the related code (https://netbeans.org/projects/editor/) in the Editor component of Netbeans the complexity of these feature becomes evident.
Indeed, theses features behave differently for almost each type of text-file and textboxes inside Netbeans.
For example, the end-user expects the spellchecking feature of the IDE to kick in while typing a comment inside a code file but not on the code itself. 
A similar example can be described for the identification and removing of trailling white spaces where users wish the trailling white spaces to be deleted in c/c++ code but not, for example, while typing html or a commit message.

Each new language supported or addon supported by the Netbeans IDE and leveraging the features of the Editor component is suceptible to be the root cause of a major refactoring in order to have a coherent behaviour in terms of "trailling white spaces" and "spellchecking".

### Java

The Java component of Netbeans is reponsible for the Java support of Netbeans in the same fashion as CND is reponsible for c/c++ support.
For this particular component the set of features that are good predictor of type 4 are the ones related to the Java autcompletion and navigation optimization.
The autocompletion have to be able to provide suggestion in a near-instaneous manner if it is to be usefull to the developer. 
In order to provide near-instaneous suggestion on modest machines and despite the depth of the Java API, Netbeans developers opted of a statisticall autocompletion.
The autocompletion *remembers* which of its suggestions you used before and only provide the ones
you are the most likely to want based on your previous usage.
In addition, each suggestion is companioned with percentage which describe the number of time you pick a given suggestion over the other.
One can envision a such a system can be tricky to implement with respect to new API being added in the Java language at each upgrade.
Indeed, when a new API comes to light following a Java upgrade on the developer's machine, then, the autocompletion has to make these new API appears in the autocompletion despite their 0\% choosed rate. The 0\% being linked to the fact that this suggestion was not available thus far and not to the fact that the developer never picked it.
When the new suggestion, related to the new API, has been ignored a given number of time, then, it can be safely removed for the list of suggestions.

Implementation of optimizations related to autocompletions and navigations are the root causes of many type 4 bugs and we can find them in the gram extracted words that are good predictor: "implement optim", "move otim", "optim import implement", "call hierarchi implement".

### JavaEE

The JavaEE component of Netbeans is reponsible for the support of the JavaEE in Netbeans. 
This module is different from the CND and JAVA module in a sense that it uses and expands a lot of functionalities from the JAVA component.
For the JavaEE component the best predictor of type 4 bugs are the hibernate and webscoket features which can be found in many gram forms: "hibern revers", "websocket endpoint", "hibern", "websocket", "implement hibern revers", "hibern revers engin".

Hibernate is an ORM that enables developers to more easily write applications whose data outlives the application process. 
As an Object/Relational Mapping (ORM) framework, Hibernate is concerned with data persistence as it applies to relational databases (via JDBC). 

The shortcoming of Netbeans leading to most of the type 4 bugs are related to the annotation based persistence of Hibernate where developers can annotate their class attributes with the name of the column they wish the value of the attribute to be persisted.
While the annotation mechanism is supported by Java, it is not possible *compile* annotation and make sure that their statically sound.
Consequently, a lot of tooling around annotation have to be developed and maintained accordingly to new databases updates.
Such tooling, for example, is responsible for querying the database model in order to make sure that the annotated columns exists and is able to store the attribute data type-wise.

### Platform

The last netbeans component we analyzed is the one named Platform. 
*The NetBeans Platform is a generic framework for Swing applications. It provides the "plumbing" that, before, every developer had to write themselves—saving state, connecting actions to menu items, toolbar items and keyboard shortcuts; window management, and so on.* (https://netbeans.org/features/platform/)

The best predictor of type 4 bug in the platform component is the "filesystem" word which refers to the ability of any application built atop of Platform to use the filesystem for saves and such.

What we can conclude for this second research question is that the best predictor of type 4 bugs are the mention of a cross-concern, complex, widely used feature in the targeted system.
Reports mentionning said feature are likely to create a type 4 structure with many bugs being fixed in the same set of files.
One noteworthy observation is that the 2- and 3-grams extraction do not add much to the precision with regard to the 1-gram extraction as seen the first research question.
Upon the manual analysis required for this research question, we can deduct why.
Indeed, the problematic features within a given system are identified with a single word (i.e. hibernate, filesystem, spellcheck, ...).
While the 2- and 3-grams classifiers do not provide an additional performance in the classification process they still become handy when trying to target which part of the feature a good predictor of type 4 (implement optim, gizmo monitor, heatmap displai, ...)

