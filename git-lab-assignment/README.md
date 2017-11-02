# Git Lab Assignment [![Build Status](https://travis-ci.org/slackboxster/git-lab-assignment.svg?branch=master)](https://travis-ci.org/slackboxster/git-lab-assignment)

This assignment will give you a chance to apply your git skills and stretch them a good deal. It is based on the [ChurchConnect Mobile App](https://github.com/churchconnect/mobile-app).

Create a fork of the repository in your own github account, and follow the instructions below.

# Automated Grading

The assignment consists of a series of tasks. After each task, you can run the test script: "./git-assignment-tests.sh" to see if you have successfully completed that task. However, the project is also configured to allow automatically running the tests with Travis CI after each push of the `master` branch. 

In order to receive a grade for the assignment, you will need to set up a travis-ci build for your fork, and modify the build status badge to point to your travis build.

To set up Travis CI for your repository:

* Sign in to [Travis CI .org](https://travis-ci.org/auth) with your github account.
* Once Travis has synchronized your GitHub repositories, go to your [Travis Profile Page](https://travis-ci.org/profile/), select the `git-lab-assignment` repository and enable it.
* The repository already contains a `.travis.yml` file, so you don't need to worry about that.
* Once you push up your first commit on the `master` branch, you should be able to see travis working.
* When you look at the page for your git-lab-assignment Travis build, you should see a build status badge that looks like the one at the top of this repository.
    * Click on that build status badge
    * Choose the master branch from the first dropdown.
    * Choose Markdown from the second dropdown
    * copy the code sample that results and replace the build status code in this file with the code from your travis account.
* Note that only the master branch is guaranteed to have the correct configuration for the travis build. Some of the other branches have the old travis configuration from the Church Connect repo on which I based this assignment. So if your tests don't seem right, or you see npm tasks running, change the `version.txt` file on the `master` branch and push up that change to trigger a build on the master branch, which will in turn run the tests on your repository.

# Notes

* If you encounter conflicts during any merges or rebases or cherry picks, just make up the resolution as best you can. Since you don't understand the code, it will be hard to accurately resolve the conflicts. But you're being graded on your git work, not the coding, so just make sure the git actions work out.
* Make sure not to change these files on the master branch: (If you do clobber them, just download them from this repository and recommit them to master)
    * The `README.md` file
    * The `.travis.yml` file
    * The `git-assignment-tests.sh` file
* The following git alias will make inspecting the logs much easier:
    * Configure the alias with the following command: `git config --global alias.lp 'log --oneline --graph --all'`
    * Use `git lp` to get a more useful and powerful log output. :)
* If you get stuck with a rebase, `git rebase --abort` will let you start over.
* If you get stuck with a merge, `git merge --abort` will clear out all the changes and let you start over.

# Tasks

## Task 1:

* There is a password commited at the beginning of the `task-1` branch. That commit needs to be completely removed.
* Remove that commit using either the rebase or the cherry pick approach from this website: https://www.clock.co.uk/insight/deleting-a-git-commit
    * the rebase approach command example reads as such: `git rebase --onto <branch name>~<first commit number to remove> <branch name>~<first commit to be kept> <branch name>`
    * another way to say it is `git rebase --onto <new source commit> <old source commit> <branch you are rebasing>`
    * another way is: `git rebase --onto <commit hash before the password commit> <commit hash after the password commit> <branch you are removing the password from>`
* Once you are done removing the commit, use the force to push your changes: `git push -f origin task-1`
* Notes and hints:
    * When you do git log, you hit `/` to search for words. So `/password` should find you the commit containing the password. 
    * You can also use `git log | grep 'password'` to find the commit hash.
    * Note: pay close attention to the output of the rebase command and the output of git status when it hits a stopping point. Most of the time git tells you what you need to do next.
* If you get stuck with a rebase, `git rebase --abort` will let you start over.

# Task 2:

* the last two commits on the `task-2` branch need to be removed.
* use the `git reset` command to remove the two commits (google should help you figure out the precise options to use to remove the two commits).
* Once you are done, use the force to push your changes.

# Task 3:

* checkout the commit with this message: "object caching on the client side!" and create the branch `task-3` from that commit.
* push up the new `task-3` branch. This will require setting the upstream branch, but git will help you with the command to do that.

# Task 4:

* on the `task-4` branch, somebody introduced a bug in the commit with the message "In the real world, bugs wouldn't be this hard to find." (I know, it really should say "this easy"... but I must have been tired when I wrote that ;) ).
* Use the `git revert` command to reverse the effects of that commit. 
* Push up the new commit.

# Task 5:

* merge the `task-5-feature` branch into the `task-5` branch
    * things to remember:
        * make sure you are on the branch that you are merging into (use `git checkout` to get onto it, `git status` to check which branch you are on).
        * the argument to `git merge` is the branch that you will be merging from.
* There will be some conflicts in this merge. This is to help you get comfortable with merge conflicts. Feel free to make it up as you go along, EXCEPT for the `random_conflict` file.
    * The `random_conflict` file should come out of the merge with all its steps in order.
* If you get stuck with a merge, `git merge --abort` will clear out all the changes and let you start over.
* Once done, push up the `task-5` branch.

# Task 6:

* there is a commit on the `master` branch with the commit message `Cherry Pick this commit in Task 6`.
* Cherry pick this commit onto the `task-6` branch and push the commit up.

# Task 7:

* on the `task-7` branch, checkout the file `specific_file` from the earlier commit on the same branch with the message: `Add a specific file to be checked out later.`
* add and commit that version at the head of the `task-7` branch, then push up the changes.

# Submitting the assignment

When you are done, add "-- Finished!" to the title of the `README.md` file on the `master` branch and email me the link to the repository at ryan+git2017@sharptop.io, and CC Dr Shaneck on the email. 

This final push will trigger travis to build the master branch one last time, which will make sure your build status badge shows a passing build. :)

