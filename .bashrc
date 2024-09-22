# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"
alias obsidian="~/obsidian/appimage/Obsidian-1.6.7.AppImage"

# fzf aliases

alias fzfpreview='fzf --preview="bat --color=always {}"'
alias fzfcd='cd $(fzf --preview="bat --color=always {}")'
alias fzfnvim='nvim $(fzf -m --preview="bat --color=always {}")'

alias yazi="~/yazi/target/release/yazi"
alias ya="~/yazi/target/release/ya"
alias wezterm='flatpak run org.wezfurlong.wezterm'
alias resetfirefox="sudo rm -f /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js"
alias intellij="~/jetbrains/intellij/idea-IU-242.21829.142/bin/idea"
alias tmuxifierbase="tmuxifier load-session base"
alias zed="~/.local/zed.app/bin/zed"

export EDITOR="nvim"
export JAVA_HOME="/usr/"

# texlive things

export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
export PATH="$HOME/.tmuxifier/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
