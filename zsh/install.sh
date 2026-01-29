echo "\n🔥 Installing zsh 🔥"

# Install oh-my-zsh
export ZSH=$DOTFILES_PATH/zsh/.oh-my-zsh
if [ ! -d $ZSH ]; then
	if [ -d "$HOME/.oh-my-zsh" ]; then
		echo "🗑️ Removing existing oh-my-zsh";
		rm -rf "$HOME/.oh-my-zsh"
		echo "✅ removed existing oh-my-zsh";
	fi
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
	if [ ! -d $ZSH ]; then
		echo "❌ oh-my-zsh failed to install";
		exit 1;
	fi
	echo "✅ installed oh-my-zsh";
else
	echo "♻️ oh-my-zsh already installed";
fi

# Install zsh-autosuggestions
if [ ! -d $ZSH/custom/plugins/zsh-autosuggestions ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions && \
	echo "✅ installed zsh-autosuggestions";
else
	echo "♻️ zsh-autosuggestions already installed";
fi

# Create .zshrc
history=$(cat "$DOTFILES_PATH/zsh/conf/history.sh")
aliases=$(cat "$DOTFILES_PATH/zsh/conf/aliases.sh")
plugins=$(cat "$DOTFILES_PATH/zsh/conf/plugins.sh")
theme=$(cat "$DOTFILES_PATH/zsh/conf/theme.sh")
path=$(cat "$DOTFILES_PATH/zsh/conf/path.sh")
editors=$(cat "$DOTFILES_PATH/zsh/conf/editors.sh")
echo "
# ZSH SETUP
export DOTFILES_PATH="$DOTFILES_PATH"
export ZSH="\$DOTFILES_PATH/zsh/.oh-my-zsh"

# HISTORY
${history}

# THEME
${theme}

# PLUGINS
${plugins}

# EDITORS
${editors}

# ALIASES
${aliases}

# PATH VARIABLES
${path}

source \$ZSH/oh-my-zsh.sh

ln -sf $DOTFILES_PATH/zsh/.zshrc $HOME/.zshrc
echo "🔗 Created System Link Here: $HOME/.zshrc"

mkdir -p $HOME/commandhistory
ln -sf $DOTFILES_PATH/zsh/.zsh_history $HOME/commandhistory/.zsh_history
echo "🔗 Created System Link Here: $HOME/commandhistory/.zsh_history"