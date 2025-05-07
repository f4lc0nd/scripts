# Install Git and Git GUI, then set global config
sudo pacman -S git git-gui && \
git config --global user.name "f4lc0nd" 
git config --global user.email "sofalcons@outlook.com" 
git config --global core.editor "nano" && \
git config --global color.ui auto && \
git config --global init.defaultBranch main