if not set -q -g __fish_doublesuicide_functions_defined
  set -g __fish_doublesuicide_functions_defined

  function _DS_git_branch_name
    set -l branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -z "$branch" -o "$branch" = "HEAD"
      set branch ":"(command git rev-parse --short HEAD 2>/dev/null)
    end
    echo $branch
  end

  function fish_prompt
    set -l cyan (set_color -o cyan)
    set -l green (set_color -o green)
    set -l git_branch (_DS_git_branch_name)

    if test -n "$git_branch"
      set git_info "$green [$cyan$git_branch$green]"

      if test (command git status -z --ignore-submodules=dirty 2>/dev/null)
        set git_info "$git_info"(set_color -o red)"**"
      end
    end

    echo -n -s "$cyan% " $green(basename (prompt_pwd)) $git_info (set_color normal) ' '
  end
end
