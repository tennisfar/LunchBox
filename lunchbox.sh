# Default OSX paths
LUNCHBOX="/Users/mlp/_rep/Lunchbox"
REP="/Users/mlp/_rep"
EMAIL="ekmlpe@danskespil.dk"

if [[ $(uname -s) != Darwin ]]; then # Windows
  # Overwrite default OSX paths
  LUNCHBOX="/c/Projects/rep/Lunchbox"
  REP="/c/Projects/rep"

  # Pretty output in Windows like on OSX
  alias ll='ls -lhF --color --group-directories-first'
  alias ls='ls -hF --color --group-directories-first'

  # More paths, Windows specific
  export PATH="$LUNCHBOX:$PATH"
  export PATH="$HOME/AppData/Roaming/npm:$PATH"
  export PATH="/c/Python27:$PATH"
  export PATH="$HOME/.windows-build-tools-python27:$PATH"
  export PATH="/c/Program Files/KDiff3:$PATH"
  export PATH="/c/Webdriver:$PATH"
  export PATH="$HOME/.nvm:$PATH"
else
  alias ll='ls -lhF'
  alias ls='ls -hF1'
  alias brewuninstall='brew uninstall $1'
  alias brewupdate='brew update'
  alias brewupgrade='brew upgrade'
  alias brewcleanup='brew cleanup'
  alias brewdoctor='brew doctor'
  source $LUNCHBOX/.Secret/environment-variables.sh
fi



### LUNCHBOX
alias box="cd $LUNCHBOX"

# Update Lunchbox with latest from Git repository
alias brp='box && git pull && cd -'
# Update when terminal opens
brp

# Backup Lunchbox and other files
fn_brs() {
  box

  if [[ $(uname -s) != Darwin ]]; then
    echo --- backup windows
    cp $APPDATA/Code/User/settings.json $LUNCHBOX/VSCode/Windows/settings.json
  else
    echo --- backup osx
  fi

  git add -A
  git commit -m ":package:"
  gitadded
  git push
  cd -
}
alias brs='fn_brs'
alias br="source $LUNCHBOX/lunchbox.sh ; fn_brs; echo --- reloaded" # Update everything
alias brf="source $LUNCHBOX/lunchbox.sh ; echo --- reloaded fast" # Update everything

# Update Github Assets
up_ass() {
  cd /c/Projects/rep/assets
  git add -A
  git commit -m ":package:"
  git show --stat --oneline HEAD
  git push
  cd -
}

alias upass='up_ass'

# Quick edit this page
alias vial='vi $LUNCHBOX/lunchbox.sh'

# Shortcuts
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias findinfiles='find . -type f -print | xargs grep $1'
alias rep="cd $REP"


### BROWSERSYNC

brows_sync() {
  # https://browsersync.io/docs/command-line
  cd $PATH_DS
  browser-sync start --proxy 'https://web.develop.danskespil.dk' --files './Website/BuildArtifacts/Components/DanskeSpil/**/*.css' './Website/BuildArtifacts/Components/DanskeSpil/**/*.js' './Website/BuildArtifacts/Components/Shared/Framework/Ensighten/**/*.js' --no-notify --open external --no-ghost-mode --no-ui
}
alias bs='brows_sync'


### GIT
# Update git remote to GitLab
alias sumo="git remote -v && echo git remote set-url origin https://gitlab.com/hpm/REPOSITORY.git"
alias fo='gitFetchAndCheckoutBranch'

gitFetchAndCheckoutBranch() {
  git fetch
  git checkout $1
}

alias gitrecent='git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias gitfix='git gc --prune=now'
# Show files committed
alias gitadded='git show --stat --oneline HEAD'
alias gs='git status'
alias gitpu='git add -A && git commit -m ":package:" && git push'

function cherryPickToNewBranchOLD() {
    # $1 is the name of the new branch
    # $2 is the SHA of the commit to cherry-pick

    # Fetch the latest state of your remote repository
    echo "Fetching the latest state of your remote repository"
    git fetch origin

    # Create a new branch from origin/main without checking it out
    echo "Creating a new branch $1 from origin/main without checking it out"
    git branch $1 origin/main

    # Cherry-pick the commit into the new branch
    echo "Cherry-picking the commit into $1"
    git rev-parse $2 | git commit-tree -p $1 -F - | xargs git update-ref refs/heads/$1

    # Push the new branch to the remote repository
    echo "Pushing the new branch $1 to the remote repository"
    git push origin $1
}



function cherryPickToNewBranch() {
    # $1 is the name of the new branch
    # $2 is the SHA of the commit to cherry-pick

    # Fetch the latest state of your remote repository
    echo "Fetching the latest state of your remote repository"
    git fetch origin

    # Check if the branch already exists
    if git show-ref --verify --quiet refs/heads/$1; then
        echo "Branch $1 already exists, deleting it first"
        git branch -D $1
    fi

    # Create a new branch from origin/main and check it out
    echo "Creating and checking out a new branch $1 from origin/main"
    git checkout -b $1 origin/main

    # Cherry-pick the commit into the new branch
    echo "Cherry-picking the commit into $1"
    git cherry-pick $2

    # Push the new branch to the remote repository
    echo "Pushing the new branch $1 to the remote repository"
    git push origin $1
}




