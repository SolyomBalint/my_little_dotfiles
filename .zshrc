# Load local not commited changes
[ -f ~/.config/custom/.local_extras.zsh ] && source ~/.config/custom/.local_extras.zsh

# Adding oh my posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/pure.omp.json)"
fi

# Setup zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

## Download it if it's not present yet
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

## Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Zsh Plugins

## Syntax highlight
zinit light zsh-users/zsh-syntax-highlighting

## Completions
zinit light zsh-users/zsh-completions

### Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

## Auto suggestions
zinit light zsh-users/zsh-autosuggestions

## Vim integration plugin
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

## fzf integratin plugin
zinit light Aloxaf/fzf-tab
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# General Settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Tool integrations

## Fzf
eval "$(fzf --zsh)"

# Keybindings
bindkey '^f' autosuggest-accept
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

# Custom additions

. "$HOME/.cargo/env"
export EDITOR="nvim"
export JAVA_HOME="/usr/"

## texlive things
export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH=$PATH:~/yazi/target/release/

# Aliases

## Misc
alias ls='ls --color'

## fzf aliases
alias fzfpreview='fzf --preview="bat --color=always {}"'
alias fzfcd='cd $(fzf --preview="bat --color=always {}")'
alias fzfnvim='nvim $(fzf -m --preview="bat --color=always {}")'

## obsidian aliases
alias obsidian="~/obsidian/appimage/Obsidian-1.6.7.AppImage"

## Terminal emulators
alias wezterm='flatpak run org.wezfurlong.wezterm'

## Tmux aliasese
alias tmuxifierbase="tmuxifier load-session base"

## Editors
alias intellij="~/jetbrains/intellij/idea-IU-242.21829.142/bin/idea"
alias zed="~/.local/zed.app/bin/zed"

## yazi things TODO these should be exported to PATH instead of making aliases, this is true fro the above parts as well
alias yazi="~/yazi/yazi/target/release/yazi"
alias ya="~/yazi/yazi/target/release/ya"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

## Fedora Specific
alias resetfirefox="sudo rm -f /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
