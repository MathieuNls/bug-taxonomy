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

\input{tex_tables/random}

Each one of our nine classifiers improves upon the random one on all projects and by a large margin ranging from 20.73% to 22.48%.

\fbox{%
\parbox{0.9\textwidth}{%
The conclusion is that bug types classifiers are indeed accurate.}%
}


apache.2grams.xmlambari-1-2-3-4-4.tfidf.wnet.xml
1.97039 -  heatmap displai</word>
1.56803 -  ambari heatmap</word>
1.45959 -  new stack</word>
1.43768 -  make compon</word>
1.43768 -  config ui</word>
1.36335 -  py br</word>
1.31362 -  updat version</word>
1.31362 -  nagio test</word>
1.31362 -  fix nagio</word>
1.29905 -  manag support</word>
apache.2grams.xmlcassandra-1-2-3-4-4.tfidf.wnet.xml
1.33355 -  x x</word>
0.97163 -  snapshot sequenti</word>
0.97163 -  sequenti repair</word>
0.97163 -  make snapshot</word>
0.85016 -  sstabl import</word>
0.85016 -  export doesn</word>
0.76352 -  import export</word>
0.71283 -  doubl quot</word>
0.68013 -  us bulkwrit</word>
0.68013 -  up secondari</word>
apache.2grams.xmlflume-1-2-3-4-4.tfidf.wnet.xml
0.97249 -  upgrad flume</word>
0.97249 -  plugin d</word>
0.97249 -  flume upgrad</word>
0.97249 -  flume null</word>
0.97249 -  document plugin</word>
0.97249 -  d directori</word>
0.85696 -  null sink</word>
0.85696 -  jmx metric</word>
0.83356 -  variou layout</word>
0.83356 -  timeout is</word>
apache.2grams.xmlhbase-1-2-3-4-4.tfidf.wnet.xml
0.90580 -  gt gt</word>
0.81104 -  on bloom</word>
0.64794 -  bloom filter</word>
0.62670 -  test link</word>
0.62670 -  rebuild user</word>
0.62670 -  inform client</word>
0.58355 -  borg a</word>
0.56369 -  client column</word>
0.55639 -  a sv</word>
0.52683 -  more inform</word>
apache.2grams.xmlhive-1-2-3-4-4.tfidf.wnet.xml
1.38323 -  hive remov</word>
1.02074 -  thrifthttpcliservic test</word>
1.02074 -  thriftbinarycliservic and</word>
1.02074 -  refactor thriftbinarycliservic</word>
1.02074 -  and thrifthttpcliservic</word>
0.94782 -  vertex start</word>
0.94782 -  start log</word>
0.94782 -  fix vertex</word>
0.82933 -  val val</word>
0.82933 -  merg merg</word>
apache.3grams.xmlambari-1-2-3-4-4.tfidf.wnet.xml
1.97039 -  ambari heatmap displai</word>
1.57631 -  make compon name</word>
1.57631 -  config ui and</word>
1.57631 -  ambari make compon</word>
1.57631 -  ambari config ui</word>
1.31362 -  updat version number</word>
1.31362 -  nagio test p</word>
1.31362 -  fix nagio test</word>
1.31362 -  descript for nagio</word>
1.31362 -  ambari updat version</word>
apache.3grams.xmlcassandra-1-2-3-4-4.tfidf.wnet.xml
1.41306 -  x x x</word>
0.97163 -  snapshot sequenti repair</word>
0.97163 -  sequenti repair the</word>
0.97163 -  make snapshot sequenti</word>
0.97163 -  cassandra make snapshot</word>
0.85016 -  sstabl import export</word>
0.85016 -  import export doesn</word>
0.85016 -  export doesn t</word>
0.85016 -  cassandra sstabl import</word>
0.71283 -  doesn t support</word>
apache.3grams.xmlflume-1-2-3-4-4.tfidf.wnet.xml
0.97249 -  upgrad flume to</word>
0.97249 -  sink should support</word>
0.97249 -  plugin d directori</word>
0.97249 -  null sink should</word>
0.97249 -  flume upgrad flume</word>
0.97249 -  flume to us</word>
0.97249 -  flume null sink</word>
0.97249 -  flume document plugin</word>
0.97249 -  document plugin d</word>
0.85696 -  metric support for</word>
apache.3grams.xmlhbase-1-2-3-4-4.tfidf.wnet.xml
0.81104 -  on bloom filter</word>
0.62670 -  to integr test</word>
0.62670 -  rebuild user region</word>
0.62670 -  more inform client</word>
0.62670 -  integr test link</word>
0.62670 -  inform client column</word>
0.62670 -  column to integr</word>
0.62670 -  client column to</word>
0.62670 -  add more inform</word>
0.58355 -  sv borg a</word>
apache.3grams.xmlhive-1-2-3-4-4.tfidf.wnet.xml
1.02074 -  thriftbinarycliservic and thrifthttpcliservic</word>
1.02074 -  refactor thriftbinarycliservic and</word>
1.02074 -  and thrifthttpcliservic test</word>
0.94782 -  vertex start log</word>
0.94782 -  start log for</word>
0.94782 -  hive fix vertex</word>
0.94782 -  fix vertex start</word>
0.82933 -  spark build after</word>
0.82933 -  hive fix spark</word>
0.82933 -  fix spark build</word>
apache.tf.wnetambari-1-2-3-4-4.tfidf.wnet.xml
1.69574 - nan</word>
1.42108 - heatmap</word>
1.40534 - typo</word>
1.29905 - zypper</word>
1.21258 - yuicombin</word>
1.21258 - flicker</word>
1.18097 - testactionqueu</word>
1.08710 - umask</word>
1.02694 - libjar</word>
0.98742 - consist</word>
apache.tf.wnetcassandra-1-2-3-4-4.tfidf.wnet.xml
0.77359 - sequenti</word>
0.68013 - bulkwrit</word>
0.64898 - expiringcolumn</word>
0.59023 - export</word>
0.56675 - datacentershardstategi</word>
0.56675 - columncomparatorfactorytest</word>
0.52028 - doubl</word>
0.50899 - stategi</word>
0.49525 - metric</word>
0.48627 - slf</word>
apache.tf.wnetflume-1-2-3-4-4.tfidf.wnet.xml
0.97249 - structur</word>
0.97249 - spooldir</word>
0.85696 - plugin</word>
0.83356 - layout</word>
0.83356 - jappend</word>
0.83356 - asynchbasesink</word>
0.74143 - upgrad</word>
0.73454 - variou</word>
0.73454 - calcul</word>
0.70424 - jmx</word>
apache.tf.wnethbase-1-2-3-4-4.tfidf.wnet.xml
0.62650 - testshel</word>
0.57672 - zkleadermanag</word>
0.56639 - bloom</word>
0.55549 - authenticationtokensecretmanag</word>
0.50067 - rebuild</word>
0.49241 - rowtoobigexcept</word>
0.49241 - preemptiv</word>
0.48953 - scannermodel</word>
0.44775 - gt</word>
0.42328 - filter</word>
apache.tf.wnethive-1-2-3-4-4.tfidf.wnet.xml
2.21152 - commonrcfileinputformat</word>
1.02074 - thrifthttpcliservic</word>
1.02074 - thriftbinarycliservic</word>
0.78598 - remov</word>
0.72894 - val</word>
0.71790 - vertex</word>
0.66649 - refactor</word>
0.64355 - merg</word>
0.55286 - gentezutil</word>
0.52959 - cbo</word>
netbeans.2grams.xmlcnd-1-2-3-4-4.tfidf.wnet.xml
2.71862 -  support amd</word>
2.71862 -  project unit</word>
2.48757 -  gizmo monitor</word>
1.82295 -  n a</word>
1.81241 -  track gizmo</word>
1.74075 -  a n</word>
1.63119 -  parallel comput</word>
1.63119 -  comput advis</word>
1.63119 -  advis appear</word>
1.61551 -  sourc sourc</word>
netbeans.2grams.xmleditor-1-2-3-4-4.tfidf.wnet.xml
1.26643 -  trailingwhitespaceremov resetmodregion</word>
1.16901 -  refresheifindic creat</word>
1.08551 -  spelcheck doe</word>
1.08551 -  in properti</word>
0.94980 -  spellcheck creat</word>
0.94980 -  repositoryupdat creat</word>
0.94243 -  lexer demo</word>
0.91181 -  us supertyp</word>
0.91181 -  supertyp where</word>
0.86316 -  in repositoryupdat</word>
netbeans.2grams.xmljava-1-2-3-4-4.tfidf.wnet.xml
2.71039 -  implement optim</word>
2.71039 -  implement call</word>
2.34418 -  implement move</word>
2.34418 -  implement move</word>
2.34418 -  implement move</word>
2.03281 -  implement bean</word>
1.63045 -  bean info</word>
1.62625 -  implement histori</word>
1.48762 -  histori tab</word>
1.40860 -  test test</word>
netbeans.2grams.xmljavaee-1-2-3-4-4.tfidf.wnet.xml
1.66117 -  implement hibern</word>
1.30352 -  hibern revers</word>
1.26301 -  revers engin</word>
1.11316 -  ejb ref</word>
1.06793 -  websocket endpoint</word>
1.06793 -  sampl see</word>
1.06793 -  includ more</word>
0.96890 -  more java</word>
0.93442 -  li li</word>
0.91805 -  u request</word>
netbeans.2grams.xmlplatform-1-2-3-4-4.tfidf.wnet.xml
1.33431 -  remov deprec</word>
1.33431 -  filesytem getact</word>
1.33431 -  deprec filesytem</word>
1.05739 -  fileobject constructnam</word>
1.04467 -  quicksearch doe</word>
0.98938 -  sun jna</word>
0.98182 -  constructnam fileobject</word>
0.96068 -  express evalu</word>
0.94565 -  visual librari</word>
0.91377 -  in full</word>
netbeans.3grams.xmlcnd-1-2-3-4-4.tfidf.wnet.xml
2.09722 -  a n a</word>
1.91898 -  n a n</word>
1.87676 -  sourc sourc sourc</word>
1.63119 -  parallel comput advis</word>
1.63119 -  comput advis appear</word>
1.49256 -  pty helper for</word>
1.49256 -  provid pty helper</word>
1.48291 -  perform metric attribut</word>
1.48291 -  metric attribut to</word>
1.48291 -  icon is miss</word>
netbeans.3grams.xmleditor-1-2-3-4-4.tfidf.wnet.xml
1.08551 -  work in properti</word>
1.08551 -  spelcheck doe not</word>
0.94980 -  spellcheck creat attach</word>
0.94980 -  repositoryupdat creat attach</word>
0.94980 -  lock in spellcheck</word>
0.94980 -  in spellcheck creat</word>
0.94980 -  in repositoryupdat creat</word>
0.91181 -  us supertyp where</word>
0.91181 -  supertyp where possibl</word>
0.89395 -  updat lucen librari</word>
netbeans.3grams.xmljava-1-2-3-4-4.tfidf.wnet.xml
2.03281 -  implement bean info</word>
1.99134 -  test test test</word>
1.62625 -  implement histori tab</word>
1.48762 -  histori tab for</word>
1.35523 -  optim import implement</word>
1.35523 -  import implement optim</word>
1.35523 -  implement optim import</word>
1.35523 -  implement call hierarchi</word>
1.35523 -  hierarchi implement call</word>
1.35523 -  call hierarchi implement</word>
netbeans.3grams.xmljavaee-1-2-3-4-4.tfidf.wnet.xml
1.66117 -  implement hibern revers</word>
1.30352 -  hibern revers engin</word>
1.06793 -  more java ee</word>
1.06793 -  includ more java</word>
1.06793 -  ee sampl see</word>
1.06793 -  editor support for</word>
0.83058 -  revers engin implement</word>
0.83058 -  engin implement hibern</word>
0.80742 -  class javax swing</word>
0.78685 -  jdk as default</word>
netbeans.3grams.xmlplatform-1-2-3-4-4.tfidf.wnet.xml
1.33431 -  remov deprec filesytem</word>
1.33431 -  deprec filesytem getact</word>
1.14369 -  work in full</word>
1.04467 -  quicksearch doe not</word>
0.98938 -  com sun jna</word>
0.98182 -  filesystem fileobject constructnam</word>
0.98182 -  fileobject constructnam fileobject</word>
0.98182 -  constructnam fileobject java</word>
0.90633 -  fileobject java org</word>
0.88951 -  while activ j</word>
netbeans.tf.wnetcnd-1-2-3-4-4.tfidf.wnet.xml
1.96346 - objecttypedescriptor</word>
1.64567 - regist</word>
1.58253 - gz</word>
1.56338 - unit</word>
1.53351 - gizmo</word>
1.48077 - monitor</word>
1.44974 - amd</word>
1.36515 - custom</word>
1.35844 - pt</word>
1.32257 - aptpredefinedmacromap</word>
netbeans.tf.wneteditor-1-2-3-4-4.tfidf.wnet.xml
1.26643 - resetmodregion</word>
1.15090 - trailingwhitespaceremov</word>
1.08551 - spelcheck</word>
1.06237 - refresheifindic</word>
0.92868 - paxx</word>
0.91181 - supertyp</word>
0.86025 - li</word>
0.85646 - demo</word>
0.83699 - exclud</word>
0.81151 - coloringmap</word>
netbeans.tf.wnetjava-1-2-3-4-4.tfidf.wnet.xml
1.91109 - optim</word>
1.56573 - hierarchi</word>
1.33469 - initi</word>
1.25478 - jsp</word>
1.16215 - val</word>
1.16163 - preprocessor</word>
1.16163 - dsl</word>
1.14675 - sqlparam</word>
1.12927 - histori</word>
1.11326 - beaninfo</word>
netbeans.tf.wnetjavaee-1-2-3-4-4.tfidf.wnet.xml
1.24591 - li</word>
1.24591 - entitymanagergenerationstrategyresolv</word>
1.14949 - revers</word>
1.10897 - engin</word>
0.91098 - endpoint</word>
0.88460 - numberofitem</word>
0.87947 - datacent</word>
0.87655 - convert</word>
0.86988 - websocket</word>
0.79378 - ref</word>
