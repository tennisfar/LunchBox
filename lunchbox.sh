# Default OSX settings
LUNCHBOX="/Users/mlp/_rep/Lunchbox"
REP="/Users/mlp/_rep"
# PATH_DS='/c/Projects/ds/danskespil-website'
# PATH_DS='/c/Projects/ds/develop'
PATH_DS='/c/Projects/ds/trunk'
EMAIL="ekmlpe@danskespil.dk"

if [[ $(uname -s) != Darwin ]]; then # Windows
  # Overwrite default OSX settings to Windows settings
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
  # OSX settings:
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

# Synchronize Lunchbox with origin
synclunchbox() {
  box 
  git fetch
  git pull > /dev/null
  cd - > /dev/null || exit
}
# Run whenever a new terminal opens
synclunchbox

# Backup Lunchbox and other files
fn_brs() {
  box

  if [[ $(uname -s) != Darwin ]]; then
    # backup windows
    cp $APPDATA/Code/User/settings.json $LUNCHBOX/VSCode/Windows/settings.json
  else
    # backup osx
    true
  fi

  git add -A > /dev/null
  git commit -m ":package:" > /dev/null
  gitadded
  git push
  cd - > /dev/null || exit
}
alias brs='fn_brs'

br() {
  # Update Bash and repository
  source $LUNCHBOX/lunchbox.sh > /dev/null
  fn_brs
  echo; echo --- Bash reloaded, Lunchbox changes saved to origin
}

brf() {
  # Update Bash, don't save changes to repository
  source $LUNCHBOX/lunchbox.sh > /dev/null
  echo; echo --- Bash reloaded  
}

# Update Github Assets
upass() {
  cd /c/Projects/rep/assets
  git add -A
  git commit -m ":package:"
  gitadded
  git push
  cd - > /dev/null || exit
}

# Handy shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias ds='cd $PATH_DS'
alias rep="cd $REP"

# Quick edit this page (vial: VIm ALiases)
alias vial='vi $LUNCHBOX/lunchbox.sh'
alias vialc='code $LUNCHBOX/lunchbox.sh'

# Search for a specified string in all files within the current directory. Example: findinfiles hello
findinfiles() {
  find . -type f -print0 | xargs -0 grep -H "$1" | awk -F: '{print $1 "    " $2}'
}

# Starts BrowserSync to watch and reload files for https://web.develop.danskespil.dk:3000, useful for live reloading during web development
# Reference: https://browsersync.io/docs/command-line
bs() {
  cd $PATH_DS
  echo "Open https://web.develop.danskespil.dk:3000"; echo;
  browser-sync start --proxy 'https://web.develop.danskespil.dk' --files './Website/Views/**/*.cshtml' './Website/Components/DanskeSpil/Domain/Feature.Navigation/**/*.js' './Website/Components/DanskeSpil/Domain/Feature.Navigation/**/*.js' './Website/Components/DanskeSpil/Domain/Feature.Navigation/**/*.css' './Website/BuildArtifacts/Components/DanskeSpil/**/*.css' './Website/BuildArtifacts/Components/DanskeSpil/**/*.js' './Website/BuildArtifacts/Components/Shared/Framework/Ensighten/**/*.js' --no-notify --open external --no-ghost-mode --no-ui  
}

# Git fetch and checkout branch. Example: fo origin/main
fo() {
  git fetch
  git checkout $1
}

gitrecent() {
  echo; echo "Listing the 10 most recently updated local git branches:"; echo "--------------------------------------------------------";
  git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"
}

alias gitfix='git gc --prune=now'
# Show files committed
alias gitadded='git show --stat --oneline HEAD'
alias gs='git status'
alias gitpu='git add -A && git commit -m ":package:" && git push'

### SwitchDliDlo shortcuts
alias dlo='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dlo && ds'
alias dli='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dli && ds && git checkout -- Website/Components/DanskeSpil/Framework/PlayerAccountManagement/Include/zzz.DanskeSpil.Framework.PlayerAccountManagement_local.config'

# Merge latest updates from main into current branch
alias gitmain='git fetch && git merge origin/main'

# Merge latest updates from specific release branch into current branch. Example: gitrel 250
gitrel() {
  git fetch;
  git merge origin/release/DS-"$1";
}

# Deletes a file or directory forcefully. Example: rmf test
rmf() {
  rm -rf "$1"
}

