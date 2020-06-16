MiRAE: Minimal Reproducible Analysis Example
================

## Purpose

This repository contains code for a Minimal Reproducible Analysis
Example (MiRAE). This was developed as a minimal example of what an R
project compliant to the PPS data management plan should look like.

## Project Structure

details to be added…

    ## C:/projects/PPS_R/MiRA/.
    ## +-- data
    ## |   +-- processed
    ## |   |   \-- fertilizer_trial_WUR.xlsx
    ## |   \-- raw
    ## |       +-- Meststof proef WUR.csv
    ## |       \-- Meststof proef WUR_metadata.xlsx
    ## +-- MiRA.Rproj
    ## +-- README.md
    ## +-- README.Rmd
    ## +-- report
    ## |   +-- MiRAE_report.pdf
    ## |   +-- MiRAE_report.Rmd
    ## |   \-- MiRAE_report.tex
    ## \-- scripts
    ##     +-- 0_build_project.R
    ##     +-- 1_simulate_exp_data.R
    ##     +-- 2_data_cleaning.R
    ##     \-- MiRAE_funcs.R

## Try it yourself

Please download the project and poke around \! It is very simple to do
so.

You simply need to have **Git** installed on your computer. You can do
that manually (<https://git-scm.com/downloads>) or via the WUR available
software interface.

Just click on the green button above **“Clone or download”** and copy
the repo url, then…

### Using Rstudio

  - Go to File \> New Project… \> Version Control \> Git, then paste the
    repo url in the field *Repository url:*.
  - Tell Rstudio where you want the project to be clone on our computer
    in *Project directory name:*.
  - When you are ready just click on **Create Project** and the project
    will be automatically downloaded on your computer and open in an
    RStudio session.

### Using Git directly

Go to the location where you want to clone the project, then right click
on a blank area and select *Git Bash Here*. A Bash terminal will open.
Then type:

``` bash
git clone https://github.com/ALanguillaume/MiRAE.git
```
