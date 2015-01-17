vim-gruntmaster
===============

Submit solutions to the [Gruntmaster 6000](http://gm.ieval.ro/) online judge from Vim.

Installation
------------

Use your favorite plugin manager

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/radubogdan/vim-gruntmaster.git ~/.vim/bundle/vim-gruntmaster`
- [Vundle](https://github.com/gmarik/vundle)
  1. Add `Bundle 'radubogdan/vim-gruntmaster'` to .vimrc
  2. Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  1. Add `NeoBundle 'radubogdan/vim-gruntmaster'` to .vimrc
  2. Run `:NeoBundleInstall`
- [vim-plug](https://github.com/radubogdan/vim-plug)
  1. Add `Plug 'radubogdan/vim-gruntmaster'` to .vimrc
  2. Run `:PlugInstall`

Configuration
------------

Provide username, password and base URL of the Gruntmaster 6000 online judge in `.vimrc`

```sh
let g:gruntmaster_username = 'myuser'
let g:gruntmaster_password = 'mypass'
let g:gruntmaster_base_url = 'http://gm.ieval.ro/'

```

Requirements
------------

Your Vim must have Ruby support enabled and version >= 7. Check if `:echo has('ruby')` prints 1.

### Mac OS X

The current version of Mac OS X is shipped with a Ruby-enabled Vim.

### Debian based distributions

```sh
sudo apt-get install ruby rubygems vim-nox
```

(Reference: [Installing vim with ruby support (+ruby)](http://stackoverflow.com/questions/3794895/installing-vim-with-ruby-support-ruby))

Commands
--------

This command submits the current file. The problem name is the basename of the file and the format is determined based on the extension. 
The newly created job will be opened in the default browser.

- `:SubmitToGruntmaster`
- `:STG` - this is an alias for :SubmitToGruntmsater

License
------
See [LICENSE](http://github.com/radubogdan/vim-gruntmaster/License) file
