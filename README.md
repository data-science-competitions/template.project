
# `template.project` <img src='https://i.imgur.com/M8Jk1AL.png' align="right" height="75"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![test-suite](https://github.com/tidylab/template.project/workflows/test-suite/badge.svg)](https://github.com/tidylab/template.project/actions)
[![code-coverage](https://codecov.io/gh/tidylab/template.project/branch/master/graph/badge.svg)](https://codecov.io/github/tidylab/template.project/?branch=master)
<!-- badges: end -->

## `template.project`

<img src="https://i.imgur.com/RLEQkhe.png" width="100%" style="display: block; margin: auto;" />

## Overview

This template conforms to a conceptual model of **Analysis Projects**
suggested by [Hadley
Wickham](https://docs.google.com/document/d/1LzZKS44y4OEJa4Azg5reGToNAZL0e0HSUwxamNY7E-Y/).
Using this template reduces: \* Unnecessary variance between projects
configurations; and \* Development time spent on making a barebone
project working for the first time. This is possible as the boilerplate
comes with: \* Fully configured test-suite, including code-coverage; and
\* Fully configured continuous-integration (CI) script for GitHub
Actions.

## Installation

You can install `template.project` by using:

``` r
install.packages("remotes")
remotes::install_github("tidylab/template.project")
```
