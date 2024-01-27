echo "\n🔥 Installing zsh 🔥"

# Install oh-my-zsh
export ZSH=$DOTFILES_PATH/zsh/.oh-my-zsh
if [ ! -d "$ZSH" ]; then
	rm -rf ~/.oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
	wait
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
echo "
# Fig pre block. Keep at the top of this file.
[[ -f "\$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "\$HOME/.fig/shell/zshrc.pre.zsh"

# ZSH SETUP
export DOTFILES_PATH="$DOTFILES_PATH"
export ZSH="$ZSH"

# HISTORY
${history}

# THEME
${theme}

# PLUGINS
${plugins}

# ALIASES
${aliases}

source \$ZSH/oh-my-zsh.sh

# Fig post block. Keep at the bottom of this file.
[[ -f "\$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "\$HOME/.fig/shell/zshrc.post.zsh"
" > $DOTFILES_PATH/zsh/.zshrc

ln -sf $DOTFILES_PATH/zsh/.zshrc $HOME/.zshrc
echo "🔗 Created System Link Here: $HOME/.zshrc"
ln -sf $DOTFILES_PATH/zsh/.zsh_history $HOME/commandhistory/.zsh_history
echo "🔗 Created System Link Here: $HOME/commandhistory/.zsh_history"