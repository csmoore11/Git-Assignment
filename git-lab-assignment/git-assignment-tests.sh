#!/bin/bash

tests=0
passes=0
fails=0

echo_with_color ()
{
    tput setaf $1
    echo "$2"
    tput sgr0
}

pass ()
{
    #echo "$1 ... [PASS]"
    echo_with_color 2 "$1 ... [PASS]"
    ((tests++))
    ((passes++))
}

fail ()
{
    #echo "$1 ... [FAIL]"
    echo_with_color 1 "$1 ... [FAIL]"
    ((tests++))
    ((fails++))
}

# Checkout all the branches so that they are local in the clone
git checkout task-1
git checkout task-2
git checkout task-3
git checkout task-4
git checkout task-5
git checkout task-5-feature
git checkout task-6
git checkout task-7
git checkout master

# Test Task 1
test="Task 1: password has been removed from the repository."
if git log --oneline --all | grep 'password'; then fail "$test"; else pass "$test"; fi

# Test Task 2
test="Task 2: the bad file has been removed from the repository"
git checkout task-2
if [ -e task2.txt ]; then fail "$test"; else pass "$test"; fi
git checkout master

test="Task 2: the bad commits have been removed from the repository"
if git log --oneline --all | grep 'two commits that should not be on task-2'; then fail "$test"; else pass "$test"; fi

# Test Task 3:
test="Task 3: the branch has been created from the commit with the message 'object caching on the client side!'"
if git branch -av | grep 'task-3' | grep 'object caching on the client side!'; then pass "$test"; else fail "$test"; fi

# Test Task 4:
test="Task 4: the bug has been reverted"
if git branch -av | grep 'task-4' | grep 'Revert "In the real world, bugs wouldn.t be this hard to find."'; then pass "$test"; else fail "$test"; fi

test="Task 4: the buggy file has been removed"
git checkout task-4
if [ -e bug.txt ]; then fail "$test"; else pass "$test"; fi
git checkout master

# Test Task 5:
test="Task 5: the task-5-feature branch has been merged into the task-5 branch"
if git branch --merged task-5 | grep 'task-5-feature'; then pass "$test"; else fail "$test"; fi

test="Task 5: the random_conflict file still exists"
git checkout task-5
if [ -e "random_conflict" ]; then pass "$test"; else fail "$test"; fi

test="Task 5: the steps in random_conflict are correctly ordered."
git checkout task-5
cat <<EOF > correct_resolution
This is a file that will have some random conflicts. Make sure the block of code below has a normal flow.

Code:
- step 1
    - step 1a
    - step 1b
    - step 1c
- step 2
    - step 2a
    - step 2b
- step 3
- step 4
- step 5
EOF
if diff correct_resolution random_conflict; then pass "$test"; else fail "$test"; fi
rm correct_resolution
git checkout master

# Test Task 6:
test="Task 6: the correct commit has been cherry picked"
if git branch -av | grep 'task-6' | grep 'Cherry Pick this commit in Task 6'; then pass "$test"; else fail "$test"; fi

# Test Task 7:
test="Task 7: the original version of specific_file has been checked out and added to the task-7 branch."
git checkout task-7
cat <<EOF > correct_specific_file
This version of the file must be checked out.
EOF
if diff specific_file correct_specific_file; then pass "$test"; else fail "$test"; fi
rm correct_specific_file
git checkout master

#Example conditions:
#check for existence of a directory
#if [ -d test3/.repo ]; then pass "$test" ; else fail "$test"; fi
#
#check for existence of a file
#if [ -e .repo/snapshots/1/hello.txt ]; then pass "$test"; else fail "$test"; fi
#
#grep for text in a file.
#if grep "`whoami`" .repo/snapshots/3/.commit; then pass "$test"; else fail "$test"; fi
#
#grep for text in output of command
#test="Test: vcs-log.sh shows the commit files from the snapshots folder."
#if vcs-log.sh | grep "$message"; then pass "$test"; else fail "$test"; fi
#
#check if script exits with 0 or not.
#if vcs-tag.sh blaa blaa; then fail "$test"; else pass "$test"; fi
#
#check if file is a symbolic link
#if [ -L ".repo/refs/tags/blaa" ]; then pass "$test"; else fail "$test"; fi
#
#check the target of a symbolic link.
#if ls -al .repo/refs/tags/blaa | grep "> .repo/snapshots/1"; then pass "$test"; else fail "$test"; fi

echo "======================================================================"
if [ "$fails" -eq "0" ]; then
    echo_with_color 2 "All Tests Passed!"
else
    echo_with_color 1 "Tests completed with $fails tests failing."
    exit 1
fi
