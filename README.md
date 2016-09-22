# RPGUnit
RPGUnit is an open source framework aimed at making unit testing easy for RPG developers.

It is a regression testing framework, similar to [JUnit](http://junit.org/) but written in [RPG ILE](https://en.wikipedia.org/wiki/IBM_RPG), a procedural language mainly found on the [iSeries platform](https://en.wikipedia.org/wiki/IBM_System_i).  

Full documentation is available at the [SourceForge Website](http://rpgunit.sourceforge.net/)  

## Installation
Instructions on how to install are [available here](http://rpgunit.sourceforge.net/install.html)


## Quick Example
Here's an example of a basic test to show how the framework is used
```rpg
h nomain

 /copy rpgunit1,testcase

d test_failure    pr
                                                            
p test_failure    b                   export                
d                 pi
 /free                                                      
  iEqual(4: 2 + 2);
 /end-free         
p                 e
```

_Read more at http://rpgunit.sourceforge.net/tutorial.html_  


## Changelog
A [Changelog](CHANGELOG.md) has been available since version 0.2
