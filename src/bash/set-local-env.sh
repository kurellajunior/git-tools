#!/bin/bash
SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")

GIT_TOOLS_PATH=$(cd ${SCRIPT_PATH}/../../; pwd)

if [ ! -e "$HOME/.bash_aliases" ] ; then
	touch ~/.bash_aliases
fi

if ! grep -q ".git_extras" ~/.bash_aliases; then
	cat ${SCRIPT_PATH}/home/.bash_aliases >> ~/.bash_aliases
	echo "## added git extras to alias file"
fi

[ -e "$HOME/.git_extras" ] || \
  ln -s ${SCRIPT_PATH}/home/.git_extras ~/.git_extras
[ -e "$HOME/.local/opt/git_extras_functions" ] || \
  ln -s ${SCRIPT_PATH}/home/.local/opt/git_extras_functions ~/.local/opt/git_extras_functions

for FILE in $(ls ${SCRIPT_PATH}/home/.local/bin)
do
	LINK_START=~/.local/bin/$FILE
	[ -e "${LINK_START}" ] || \
		ln -s "${SCRIPT_PATH}/home/.local/bin/${FILE}" "${LINK_START}"
done