gitcomparerel() {
  git fetch
  git log --oneline --no-merges --author=ekmlpe origin/release/DS-$1..
}

gitcomparewith() {
  git fetch
  git log --oneline --no-merges --author=ekmlpe origin/$1..$2
}

alias bygds='ds; rm Website/obj -r ; cd - > null ; echo Removed obj folder'

# Displays git log for the specified committer over the past two weeks
hours() {
  ds
  echo; echo "Commits over the past two weeks:"; echo ---------------------------------
  git log --committer=$EMAIL --since="2 weeks ago" --all --no-merges --date=format:"%a %d/%m %H:%M" --pretty=format:"%<(20) %ad %s"
  cd - > /dev/null || exit
}

# Displays git log for the specified committer since midnight
today() {
  ds
  echo; echo "Commits since midnight:"; echo -----------------------
  git log --committer=$EMAIL --since=00:00:00 --all --no-merges --pretty=format:"%<(20) %ar %s"
  cd - > /dev/null || exit
}

#myremotebranches() {
#  git for-each-ref --format=" %09 %(authordate:short) %09 %(authorname) %09 git push origin --delete %(refname)" --sort=-authordate | grep Michael | grep refs/remotes | grep -n " " | sed "s@refs/remotes/origin/@@g" | sed "s@Lothar@L@g"
#}

alias gitup='git fetch origin ; git branch -v -a'

# Lists the most recent DS release branches
gitreleases() {
  echo; echo The most recent release branches:; echo ---------------------------------
  ds
  git fetch --dry-run --quiet 
  git for-each-ref | grep -E ".*release/DS-[0-9]{3}.*" | sed "s@.*.commit.refs/remotes/origin/release/@@g" | tail -5  
}
alias latestrel='gitreleases'
alias w='gulp watch'
alias g='gulp'

alias gw='npm run build && npm run build:v2 && npm run build:v2:watch'
alias gwOLD='gulp && npm run build:v2 && gulp watch'

alias gw2='gulp && npm run build:v2 && gulp watch'
alias gl='gulp lint && gulp stylelint'
alias gw-bingo='gulp && gulp watch --theme Bingo'
alias gw-casino='gulp && gulp watch --theme Casino'
alias gw-danskespil='gulp && gulp watch --theme DanskeSpil'
alias gw-spillehjoernet='gulp && gulp watch --theme Spillehjoernet'

alias prodapi='rep ; cd prod-to-local-api ; npm start'

# Find breakpoints in DS
alias breakpoints="c; ds; grep -Ehr '^@.*:.*[0-9]{3,}px;' Website/Components/DanskeSpil/"

# Find breakpoints in DS, save to file
alias breakpoints-to-file="c; ds; breakpoints | grep -Eo '[0-9]{3,4}' > ../breakpointvalues.txt"

npmglobal() {
  echo; echo "Globally installed npm packages:"; echo;
  npm list -g --depth=0; 
}

# Forcefully terminate all Node.js processes
killnode() {
  taskkill -F -IM node.exe 
}

# Formats all files in the current directory using Prettier
pretty() { 
  npx prettier . --write --config $LUNCHBOX/DotFiles/.prettierrc
}

# Add Prettier config file to current directory
alias prettyhere='cp $LUNCHBOX/DotFiles/.prettierrc .'

# Execute SiteTail
alias sitetail='c && node /c/Projects/rep/SiteTail/index.js'

# IIS reset, the fast way
alias is='iisreset /timeout:0 > null ; iisreset'

### RANDOM
# Utils from https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
alias gitstat='echo --- Commits in 2018: ; git shortlog -sn --all --no-merges --since="2018-01-01"'
alias gitoverview='git log --all --since="yesterday" --oneline --no-merges'
alias gitrecap='git log --all --oneline --no-merges --author=ekmlpe@danskespil.dk'
alias gittoday='git log --since=00:00:00 --all --no-merges --oneline --author=ekmlpe@danskespil.dk'
alias gitwhattoday='git shortlog --all --no-merges --since="00:00:00"'
alias gitbranchlastupdate='git for-each-ref --sort=committerdate refs/heads/ --format="%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)"'

# Update git remote to GitLab
alias sumo="git remote -v && echo git remote set-url origin https://gitlab.com/tennisfar/REPOSITORY.git"

### DOCKER
alias deletealldockerimages='docker rmi $(docker images -q)'
alias locserver='python -m SimpleHTTPServer 8005'
