#!/bin/bash
set -xe
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
cd fdk
pipenv sync
cd playbooks
pipenv run ansible-playbook direct-ubuntu.yaml -c local -K
