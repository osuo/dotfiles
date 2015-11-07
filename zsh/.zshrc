# .zshrc

# os別設定
case $OSTYPE in
  darwin*)
    export JAVA_HOME=`/usr/libexec/java_home`
    ;;
  linux*)
    ;;
esac

###
export EDITOR='vim'

### for zsh
autoload -U compinit; compinit

# see man zshoptions
setopt correct
setopt nobeep
setopt prompt_subst
setopt ignoreeof
setopt no_tify
setopt hist_ignore_dups
unsetopt auto_menu
setopt auto_pushd
setopt auto_cd

### for path
cdpath=(.. ~ ~/git)

# -U これでパスの重複を取り除いてくれる
typeset -U path cdpath fpath manpath

# see man zshparam
# (N-/)でディレクトリの存在をチェックして除外してくれる
path=(
	$HOME/bin(N-/)
	/usr/local/bin(N-/)
	/usr/local/sbin(N-/)
	$path
)

### for prompt
autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
if is-at-least 4.3.10; then
	zstyle ":vcs_info:git:*" check-for-changes true
	zstyle ":vcs_info:git:*" stagedstr "<S>"
	zstyle ":vcs_info:git:*" unstagedstr "<U>"
	zstyle ":vcs_info:git:*" formats "(%b) %c%u"
	zstyle ":vcs_info:git:*" actionformats "(%b)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && echo -n " %F{yellow}$vcs_info_msg_0_%f"
}


# see man zshmisc

OK="o"
NG="x"

PROMPT="
"
PROMPT+="%n@%m "
PROMPT+="%F{cyan}%~"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%F{white}$ %f"

RPROMPT="%(?.%F{green}$OK%f.%F{red}$NG%f) "
RPROMPT+="%F{gray}[%w %*]%f"

### for alias
alias ls="ls -F"

### for keybind
bindkey -e

function cdup() {
	echo
	cd ..
	zle reset-prompt
}

zle -N cdup
#bindkey '^K' cdup
#bindkey '^R' history-incremental-search-backward

### for tmuxinator
. ~/git/dotfiles/tmuxinator/tmuxinator.zsh


### for other
function chpwd() {
	ls
}

function settitle() {
	echo -ne "\033]0;"$*"\007"
}


#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
#[[ -s "/Users/hagi/.gvm/bin/gvm-init.sh" ]] && source "/Users/hagi/.gvm/bin/gvm-init.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/hagi/.sdkman"
[[ -s "/Users/hagi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hagi/.sdkman/bin/sdkman-init.sh"
