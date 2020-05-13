# shinycoreci-apps

<!-- badges: start -->
[![Run Tests](https://github.com/rstudio/shinycoreci-apps/workflows/runTests/badge.svg?branch=master)](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ArunTests)
[![Docker](https://github.com/rstudio/shinycoreci-apps/workflows/Docker/badge.svg?branch=master)](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ADocker)
[![Deploy](https://github.com/rstudio/shinycoreci-apps/workflows/Deploy/badge.svg?branch=master)](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ADeploy)
[![Trim Branches](https://github.com/rstudio/shinycoreci-apps/workflows/Trim%20Old%20Branches/badge.svg?branch=master)](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ATrim%20Old%20Branches)

<!-- badges: end -->

Test applications and workflows for Shiny R packages.

There are three main workflows:

* [**runTests:**](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ArunTests) Test applications using `shiny::runTests()`
* [**Docker:**](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ADocker) Create all SSO and SSP docker images
* [**Deploy**](https://github.com/rstudio/shinycoreci-apps/actions?query=workflow%3ADeploy): Deploy all testing apps to [shinyapps.io](shinyapps.io) and [beta.rstudioconnect.com](https://beta.rstudioconnect.com)


## Usage

First, clone the shinycoreci-apps repo. Next, install [`remotes::install_github("rstudio/shinycoreci")`](https://github.com/rstudio/shinycoreci).  You may need to add your `GITHUB_PAT` to your R Environ file (See `?usethis::edit_r_environ` and `?usethis::browse_github_pat`)

* [RStudio IDE](https://rstudio.com/products/rstudio/download/#download) - `shinycoreci::test_in_ide()`
* [RStudio Cloud](http://rstudio.cloud) - `shinycoreci::test_in_ide()`
* [RStudio Server Pro](https://colorado.rstudio.com) - `shinycoreci::test_in_ide()`
* R Terminal / R GUI - `shinycoreci::test_in_browser()`
* (Any) Web Browser - `shinycoreci::test_in_browser()`
* [shinyapps.io](http://shinyapps.io) - `shinycoreci::test_in_shinyappsio()`
* [RStudio Connect](http://beta.rstudioconnect.com) - `shinycoreci::test_in_connect()`
* SSO - `shinycoreci::test_in_sso(release = "bionic")`
  > will require docker login. Run `docker login` in the terminal
* SSP - `shinycoreci::test_in_ssp(release = "centos7")`
  > will require docker login. Run `docker login` in the terminal

All testing functions may be run from within the IDE (except for R Terminal / R Gui).

#### IDE Example
```r
# (Install `shinycoreci`)
remotes::install_github("rstudio/shinycoreci")

# Sitting at the root folder of the rstudio/shinycoreci-apps repo
shinycoreci::test_in_ide()
```


## `shiny::runTests()` testing frameworks

These different testing frameworks are used to automate the Continuous Integration Testing process of the shiny ecosystem.

[**`shinytest`**](https://github.com/rstudio/shinytest)
* Local App Driver testing (w/ headless Phantom.js browser)
* Apps have tests in `./APP/tests/shinytest` directory
* Functions:
  * `shinycoreci::test_shinytest()`

**`testthat`**
* Local R testing (R environment)
* Functions:
  * `shinycoreci::test_testthat()`

[**`shinyjster`**](https://github.com/schloerke/shinyjster)
* Primarily a JavaScript library
* Test javascript code is added in `app.R`
* `shinyjster` is currently intended for testing apps specifically created to test something in particular. It should only be used to test full stack integration or browser / platform specific behavior.  This positions `shinyjster` differently than `shinytest::testApp()` and `shiny::testServer()`.
* Functions:
  * `shinycoreci::test_shinyjster()`
  * This will run through all of the `shinyjster` selenium browsers that work with GitHub Actions
    * `shinyjster::selenium_chrome()`
    * `shinyjster::selenium_firefox()`
    * `shinyjster::selenium_edge()`
    * `shinyjster::selenium_ie()`

## Trouble Shooting


### Diagnosing `shinytest` problems posted by GitHub Actions

![shinytest broken branch name](README_files/broken_tests_action.png)

When `shinytest` fails, the workflow will capture the failed test artifacts and push them to a new branch of `rstudio/shinycoreci-apps`.  This branch will be in the form of `gha-SHA-DATE-OS`.

* `SHA` - The git sha of the commit that triggered the workflow
* `DATE` - The year, month, day, hour, and minute with the format `YEAR_MO_DY_HR_MN`
* `RVERSION` (not shown) - Short R version. Ex: `4.0`
* `OS` - One of `macOS`, `Windows`, or `Linux`.

#### Steps fix broken `shinytest` apps

The following manual bash steps might be useful in resolving `shinytest` problems.

```bash
#!/usr/bin/bash
# Sitting at the root folder of the rstudio/shinycoreci-apps repo

git checkout master
git pull
git checkout BROKEN_BRANCH_NAME

# Accept or reject results
Rscript -e "shinycoreci::view_test_diff()"

# If any apps need to be fixed, fix them and re-run tests for those apps.

# At this point, need to delete any *-current directories that remain.
find . -name "*-current"
# If any are found, delete them
rm -rf XXXXXX-current

# Add deleted files to git
git add -u .
# Make sure that the right files are staged. No *-current directories!
git status
git commit -m "MESSAGE"

# Merge the branch into master
git checkout master
git merge BROKEN_BRANCH_NAME
git push
git branch -D BROKEN_BRANCH_NAME
```

# FAQ

### There are a lot of local branches

To allow for `shinytest` to report the changes it found, new branches are created constantly.  These branches are automatically removed (with CI) after 1 week of no activity.

To remove these dead remotes in your local machine, run:

```bash
git remote prune origin
```

### Workflows and Actions

[**GitHub Actions**](https://github.com/features/actions) is a GitHub service for initiating processes implemented as _workflows_. Workflows are YAML files that indicate a series of programmatic steps to perform.

The workflows that test the Shiny ecosystem are stored in the [`shinycoreci-apps` repo in the .github directory](https://github.com/rstudio/shinycoreci-apps/tree/master/.github/workflows), and their status can be viewed on the [**Actions**](https://github.com/rstudio/shinycoreci-apps/actions) tab of the GitHub website.

Each workflow corresponds to a particular set of tests that apply one particular type of test. `shinytest`, `shinyjstr`, and `testthat` testing strategies each have a corresponding workflow, stored in the `shinycoreci-apps` repo.

All workflows do the following
* Prepare a virtual machine by installing R and required package dependencies
* Eventually gets to a point where it executes shinytest or some other type of test on each example app.
* After tests for all apps have been run, the workflow completes. If the workflow completes successfully, the workflow as a whole is considered "successful" and GitHub displays its run status with a green checkmark.
* If any errors are encountered, the workflow will be considered to have failed, as indicated by a red `X` in the GitHub UI.

When `shinytest` runs a test, it creates png screenshots of what the app currently looks like.

If new screenshots differ from those created previously, the user is presented with the option to accept new screenshots as the correct ones.

### Steps to initiate tests

After cloning the repo, you can initiate a test run either by making a change to an application and pushing the commit, or by using the `shinycoreci::trigger("DISPATCHTYPE", "rstudio/shinycoreci-apps")` function.

> Note: It’s **not** currently possible to initiate a workflow and for that workflow to test a subset of the apps (as opposed to all of them, which is the current default). However, it’s not obvious what the advantage of this would be, considering most of the time spent in the workflow is setup.


### Dependencies

The [`shinycoreci` dependencies](https://github.com/rstudio/shinycoreci/tree/readme#installation) are listed in the DESCRIPTION file. Many of the dependencies are on latest packages from GitHub, and so its set of dependencies is constantly moving forward. This is intentional; it is an attempt to be notified as early as possibly by failures or incompatibilities that might be introduced by new dependencies.

The `shinycoreci-apps` dependencies are automatically inferred using `renv::dependencies()` every time a workflow runs. This step runs after the `shinycoreci` package is installed.

> Note: `renv::dependencies()` are taken from CRAN, not GitHub Remotes.
