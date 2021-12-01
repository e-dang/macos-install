#!/bin/bash

# install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

brew tap hashicorp/tap

brew update

brew install git nvm yarn python@3.9 ruby yq jq helm fluxcd/tap/flux hashicorp/tap/terraform sops awscli tree wget kubernetes-cli
brew install --cask visual-studio-code docker iterm2 figma postman

# Install terraspace - recommended way of installation https://terraspace.cloud/docs/learn/aws/install/
if ! gem list --local | grep -q "\bterraspace\b"; then
    gem install terraspace --user-install
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Install node 8.9.3 and node 8.9.3
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
nvm install 16.8.0
nvm install 8.9.3

# Ensure each is installed correctly
git version
python3 --version
yarn --version
yq --version
jq --version
helm version
flux --version
terraform --version
sshfs --version
sops --version
aws --version
node --version
tree --version
kubectl version --client
wget --version

cat << EOT >> ~/.zshrc
# Initialize ssh agent
if [ -z "\$SSH_AUTH_SOCK" ] ; then
    eval \`ssh-agent -s\`
    ssh-add ~/.ssh/id_rsa
fi;

# Add ruby gems to PATH (for terraspace)
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="\$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:\$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
EOT

printf "\n\n\nYour .zshrc has been updated. Please restart your shell.\n"