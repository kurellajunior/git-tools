#!/bin/bash

RepositoryLocation=/git/$1
if [ "${RepositoryLocation}" == "/git/" ]; then
    echo "No repository name given"
    exit 2
fi
[[ ${RepositoryLocation} != *.git ]] &&	RepositoryLocation=${RepositoryLocation}.git
TempRepoName=/tmp/git-init-${BASHPID}
GitToolsRepo=~git/git-tools

# get the right user
su -s /bin/bash git - << END_OF_SCRIPT

# create repo
git init --bare "${RepositoryLocation}"

# refresh git tools
echo "using git tools at »$GitToolsRepo«"
if [ ! -d "$GitToolsRepo" ]; then
	git clone /git/satis/git-tools.git $GitToolsRepo &>/dev/null
fi
cd $GitToolsRepo
git reset --hard HEAD  &>/dev/null
git checkout master    &>/dev/null
git pull origin master &>/dev/null
cd -

echo initialize the new repo
git clone "${RepositoryLocation}" ${TempRepoName} &>/dev/null
cd ${TempRepoName}
git config user.name "Git Server Bot"
git config user.email "user@company.com"
git commit --allow-empty -m "initial empty commit" &>/dev/null

cp $GitToolsRepo/templates/README.md.template README.md
cp $GitToolsRepo/.gitignore .
cp $GitToolsRepo/.gitattributes .
git add .
git commit -m "adding readme gitignore and gitattributes" &>/dev/null
git push origin master:master &>/dev/null

cd -
rm -rf ${TempRepoName}

END_OF_SCRIPT

exit 0