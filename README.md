# vim-toggle-windows
Mappings to easily toggle help, location, preview, and quickfix windows.

## Installation
Using your plugin / runtimepath manager of choice. If you're using a newer
version of vim, you can use Vim's built-in runtimepath manager
(see `:help packages`).

If your method of installation doesn't index the documentation for you,
run `:helptags ~/.vim/doc`.

To view the helpfile for this plugin, run `:help toggle-windows`.

## Usage
To use this plugin, add mappings to your `.vimrc`:

To toggle a help window:
```
nmap <key> <Plug>ToggleHelpWindow
```

To toggle the location window:
```
nmap <key> <Plug>ToggleLocWindow
```

To toggle the preview window:
```
nmap <key> <Plug>TogglePreviewWindow
```

To toggle the quickfix window:
```
nmap <key> <Plug>ToggleQfWindow
```

Toggling is compatible with other methods of opening and closing
these windows. For the location and preview windows, if their
respective lists are empty, the window is not opened and the user
is notified instead. The preview window is restored with both its
previous window location and tag stack, which is helpful to
quickly show and hide function signatures.
