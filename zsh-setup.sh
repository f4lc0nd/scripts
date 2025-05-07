# Install Zsh and basic tools
paru -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions --noconfirm

# Install Powerlevel10k theme
# paru -S zsh-theme-powerlevel10k --noconfirm

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Powerlevel10k as the theme
# sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Enable plugins in .zshrc
# sed -i 's/^plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Source additional plugins at the end of .zshrc
echo '
# Load NVM
#source /usr/share/nvm/init-nvm.sh

# Load plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
' >> ~/.zshrc

# Set Zsh as default shell
chsh -s "$(which zsh)"

# (Optional) Remove fish
# paru -Rns fish --noconfirm

# Done! Restart your terminal or log out/in to start using Zsh
