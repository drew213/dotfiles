export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Load aliases
if [ -f "$HOME/aliases.zsh" ]; then
  source "$HOME/aliases.zsh"
fi

# Path
export PATH="$HOME/.local/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"
