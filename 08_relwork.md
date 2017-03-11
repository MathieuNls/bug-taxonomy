# Related Works

Researchers have been studying the relationships between
the bug and source code repositories for more than two decades.
To the best of our knowledge the first ones who conducted this type of study on a significant scale were Perry and Stieg [@PerryDewayneE.1993].
In these two decades, many aspects of these relationships have been studied in length.
For example, researchers were interested in improving the bug reports themselves by proposing guidelines [@Bettenburg2008], and by further simplifying existing bug reporting models [@Herraiz2008].

Another field of study consist of assigning these bug reports, automatically if possible, to the right developers during triaging [@Anvik2006; @Jeong2009; @Tamrawi2011a; @Bortis2013].
Another set of approaches focus on how long it takes to fix a bug
[@Zhang2013; @Bhattacharya2011; @Saha2014] and where it should be fixed [@Zhou2012; Zeller2013a].
With the rapidly increasing number of bugs, the community was also interested in prioritizing bug reports [@Kim2011c], and in predicting the severity of a bug[@Lamkanfi2010].
Finally, researchers proposed approaches to predict which bug will get reopened [@Zimmermann2012; Lo2013], which bug report is a duplicate of another one [@Bettenburg2008a; @Tian2012a; @Jalbert2008] and which locations are likely to yield new bugs [@Kim2007; @Kim2006; @Tufano2015].
However, to the best of our knowledge, there are not many attempts to classify bugs the way we present in this paper.
In her PhD thesis [@Eldh2001], Sigrid Eldh discussed the classification of trouble reports with respect to a set of fault classes that she identified.
Fault classes include computational logical faults, ressource faults, function faults, etc.
She conducted studies on Ericsson systems and showed the distributions of trouble reports with respect to these fault classes.
A research paper was published on the topic in [@Eldh2001].
or safety critical[@Hamill2014].
Hamill et al.[@Hamill2014] proposed a classification of faults and failures in critical safety systems.
They proposed several types of faults and show how failures in critical safety systems relate to these classes.
They found that only a few fault types were responsible for the majority of failures.
They also compare on pre-release and post-release faults and showed that the distributions of fault types differed for pre-release and post-release failures.
Another finding is that coding faults are the most predominant ones.

Our study differs from theses studies in the way that we focus on the bugs and their fixes across a wide range of systems, programming languages, and purposes.
This is done independtly from a specific class of faults (such as coding faults, resource faults, etc.).
This is because our aim is not to improve testing as it is the case in the work of Eldh [@Eldh2001] and Hamill et al. [@Hamill2014].
Our objective is to propose a classification that can allow researchers in the filed of mining bug repositiories to use the taxonomy as a new criterion in triaging, prediction, and reproduction of bugs.
By analogy, we can look at the proposed bug taxonomy in a similar way as the clone taxonomy presented by Kapser and Godfrey [@CoryKapser].
The authors proposed seven types of source code clones and then conducted a case study, using their classification, on the file system module of the Linux operating system.
This clone taxonomy continues to be used by researchers to build better approaches for detecting a given clone type and being able to effectively compare approaches with each other.