### DOCKER
alias deletealldockerimages='docker rmi $(docker images -q)'
alias locserver='python -m SimpleHTTPServer 8005'



### DS
PATH_DS='/c/Projects/ds/develop'
alias ds='cd $PATH_DS'
alias dlo='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dlo && ds'
alias dli='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dli && ds && git checkout -- Website/Components/DanskeSpil/Framework/PlayerAccountManagement/Include/zzz.DanskeSpil.Framework.PlayerAccountManagement_local.config'

# Run today
alias runtoday01='cd /c/Projects/ds/ds-e2e && npm run test:develop:components:dlo'
alias runtoday='runtoday01'

# DS Compare screenshots
alias compare='ds && .. && cd ds-compare-screenshots && npm start && cd ./output && explorer .'

# merge latest updates from pam-n-sub into current branch
alias gitmain='git fetch && git merge origin/main'
alias gittc='git fetch && git merge origin/master'
alias gitfp2='git fetch && git merge origin/feature/FP-2'

# merge latest updates from specific release branch into current branch
alias gitrel='gitRel'
gitRel() {
  git fetch
  git merge origin/release/DS-$1
}


# rm -rf bash command
rmfFn() {
  rm -rf $1
}
alias rmf='rmfFn'


alias ejp='git fetch && git merge origin/feature/EurojackpotVersion2'

alias gitcomparerel='gitCompareRel'
gitCompareRel() {
  git fetch
  git log --oneline --no-merges --author=ekmlpe origin/release/DS-$1..
}

alias gitcomparewith='gitCompareWith'
gitCompareWith() {
  git fetch
  git log --oneline --no-merges --author=ekmlpe origin/$1..$2
}

alias bygds='ds; rm Website/obj -r ; cd - > null ; echo Removed obj folder'


# Hours
alias timelog='ds;echo " Hours:"; git log --committer=ekmlpe@danskespil.dk --since="1 week ago" --all --no-merges --date=format:"%a %d/%m %H:%M" --pretty=format:"%<(20) %ad %s" ; echo ; cd -'
alias hours='timelog'

# Check out
alias today='ds;echo " Since midnight:"; git log --committer=ekmlpe@danskespil.dk --since=00:00:00 --all --no-merges --pretty=format:"%<(20) %ar %s" ; echo ; cd -'
alias today2='ds;echo " Since midnight:"; git log --committer=@EMAIL --since=00:00:00 --all --no-merges --pretty=format:"%<(20) %ar %s" ; echo ; cd -'
alias yesterday='ds;echo " Since early morning yesterday:"; git log --committer=ekmlpe@danskespil.dk --since="yesterday" --until=00:00:00 --all --no-merges --pretty=format:"%<(20) %ar %s" ; echo ; cd -'
alias myremotebranches='git for-each-ref --format=" %09 %(authordate:short) %09 %(authorname) %09 git push origin --delete %(refname)" --sort=-authordate | grep Michael | grep refs/remotes | grep -n " " | sed "s@refs/remotes/origin/@@g" | sed "s@Lothar@L@g"'
alias gitup='git fetch origin ; git branch -v -a'
alias gitlatestrels='git fetch --dry-run --quiet && git for-each-ref | grep -E ".*release/DS-[0-9]{3}.*" | sed "s@.*.commit.refs/remotes/origin/release/@@g" | tail -5'
alias w='gulp watch'
alias g='gulp'
alias gw='gulp && gulp watch'
alias gl='gulp lint && gulp stylelint'
alias gw-bingo='gulp && gulp watch --theme Bingo'
alias gw-casino='gulp && gulp watch --theme Casino'
alias gw-danskespil='gulp && gulp watch --theme DanskeSpil'
alias gw-spillehjoernet='gulp && gulp watch --theme Spillehjoernet'
alias gitem2021='git fetch && git pull origin feature/IU-15932-em-content-hub-v3'

# Find breakpoints in DS
alias breakpoints="c; ds; grep -Ehr '^@.*:.*[0-9]{3,}px;' Website/Components/DanskeSpil/"

# Find breakpoints in DS, save to file
alias breakpoints-to-file="c; ds; breakpoints | grep -Eo '[0-9]{3,4}' > ../breakpointvalues.txt"



### OTHER
alias npmglob='npm list -g --depth=0'
alias killnode='taskkill -F -IM node.exe'
alias pretty='npx prettier . --write'
alias prettyhere='cp $LUNCHBOX/DotFiles/.prettierrc . ; pretty'
alias sitetail='node /c/Projects/rep/SiteTail/index.js'
alias is='iisreset /timeout:0 > null ; iisreset'



### RANDOM
# Utils from https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
alias gitstat='echo --- Commits in 2018: ; git shortlog -sn --all --no-merges --since="2018-01-01"'
alias gitoverview='git log --all --since="yesterday" --oneline --no-merges'
alias gitrecap='git log --all --oneline --no-merges --author=ekmlpe@danskespil.dk'
alias gittoday='git log --since=00:00:00 --all --no-merges --oneline --author=ekmlpe@danskespil.dk'
alias gitwhattoday='git shortlog --all --no-merges --since="00:00:00"'
alias gitbranchlastupdate='git for-each-ref --sort=committerdate refs/heads/ --format="%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)"'


