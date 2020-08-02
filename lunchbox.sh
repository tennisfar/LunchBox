LUNCHBOX="/Users/mlp/Lunchbox"
REP="/Users/mlp/_rep"

# Not on OSX
if [[ $(uname -s) != Darwin ]]
then
  LUNCHBOX="/c/Projects/rep/Lunchbox"
  REP="/c/Projects/rep"

  # Pretty
  alias ll='ls -lhF --color --group-directories-first'
  alias ls='ls -hF --color --group-directories-first'
  
  # Paths
  export PATH="$LUNCHBOX:$PATH"
  export PATH="$HOME/AppData/Roaming/npm:$PATH"
  export PATH="$HOME/.windows-build-tools-python27:$PATH"
  export PATH="/c/Program Files/KDiff3:$PATH"
fi

# LUNCHBOX
alias box="cd $LUNCHBOX"
alias br="source $LUNCHBOX/lunchbox.sh ; echo --- reloaded" # Update everything
alias brp='box && git pull && cd - ; echo --- lunchbox up to date'
brp # update lunchbox, also to avoid conflicts when running brs

alias boxbackup='boxbackup'
boxbackup() {
	if [[ $(uname -s) != Darwin ]] 
  then
    echo --- backup windows
    cp $APPDATA/Code/User/settings.json $LUNCHBOX/VSCode/Windows/settings.json
  else 
    echo --- backup osx
  fi
}

alias brx='brx'
brx() {
  box

	if [[ $(uname -s) != Darwin ]] 
  then
    echo --- backup windows
    cp $APPDATA/Code/User/settings.json $LUNCHBOX/VSCode/Windows/settings.json
  else 
    echo --- backup osx
  fi

  git add -A
  git commit -m "brs updates"
  c
  gitadded
  git push
  cd -
}

alias brs='box ; boxbackup ; git add -A ; git commit -am "brs updates" ; c ; gitadded ; git push ; cd -'
alias vial='vi $LUNCHBOX/lunchbox.sh' # vi aliases

# Shortcuts
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias findinfiles='find . -type f -print | xargs grep $1'
alias rep="cd $REP"

# GIT
alias sumo="git remote -v && echo git remote set-url origin https://gitlab.com/hpm/REPOSITORY.git" # Update git remote to GitLab
alias fo='gitFetchAndCheckoutBranch'
gitFetchAndCheckoutBranch() {
	git fetch
	git checkout $1
}
alias gitrecent='git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias gitfix='git gc --prune=now'
# show files committed
alias gitadded='git show --stat --oneline HEAD'
alias gs='git status'

alias npmglob='npm list -g --depth=0'
alias killnode='taskkill -F -IM node.exe'
alias prettyhere='cp $LUNCHBOX/DotFiles/.prettierrc .'

### DOCKER
alias deletealldockerimages='docker rmi $(docker images -q)'
alias locserver='python -m SimpleHTTPServer 8005'



# DS
PATH_DS='/c/Projects/ds/develop'
alias ds='cd $PATH_DS'
alias dlo='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dlo && ds'
alias dli='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dli && ds && git checkout -- Website/Components/DanskeSpil/Framework/PlayerAccountManagement/Include/zzz.DanskeSpil.Framework.PlayerAccountManagement_local.config'
# merge latest updates from pam-n-sub into current branch
alias gitpam='git fetch && git merge origin/pam-n-sub'
# merge latest updates from specific release branch into current branch
alias gitrel='gitRel'
gitRel() {
	git fetch
	git merge origin/release/DS-$1
}
# check out pam-n-sub
alias pns='fo pam-n-sub ; git pull'
alias today='c;ds;echo " Since midnight:"; git log --committer=ekmlpe@danskespil.dk --since=00:00:00 --all --no-merges --pretty=format:"%<(20) %ar %s" ; echo ; cd -'
alias yesterday='c;ds;echo " Since early morning yesterday:"; git log --committer=ekmlpe@danskespil.dk --since="yesterday" --until=00:00:00 --all --no-merges --pretty=format:"%<(20) %ar %s" ; echo ; cd -'
alias myremotebranches='git for-each-ref --format=" %09 %(authordate:short) %09 %(authorname) %09 %(refname)" --sort=-authordate | grep Michael | grep refs/remotes | grep -n " " | sed "s@refs/remotes/origin/@@g" | sed "s@Lothar@L@g"'
alias gitup='git fetch origin ; git branch -v -a'
alias gitlatestrels='git fetch --dry-run --quiet && git for-each-ref | grep release/DS- | sed "s@.*.commit.refs/remotes/origin/release/@@g" | tail -5'
alias jira='node c:/Projects/jira-cli/create-issue.js'
alias is='iisreset'
alias w='gulp watch'
alias g='gulp'
alias gw='gulp && gulp watch'
alias gwf='gulp clean && gulp styles && gulp bundle && gulp watch'
alias gl='gulp lint && gulp stylelint'
alias gw-bingo='gulp && gulp watch --theme Bingo'
alias gw-casino='gulp && gulp watch --theme Casino'
alias gw-danskespil='gulp && gulp watch --theme DanskeSpil'
alias gw-spillehjoernet='gulp && gulp watch --theme Spillehjoernet'
alias sitetail='node /c/Projects/sitecoretail/index.js'

# Find breakpoints in DS
alias breakpoints="grep -Ehr '^@.*:.*[0-9]{3,}px;' Website/Components/DanskeSpil/"

# Find breakpoints in DS, save to file
alias breakpoints-to-file="c;ds; breakpoints | grep -Eo '[0-9]{3,4}' > ../breakpointvalues.txt"

# https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
alias gitstat='echo --- Commits in 2018: ; git shortlog -sn --all --no-merges --since="2018-01-01"'
alias gitoverview='git log --all --since="yesterday" --oneline --no-merges'
alias gitrecap='git log --all --oneline --no-merges --author=ekmlpe@danskespil.dk'
alias gittoday='git log --since=00:00:00 --all --no-merges --oneline --author=ekmlpe@danskespil.dk'
alias gitwhattoday='git shortlog --all --no-merges --since="00:00:00"'
alias gitbranchlastupdate='git for-each-ref --sort=committerdate refs/heads/ --format="%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)"'
