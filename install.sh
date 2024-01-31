export DOTFILES_PATH=$PWD

echo "\n🔍 Verifying installer dependencies..."
isMissingDependency=false
if command -v curl >/dev/null 2>&1; then
	echo "✅ curl installed"
else
	echo "❌ curl not installed"
	isMissingDependency=true
fi
if command -v git >/dev/null 2>&1; then
	echo "✅ git installed"
else
	echo "❌ git not installed"
	isMissingDependency=true
fi

if $isMissingDependency; then
	echo "❌ git not installed"
	exit 1
else
	echo "👌 verified installer dependencies"
fi


sh ./zsh/install.sh