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

# if pyenv is not installed yet, install it
if [ ! -d $HOME/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv

    cat << 'EOF' | tee -a $PROFILE | tee /tmp/exports.sh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
EOF

    . /tmp/exports.sh
fi

sudo apt -y install libvirt-dev libpython3-dev zlib1g-dev libssl-dev

pyenv install 3.8.0
pyenv global 3.8.0
pip install pipenv

git clone https://github.com/slankdev/fdk.git
cd fdk
pipenv sync
cd playbooks
pipenv run ansible-playbook direct-ubuntu.yaml -c local -K
