# MeuLinux
Algumas configuraçoes do  meu linux

Instalar Python 3
    localizar python:
        which python
        which python3

Comandos:
    sudo rm /usr/bin/python
    sudo ln -s /usr/bin/python3 /usr/bin/python
    sudo apt-get install python3
    sudo apt-get install python3-pip
       Instalando dependencias:
           sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

Configuraçoes do Emacs:
    Emacs:
        pip install pylint
        pip install black
        pip install elpy flake8 epc isort
        sudo apt install elpa-counsel
        sudo apt install elpa-ivy-hydra
        npm install eslint
        npm install --global vscode-html-languageserver-bin
        npm install -g vscode-html-languageserver-bin
   Comando dentro do Emacs:
       ;M-x company-tabnine-install-binary to install the TabNine binary for your system.
