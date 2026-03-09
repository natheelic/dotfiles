# Path to your oh-my-zsh installation.
# Reevaluate the prompt string each time it's displaying a prompt
setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
if command -v kubectl &> /dev/null; then
	source <(kubectl completion zsh)
fi
if command -v aws_completer &> /dev/null; then
	complete -C "$(command -v aws_completer)" aws
elif [ -f '/usr/local/bin/aws_completer' ]; then
	complete -C '/usr/local/bin/aws_completer' aws
fi

_zsh_autosuggestions_file=""
if command -v brew &> /dev/null; then
	_zsh_autosuggestions_file="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [ -f '/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' ]; then
	_zsh_autosuggestions_file='/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
elif [ -f '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' ]; then
	_zsh_autosuggestions_file='/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh'
fi
if [ -n "$_zsh_autosuggestions_file" ] && [ -f "$_zsh_autosuggestions_file" ]; then
	source "$_zsh_autosuggestions_file"
	if zle -la | grep -q '^autosuggest-execute$'; then
		bindkey '^w' autosuggest-execute
	fi
	if zle -la | grep -q '^autosuggest-accept$'; then
		bindkey '^e' autosuggest-accept
	fi
	if zle -la | grep -q '^autosuggest-toggle$'; then
		bindkey '^u' autosuggest-toggle
	fi
fi
unset _zsh_autosuggestions_file
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

if command -v starship &> /dev/null; then
	eval "$(starship init zsh)"
	export STARSHIP_CONFIG=~/.config/starship/starship.toml
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR=/opt/homebrew/bin/nvim

alias la=tree
if command -v bat &> /dev/null; then
	alias cat=bat
elif command -v batcat &> /dev/null; then
	alias cat=batcat
fi

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# GO
export GOPATH='/Users/omerxx/go'

# VIM
alias v="/Users/omerxx/.nix-profile/bin/nvim"

# Nmap
alias nm="nmap -sC -sV -oN nmap"

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/omer/.vimpkg/bin:${GOPATH}/bin:/Users/omerxx/.cargo/bin:$PATH

alias cl='clear'

# K8S
export KUBECONFIG=~/.kube/config
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'
alias podname=''

# HTTP requests with xh!
alias http="xh"

# VI Mode!!!
bindkey jj vi-cmd-mode

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# SEC STUFF
alias gobust='gobuster dir --wordlist ~/security/wordlists/diccnoext.txt --wildcard --url'
alias dirsearch='python dirsearch.py -w db/dicc.txt -b -u'
alias massdns='~/hacking/tools/massdns/bin/massdns -r ~/hacking/tools/massdns/lists/resolvers.txt -t A -o S bf-targets.txt -w livehosts.txt -s 4000'
alias server='python -m http.server 4445'
alias tunnel='ngrok http 4445'
alias fuzz='ffuf -w ~/hacking/SecLists/content_discovery_all.txt -mc all -u'
alias gr='~/go/src/github.com/tomnomnom/gf/gf'

### FZF ###
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/opt/homebrew/bin:$PATH

alias mat='osascript -e "tell application \"System Events\" to key code 126 using {command down}" && tmux neww "cmatrix"'

# Nix!
export NIX_CONF_DIR=$HOME/.config/nix
export PATH=/run/current-system/sw/bin:$PATH

function ranger {
	local IFS=$'\t\n'
	local tempfile="$(mktemp -t tmp.XXXXXX)"
	local ranger_cmd=(
		command
		ranger
		--cmd="map Q chain shell echo %d > "$tempfile"; quitall"
	)

	${ranger_cmd[@]} "$@"
	if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
		cd -- "$(cat "$tempfile")" || return
	fi
	command rm -f -- "$tempfile" 2>/dev/null
}
alias rr='ranger'

# navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

 # Nix
 if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	 . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
 fi
 # End Nix

export XDG_CONFIG_HOME="$HOME/.config"

if command -v zoxide &> /dev/null; then
	eval "$(zoxide init zsh)"
fi
if command -v atuin &> /dev/null; then
	eval "$(atuin init zsh)"
fi
if command -v direnv &> /dev/null; then
	eval "$(direnv hook zsh)"
fi

neofetch
