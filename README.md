### Usage:

Init:

    git clone git@github.com:Kjuly/dotvim.git ~/.vim
    cp vimrc-sample ~/.vimrc
	  cp gvimrc-sample ~/.gvimrc
    cd ~/.vim
    git submodule init
    git submodule update

Update a plugin:

    cd ~/.vim/bundle/theplugin
    git pull origin master

Update all bundled plugins:

    cd ~/.vim
    git submodule foreach git pull origin master

Add a new plugin:

    cd ~/.vim
    git submodule add git@github.com:username/plugin.git bundle/plugin_name
    git add .
    git ci -m "New plugin as a submodule"

