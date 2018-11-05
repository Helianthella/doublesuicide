#!/usr/bin/env fish

set -l cyan (set_color -o cyan)
set -l green (set_color -o green)
set -l red (set_color -o red)

# regular prompt
if test -n "$CI"
    rm -rf .git
    set -l got (fish_prompt)
    set -l expected "$cyan% $green""doublesuicide"(set_color normal) ""

    if test ! "$got" = "$expected"
        echo "failed regular prompt"
        echo "\"$got\" <> \"$expected\""
        exit 1
    end
end


# git prompt
mkdir -p .git-prompt
pushd .git-prompt
git init >/dev/null 2>&1
git checkout -b master >/dev/null 2>&1
touch foo
git add foo
git config user.email "ci@localhost"
git config user.name "ci"
git commit -m "bar" >/dev/null 2>&1
set -l got (fish_prompt)
set -l expected "$cyan% $green"".git-prompt$green [$cyan""master""$green]"(set_color normal) ""
popd
rm -rf .git-prompt

if test ! "$got" = "$expected"
    echo "failed git prompt"
    echo "\"$got\" <> \"$expected\""
    git status
    exit 1
end


# dirty git prompt
mkdir -p .git-prompt
pushd .git-prompt
git init >/dev/null 2>&1
git checkout -b master >/dev/null 2>&1
touch foo
git add foo
git config user.email "ci@localhost"
git config user.name "ci"
git commit -m "bar" >/dev/null 2>&1
touch bar
set -l got (fish_prompt)
set -l expected "$cyan% $green"".git-prompt$green [$cyan""master""$green]"(set_color -o red)"**"(set_color normal) ""
popd
rm -rf .git-prompt

if test ! "$got" = "$expected"
    echo "failed dirty git prompt"
    echo "\"$got\" <> \"$expected\""
    git status
    exit 1
end


echo passed all tests!
