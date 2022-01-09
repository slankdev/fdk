#!/bin/bash
set -eux

ssh-keyscan github.com >> ~/.ssh/known_hosts

PYENV_EXPORTS="/tmp/pyenv-exports.sh"
cat << 'EOF' | tee "$PYENV_EXPORTS"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
EOF

# if pyenv is not installed yet, install it
if [ ! -d $HOME/.pyenv ]; then
    SHELL_NAME="${SHELL##*/}"
    if [ "$SHELL_NAME" = "bash" ]; then
        PROFILE="$HOME/.bash_profile"
    elif [ "$SHELL_NAME" = "zsh" ]; then
        PROFILE="$HOME/.zshrc"
    else
        echo "Unknown shell. Skipped writing pyenv initializations to profile files."
        echo "You can manually add the following script to your shell profile:"
        echo ""
        cat $PYENV_EXPORTS
        echo ""
    fi

    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    cat $PYENV_EXPORTS >> $PROFILE
fi

. $PYENV_EXPORTS

sudo apt -y install libvirt-dev libpython3-dev zlib1g-dev libssl-dev

pyenv install 3.8.0
pyenv global 3.8.0
pip install pipenv

git clone https://github.com/slankdev/fdk.git
cd fdk
pipenv sync
cd playbooks
pipenv run ansible-playbook direct-ubuntu.yaml -c local -K
