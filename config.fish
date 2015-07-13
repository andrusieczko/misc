set fish_git_dirty_color red
set fish_git_clean_color brown
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


# copied and modified from wilhelm's prompt
function parse_git_branch
  if test -d .git
    # uses simple grep and colrm instead of complicated sed regex
    set -l branch (git branch 2> /dev/null | grep --color=never -e '*.\(.*\)' | colrm 1 2)
 
    # use git status to improve performance (instead of using diff)
    set -l git_status (git status -s | head -n 1)
 
    if test -n "$git_status"
      printf ' (%s%s' (set_color $fish_git_dirty_color) $branch
    else
      printf ' (%s%s' (set_color $fish_git_not_dirty_color) $branch
    end
    set -l git_status_origin (git status -s -b | head -n 1)
    set -l ahead (echo $git_status_origin | grep --color=never -e '\[.*ahead.*\]')
    set -l behind (echo $git_status_origin | grep --color=never -e '\[.*behind.*\]')
 
    # if local repo is ahead, show up arrow
    if test -n "$ahead"
      printf '%s↑' (set_color cyan)
    end
 
    # if local repo is behind, show down arrow
    if test -n "$behind"
      printf '%s↓' (set_color magenta)
    end
    printf '%s)' (set_color normal)
  end
end
 
function fish_prompt
  if [ -z $VIRTUAL_ENV ]
    printf '%s%s%s%s  ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s(%s)%s %s%s%s%s%s  ' (set_color -b cyan black) (basename "$VIRTUAL_ENV") (set_color normal) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  end
end

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
        printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end

end
