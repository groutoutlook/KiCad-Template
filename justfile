shebang := if os() == 'windows' { 'pwsh.exe' } else { '/usr/bin/env pwsh' }
set shell := ["pwsh", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-NoProfile","-Command"]
set dotenv-load := true
set script-interpreter := ["pwsh.exe", "-NoLogo", "-NoProfile","-Command"]
set dotenv-filename	:= ".env"
set unstable
set fallback
# set dotenv-required := true
export JUST_ENV := "just_env" # WARN: this is also a method to export env var. 
_default:
    @just --list

help:
    @just --list -f "{{home_directory()}}/justfile"

default_arg := 'TODO:'
alias td := todo
todo todo=default_arg:
    rg {{todo}} -g '!justfile' -g "!third_party" 

hello:
    @Write-Host "Hello, world!" -ForegroundColor Yellow

placeholder:
    #!{{ shebang }}
    Write-Host "Havent written build task for this repo." -ForegroundColor Red
    if($env:pwsh_env) {Write-Host "$env:pwsh_env"}
    else {Write-Host "Apparently no .env as well" -ForegroundColor Yellow}

# INFO: basic `run` recipe.
alias r := run
default_args := 'args here'
run args=default_args:
    ./*kicad*pro


alias b := build
build: placeholder

alias d := deploy
[script,no-cd]
deploy args="":
    $finalName = "{{args}}" -eq "" ? (split-path $pwd -Leaf) : "{{args}}"

    $current_branch = (git current-branch)
    $deployName = $current_branch
    Write-Host "make $deployName " -Fore Blue

    Compress-Archive "production" -DestinationPath ".\$deployName.zip" -Update
    rvpa ".\$deployName.zip" | scb


alias mp := move-production
move-production:
    mv ./*zip ../Finished -Force



