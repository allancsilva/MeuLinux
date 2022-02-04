# MeuLinux

- Meu ambiente de trabalho e estudo.

# Screenshots (BSPWM)

<img src= "https://raw.githubusercontent.com/allancsilva/MeuLinux/main/Screen/tela2.png">
<img src= "https://raw.githubusercontent.com/allancsilva/MeuLinux/main/Screen/tela1.png">

# BSPWM
- Configuraçoes:
    Lista de monitores:            1 2 3 4 5 6 <br>
    bspc config top_padding        4
    bspc config bottom_padding     4
    bspc config left_padding       4
    bspc config right_padding      4
    bspc config border_width       1
    bspc config window_gap         18

- Fontes :
    Iosevka Nerd Font
    Hack Nerd
    Fantasque Sans Mono

.

# Baseado em:

Credits : [Stardust-kyun](https://github.com/Stardust-kyun/dotfiles)
Credits : [Stardust-kyun](https://github.com/siduck/dotfiles)



Configuraçoes do  meu linux

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