Even if you don't finish all the tasks, at least try to finish some of them.

# Git Resources:

* Potentially Useful Commands:
    * `git annotate <file>`: shows who committed each line of the file and when. Useful for blaming someone else for creating a bug.
    * `git add -i`: Interactive adding mode -- enables selectively adding changes to the repository.
    * `git stash`: the stash is a very useful thing for keeping changes while you quickly do something else with the repository.

* Reference Materials:
    * [The Git Book](https://git-scm.com/book/en/v2)
    * [An in depth git cheat sheet](http://ndpsoftware.com/git-cheatsheet.html)
    * [StackOverflow's frequently asked git questions](https://stackoverflow.com/questions/tagged/git?sort=frequent&pageSize=50)

* Videos:
    * [Linus Torvalds talking to Google](https://www.youtube.com/watch?v=4XpnKHJAok8)
    * [Scott Chacon (author of the git book) explains git in a very accessible way](https://www.youtube.com/watch?v=ZDR433b0HJY)

* Tutorials:
    * [Github's online emulator and tutorial](https://try.github.io/levels/1/challenges/1)
    * [Atlassian's Git Tutorials](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)


* Other interesting resources:
    * [The Git Parable explains how git works in normal computer terms](http://tom.preston-werner.com/2009/05/19/the-git-parable.html)
    * [My "Build your own VCS" challenge, based loosely on the Git Parable](http://ryanheathcote.com/git/build-your-own-vcs)
    * [Some interesting visual explanations of git](http://marklodato.github.io/visual-git-guide/index-en.html)
    * [First Time Setup Instructions](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)
    * [How to remove a commit](https://www.clock.co.uk/insight/deleting-a-git-commit)
    * [In depth on rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
    * [How to create a merge conflict](https://jonathanmh.com/how-to-create-a-git-merge-conflict/)
