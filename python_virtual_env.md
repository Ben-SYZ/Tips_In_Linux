https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe

1. `pyenv`: provide python version
2. `venv`: provide virtual environment


Set pyenv as default:
```sh
# .zshrc
# pyenv
##export PYENV_ROOT="$HOME/.pyenv"
##export PATH="$PYENV_ROOT/bin:$PATH"
##if command -v pyenv 1>/dev/null 2>&1; then
##  eval "$(pyenv init -)"
##fi
```

## Working flow example

1. install another version of python
```sh
pyenv install 3.7.9
```

2. Add that python to `$PATH`

```sh
# default python be python 3.7.9
export PYENV_ROOT="$HOME/.pyenv/versions/3.7.9/"
export PATH="$PYENV_ROOT/bin:$PATH"
```

3. Create virtual environment, there will be python command in `.venv/3.6/bin`, but it is a link to current `python`.
```sh
# create virtual environment
cd ~/.venv
python -m venv 3.7
```

4. Active and deactivate it
```sh
source ~/.venv/3.6/bin/activate
deactivate
```

`export` in the 2nd is no needed this time.
