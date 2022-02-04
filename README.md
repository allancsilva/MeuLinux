# MeuLinux

- Meu ambiente de trabalho e estudo.

# Screenshots (BSPWM)
<img src= "https://raw.githubusercontent.com/allancsilva/MeuLinux/main/Screen/tela2.png">
<img src= "https://raw.githubusercontent.com/allancsilva/MeuLinux/main/Screen/tela1.png">
# BSPWM
- Configuraçoes:
    Lista de monitores:            1 2 3 4 5 6 <br>
    bspc config top_padding        4 <br>
    bspc config bottom_padding     4 <br>
    bspc config left_padding       4 <br>
    bspc config right_padding      4 <br>
    bspc config border_width       1 <br>
    bspc config window_gap         18
- Fontes : <br>
    Iosevka Nerd Font <br>
    Hack Nerd <br>
    Fantasque Sans Mono

# Baseado em:
Credits : [Stardust-kyun](https://github.com/Stardust-kyun/dotfiles)
Credits : [Stardust-kyun](https://github.com/siduck/dotfiles)
<br><br>
Configuraçoes do  meu linux:

- Instalar Python 3 <br>
    localizar python: <br>
        which python <br>
        which python3

- Comandos: <br>
    sudo rm /usr/bin/python <br>
    sudo ln -s /usr/bin/python3 /usr/bin/python <br>
    sudo apt-get install python3 <br>
    sudo apt-get install python3-pip <br>
       Instalando dependencias: <br>
           sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
- Configuraçoes do Emacs: <br>
        pip install pylint <br>
        pip install black <br>
        pip install elpy flake8 epc isort <br>
        sudo apt install elpa-counsel <br>
        sudo apt install elpa-ivy-hydra <br>
        npm install eslint <br>
        npm install --global vscode-html-languageserver-bin <br>
        npm install -g vscode-html-languageserver-bin <br>
   Comando dentro do Emacs: <br>
       ;M-x company-tabnine-install-binary to install the TabNine binary for your system. <br><br>
