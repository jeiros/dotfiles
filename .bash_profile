
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi




# Aliases
alias ..='cd ..'
alias brc_dropbox='cd ~/Dropbox\ \(Imperial\)/BRC-ICB\ \ Gould\ studentship/'
#alias rm='rm -i'
alias c='clear'
alias vi='vim'
alias l='ls -Glvh'
alias rmtgz='ls | grep -v *.tgz | xargs rm'  # Removes all the files in the directory that are not .tgz files
alias tree='tree -h'
alias du='du -h'
alias rstudio='open -a RStudio'

# SSH aliases
export HPC='login.cx1.hpc.ic.ac.uk'
export titanx1='ch-igould-titanx1.ch.ic.ac.uk'
export titanx2='ch-igould-titanx2.ch.ic.ac.uk'
export igould7='ch-igould7.ch.ic.ac.uk'
alias sshHPC='ssh je714@${HPC}'
alias sshTitanx1='ssh je714@${titanx1}'
alias sshTitanx2='ssh je714@${titanx2}'
alias sshigould7='ssh je714@${igould7}'



# Quick cd to working directories
alias salted='cd /Users/je714/Troponin/IAN_Troponin/completehowarthcut/salted'
alias nocalwt='cd /Users/je714/Troponin/IAN_Troponin/completehowarthcut/noCAL_WT'
alias phospho='cd /Users/je714/Troponin/IAN_Troponin/completehowarthcut/phospho/hmr_runs'

# VMD and Chimera aliases
vmdappdir='/Applications/VMD1.9.2.app/Contents'
alias vmd='"$vmdappdir/Resources/VMD.app/Contents/MacOS/VMD" $*'
alias myvmd='vmd -e ~/Scripts/StateFile -size 1920 1080'
alias myvmd2='vmd -startup ~/Scripts/StateFile -size 1920 1080'
alias chimera='/Applications/Chimera.app/Contents/MacOS/chimera'
export CHIMERA_PATH='/Applications/Chimera.app/Contents/Resources/share'

# Connections
export CX1="login.cx1.hpc.ic.ac.uk"
export TITAN='ch-igould-titanx1.ch.ic.ac.uk'

# Command line prompt
export PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;208m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\w\\$ \[$(tput sgr0)\]"

# MacPorts Installer addition on 2015-07-27_at_16:06:16: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:/opt/bin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Add the Scripts repository (git@github.com:jeiros/Scripts.git) to the PATH
export SCRIPTS='/Users/je714/Scripts'
export PATH="${SCRIPTS}:${SCRIPTS}/AnalysisMDTraj:${SCRIPTS}/AnalysisCpptraj:${SCRIPTS}/Rplots/:$PATH"


# Add the htmd git dir to the PYTHONPATH
export PYTHONPATH="/Users/je714/hmtd:${PYTHONPATH}"

# AMBER installation
export AMBERHOME="/usr/local/amber16"
test -f /usr/local/amber16/amber.sh && source /usr/local/amber16/amber.sh



# Reenact LEaP session
function leap {
  if [[ $# -eq 0 ]]; then
	printf 'Please provide a leap.log file\n'
  else
  	cat $1 | grep '^> ' | sed 's/^> //'
  fi
}
# Backup .tgz, .prmtop and production NetCDF files (05*nc)
# from $1 (Source) to $2 (Target)
# and keep directory structure using rsync
function backup_rsync {
  if [[ $# -ne 2 ]]; then
	printf 'Please provide two arguments\n'
	printf 'Usage: backup_tgzs Source/ Target/\n'
  else
	rsync -av --no-whole-file --include '*/' --include '*.tgz' \
		  --include '*.prmtop' --include '05*.nc' \
          --exclude '*' --prune-empty-dirs $1 $2
  fi
}

# Open .png files from the command line
function display {
  if [[ $# -eq 0 ]]; then
	printf 'Please provide arguments\n'
  else
	open -a Preview "$@"
  fi
}


# added by Anaconda3 4.0.0 installer
export PATH="/Users/je714/anaconda3/bin:$PATH"
