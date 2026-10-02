# DragnLang syntax highlighting

This is a rudimentary syntax highlighter for [DragnLang](https://github.com/seastan/dragncards/wiki/DragnLang-Documentation). It only highlights built-in functions and anything that looks like a variable.

It is based on elzr's [vim-json](https://github.com/elzr/vim-json/) syntax file, with a tiny bit added.

There's no way to detect the file type automatically, so please enable manually by using:

```
set ft=dragnlang
```

It's recommended to use a colorscheme that distinguishes between the `Function` and `Constant` highlighting groups, like [catppuccin](https://github.com/catppuccin/vim).

I personally have this in `~/.vim/after/ftplugin/dragnlang.vim`, which also disables the background (since my terminal has transparency):

```
colorscheme catppuccin

hi Normal guibg=NONE ctermbg=NONE

```

## Installing

This should be installable with vim's built-in package manager. Just run something like

```
mkdir -p ~/.vim/pack/vendor/start
git clone --depth 1 https://github.com/frontierpsycho/vim-dragnland-syntax.git ~/.vim/pack/vendor/start/vim-dragnlang-syntax
```

Replace `vendor/` with whatever you prefer.
