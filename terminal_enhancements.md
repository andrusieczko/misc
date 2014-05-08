# DEBIAN
## git support
### paste it on the end of the ~/.bashrc

```
source /etc/bash_completion.d/git
export PS1='\w$(__git_ps1 " (%s)")> '
```

# MAC OS
## git support
### paste it on the end of your ~/.profile file

```
PS1='\n\033[0;34m\u@\h:\033[0;31m\w \033[01;35m $(vcprompt -f '[%b%m%u]')\033[00m \n> '
```

## Make 'Home' and 'End' keys usable in text editors

```
$ cd ~/Library
$ mkdir KeyBindings
$ cd KeyBindings
$ nano DefaultKeyBinding.dict
```

```
{
/* Remap Home / End keys to be correct */
"\UF729" = "moveToBeginningOfLine:"; /* Home */
"\UF72B" = "moveToEndOfLine:"; /* End */
"$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
"$\UF72B" = "moveToEndOfLineAndModifySelection:"; /* Shift + End */
"^\UF729" = "moveToBeginningOfDocument:"; /* Ctrl + Home */
"^\UF72B" = "moveToEndOfDocument:"; /* Ctrl + End */
"$^\UF729" = "moveToBeginningOfDocumentAndModifySelection:"; /* Shift + Ctrl + Home */
"$^\UF72B" = "moveToEndOfDocumentAndModifySelection:"; /* Shift + Ctrl + End */
}
```

source:
http://mwholt.blogspot.nl/2012/09/fix-home-and-end-keys-on-mac-os-x.html