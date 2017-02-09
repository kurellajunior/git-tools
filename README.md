# git-tools

A compilation of support scripts for the work with git

## tools

### status dir?

shows current status for all git reposs in directory. Status is the same as
the prefix from `.git_extras`.

### fetchall dir?

fetches all git repositories in the provided folder, takes current directory
if no argument is given. provides nice overview output of status of all repos
(see status).

### pullall dir?

Rebases all checked out branches of all git repositories in the provided
directory. The provided dir can be a git repository itself.

Uncommitted changes will prevent any rebase, rebase conflicts need to be
solved manually.

### mergeAsBranch

Instead of commiting all current commits fast forward in a row after a
succesful rebase, this command commits as forced merge, so it is easy to see,
which commits belong to each other in history.

You are requested to enter a nice commit message for your feature

Before

```
    ,–origin/master
    |       ,–master
    |       |
A-B-C-D-E-F-G
```

mergeAsBranch
```
    ,–origin/master
    |         ,–master
    |         |
A-B-C---------H
     \       /
      D-E-F-G
```

### rebase-but-on branch?

sometimes you have local changes due to a poor setup, that you do not want to
push. This script allows for interactively skipping specific commits from the
start of your history to prevent them from being pushed.

Before

```
    ,–origin/master; master
    |       ,–development
    |       |
A-B-C-X-D-E-F
```

rebase-but-on master
```
    ,–origin/master;
    |     ,–master
    |     | ,–development
A-B-C-D-E-F-X
```
of course these are all new commits, due to the rebasing

## Skripte

### src/bash/init-repository.sh

This script will be used on the remote server to cleanly initialize a git
repository with an empty commit and initial files.
  * Run with root privileges on remote machine.
  * accepts one parameter as repository name
    * subfolders are allowed
    * name will be postfixed with .git, if not present

### src/bash/set-local-env.sh
  
little utility script to set up local aliases for git console enhancement.

it will prepend the console by time and branch name, with the branch name
surrounded by brackets Supports german and english localization of git. It
will color code the branch name of a current git repository:

  * red: modified local files
  * purple: all changes staged but new files exists
  * orange: all changes staged 
  * cyan: no changes but new files exist
  * green: all commited

The character before the branch indicates local state, right of it remote state:

  * ^ new commits exist on the other end
  * | all commits synced


