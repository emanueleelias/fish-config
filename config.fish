#TMUX ------------------------------------------------------------------------------------------------
if status is-interactive
    and not set -q TMUX
    exec tmux
end
#FIN TMUX ---------------------------------------------------------------------------------------------


#ALIAS ------------------------------------------------------------------------------------------------
alias knowngit 'git config user.name "eliasdaniel"; git config user.email "elias.em@knownonline.com"'
alias personalgit 'git config user.name "emanueleelias"; git config user.email "eliasdanielemanuele@gmail.com"'
alias vrps 'vtex release patch stable '
alias vdf 'vtex deploy --force'
alias vw 'vtex whoami'
alias vlink 'vtex link -v -c'
alias vusem 'vtex use master'
alias vusep 'vtex use production --production'
alias vu 'vtex update'
alias alac="alacritty -e 'fish'"
alias vlist "vtex list"
alias vdeploy 'bash /home/eliasdanielemanuele/.config/fish/deployvtex.sh'
alias vinit 'bash /home/eliasdanielemanuele/.config/fish/vtexinit.sh'
alias c 'cd ..'
alias cat bat
alias nm-remove 'find . -name "node_modules" -type d -prune -exec rm -rf {} +'

#vtex switch
function gp
    git pull origin $argv
end
#vtex switch
function vs
    vtex switch $argv
end
#vtex install
function vinst
    vtex install $argv
end
#vtex login
function vl
    vtex login $argv
end
#vtex use
function vuse
    vtex use $argv
end

function ls
    if test -n "$argv"
        exa --icons $argv
    else
        exa --icons
    end
end

function cdk
    if test -n "$argv"
        cd Documentos/knownOnline/"$argv"
    else
        cd Documentos/knownOnline
    end
end

function cdp
    if test -n "$argv"
        cd Documentos/ccpm/proyectos/"$argv"
    else
        cd Documentos/ccpm/proyectos
    end
end
#FIN ALIAS -------------------------------------------------------------------------------------------


#PNPM ------------------------------------------------------------------------------------------------
set -gx PNPM_HOME "/home/eliasdanielemanuele/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
#FIN PNPM --------------------------------------------------------------------------------------------
