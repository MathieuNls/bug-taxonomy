# Discussion

In this section, we discuss the answers to our three research questions.

## RQ$_1$: What are the proportions of different types of bugs?


One important finding of this study is that there is significantly more Types 3 and 4 bugs than Types 1 and 2 in all studied systems.
Moreover, this observation is not system-specific.
The traditional one-bug/one-fault (i.e. Type 1) way of thinking about bugs only accounts for 6.8\% of the bugs.

We believe that triaging algorithms [@Jalbert2008; @Jeong2009; @Khomh2011a; @Tamrawi2011a] can benefit from these findings by developing techniques that can detect Type 2 and 4 bugs.
This would result in better performance in terms of reducing the cost, time and efforts required by the developers in the bug fixing process.

## RQ$_2$: How complex is each type of bugs?

To evaluate the complexity of each type of bug, we have computed five process metrics (time to close, duplications, reopenings, comments, and severity) and four code metrics (files, commit, hunks and churns).

**Process complexity**: For four out the five process metrics we used, we found that types 3 and 4 combined performed significantly worst than Types 1 and 2.
The only process metric where types 3 and 4 do not perform significantly worse than types 1 and 2 is the severity.
Although clear guidelines exist on how to assign the severity of a bug, it remains a manual process done by the bug reporter.
Also, previous studies, notably those by Khomh et al.
[@Khomh2011a], showed that severity is not a consistent/trustworthy characteristic of a BR, which lead to he emergence of studies for predicting the severity of bugs (e.g., [@Lamkanfi2010; @Lamkanfi2011; @Tian2012]).
Nevertheless, we discovered that, in our ecosystems, types 3 and 4 has a higher severity than types 1 and 2.

**Code complexity**: All our code metrics (files, commit, hunks and churns) are showing similar results.
Indeed, in all cases, Types 3 and 4 perform worst than Types 1 and 2, suggesting, once again, that Types 3 and 4 are, in fact, more complex than Types 1 and 2.

While current approaches are aiming to predict which bug will reopen use the amount of modified files [@Shihab2010; @Zimmermann2012; @Lo2013], we believe that they can be improved by taking into account the type of a bug.
For example, if we can detect that an incoming bug if of Type 3 or 4 then it is more likely to reopened than a bug of Type 1 or 2.
Similarly, approaches aiming to predict the files in which a given bug should be fixed could be categorized and improved by knowing the bug type in advance [@Zhou2012; @Kim2013a].
Similarly to reopening, we believe that approaches targeting the identification of
duplicates [@Bettenburg2008a; @Jalbert2008; @Sun2010; @Tian2012a]  could leverage this taxonomy to
achieve even better performances in terms of recall and
precision.
Finally, we believe that approaches aiming to predict the fixing
time of a bug (e.g., [@Panjer2007; @Bhattacharya2011; @Zhang2013]) can highly benefit from
accurately predicting the type of a bug and therefore better
plan the required manpower to fix the bug.


## RQ$_3$: Are bug types predictable at opening time?

In this study, we showed that different bug types exist and their complexity differs.
Being able to identify the complexity of a fix linked to a bug report is an important task as an accurate prediction can lead to improvements in the organization.
Indeed, more complex reports can be assigned to experienced developers for example.
This issue has been explored by researchers by predicting the severity of a report [@Lamkanfi2010; @Tian2012; @Lamkanfi2011].
As discussed in section \ref{sec:issue-tracking}, the severity attribute of a report has not been designed to show complexity but perceived impact on the product. 
Indeed the different severities (blocker, critical, major, normal, minor, trivial) refers, for example, to loss of functionalities or blockages in the development process.
They do not link to how complex a bug is to fix.
Other approaches have focused on predicting how long it will take to fix a bug [@Weiß2007; @Bhattacharya2011] and the fixing time of a bug can be seen as a reflection of its complexity.
However, Saha *et al.* found that the fixes for a bug that stayed open more than a year tend to be simple ones [@Saha2014]. 
The reason why these bugs stayed open such a long time is not often clear.

We tackle the complexity of a bug by introducing a new notion, its type.
Predicting the type at an opening time can greatly benefit many research fields revolving around bug tracking system and enhancing software quality in general.
For example, bug types can be linked to significantly different severity, time to fix, reopening and duplication.
These factors can improve bug triaging by assigning complex types to experienced developers.

Also, accurately predicting the bug type can be benefic to approaches searching to identify the fix location.
Most of these approaches work as a recommendation system where developers are presented with a list of files that potentially have to be fixed to resolve the bug. 
We believe that the performances and helpfulness of these approaches for the developers could be greatly improved if they relied on bug type we proposed.
Indeed, they could, in addition, to proposing a list of files that likely require a fix, they could propose to the developers a list of a file and an indication of how many of these files need to be fixed.
It will be one for type 1 and 3 and more than one for types 2 and 4.

To conclude, we believe that they are several advantages for different fields in predicting bug type and we took a step in that direction with this paper by accurately predicting the most complex type: Type 4.


