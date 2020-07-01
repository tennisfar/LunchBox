PATH_DS='/c/Projects/ds/develop'
PATH_DSXXX='/c/Projects/ds/xxx'

alias ds='cd $PATH_DS'
alias dsxxx='cd $PATH_DSXXX'

alias dlo='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dlo && ds'
alias dli='ds && cd Scripts && cd Local && powershell ./SwitchDliDloContext.ps1 -destinationContext dli && ds && git checkout -- Website/Components/DanskeSpil/Framework/PlayerAccountManagement/Include/zzz.DanskeSpil.Framework.PlayerAccountManagement_local.config'
