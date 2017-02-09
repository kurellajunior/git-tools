# git-tools

A compilation of support scripts for the work with git

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


