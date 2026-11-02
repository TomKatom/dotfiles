setopt auto_cd auto_pushd pushd_ignore_dups pushd_silent
setopt extended_glob interactive_comments no_beep no_flow_control

# Make Ctrl-W / Alt-B stop at path separators and option dashes.
WORDCHARS=${WORDCHARS//[\/.=-]/}
