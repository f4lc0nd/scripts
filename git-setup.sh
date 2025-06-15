# Install Git and Git GUI, then set global config
sudo pacman -S git git-gui && \
git config --global user.name "YOUR-NAME" 
git config --global user.email "YOUR-EMAIL" 
git config --global core.editor "nano" && \
git config --global color.ui auto && \
git config --global init.defaultBranch main
