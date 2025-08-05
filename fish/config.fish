if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Ensure to switch to node version of the directory if set for every directory change and on session start
#functions --copy cd standard_cd
#function cd
#    standard_cd $argv
#    nvm_auto
#end
#nvm_auto

# Initialize pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

# Initialize pyenv
pyenv init - | source

alias vim=nvim
alias vi=nvim
alias edit='cd'

# Configure bobthefish Powerline
# set -g theme_title_display_path no #Hide current path from powerline as it is already displayed by tmux
set -g theme_nerd_fonts yes #Show more icons in powerline
set -g theme_newline_cursor yes #New line under powerline to have more space for commands in small terminals
set -g theme_newline_prompt '> '

# Set ANDROID_HOME to your Android SDK location
set -x ANDROID_HOME ~/Library/Android/sdk

# Add Android SDK tools to PATH
set -x PATH $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $PATH

# Set GRADLE_HOME to your Gradle installation location
set -x GRADLE_HOME /opt/homebrew/opt/gradle

# Add Gradle to PATH
set -x PATH $GRADLE_HOME/bin $PATH

# set -x JAVA_HOME /Users/jannikweichert/Library/Java/JavaVirtualMachines/corretto-1.8.0_422/Contents/Home
set -x JAVA_HOME /Users/jannikweichert/Library/Java/JavaVirtualMachines/openjdk-24.0.1/Contents/Home

set -x PATH $JAVA_HOME/bin $PATH

set -x XDG_CONFIG_HOME /Users/jannikweichert/.config

set -x CHROME_BIN /Applications/Google Chrome Dev.app/Contents/MacOS/Google Chrome Dev

function fish_right_prompt
    #intentionally left blank to hide date & time
end

function fish_mode_prompt
    #intentionally left blank
end

function fish_greeting
    #No greeting
end

function fish_title
    # Regularly set the terminal title to the current directory. This is necessary for custom command edit where fish is changing dir
    set shortpwd (string replace -r "^$HOME" "~" "$PWD")

    echo $shortpwd

    # If we are inside tmux, also update tmux's environment
    if test -n "$TMUX"
        tmux set-environment "PANE_PWD_$TMUX_PANE" "$shortpwd"
    end
end
