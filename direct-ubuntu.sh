#!/bin/bash
set -xe

SHELL_NAME="${SHELL##*/}"
if [ "$SHELL_NAME" = "bash" ]; then
    PROFILE="$HOME/.bash_profile"
elif [ "$SHELL_NAME" = "zsh" ]; then
    PROFILE="$HOME/.zshrc"
else
    echo "Unknown shell."
    echo "Supported shells: bash, zsh"
    exit 1
fi

ssh-keyscan github.com >> ~/.ssh/known_hosts

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
. ~/.bash_profile

pyenv install 3.8.0
pyenv global 3.8.0
pip install pipenv

sudo apt -y install libvirt-dev libpython3-dev
git clone https://github.com/slankdev/fdk.git
cd fdk
pipenv sync
cd playbooks
pipenv run ansible-playbook direct-ubuntu.yaml -c local -K
