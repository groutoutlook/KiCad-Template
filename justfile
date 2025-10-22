shebang := if os() == 'windows' { 'pwsh.exe' } else { '/usr/bin/env pwsh' }
set shell := ["nu", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-NoProfile","-Command"]
set dotenv-load := true
set script-interpreter := ["pwsh.exe", "-NoLogo", "-NoProfile","-Command"]
set dotenv-filename	:= ".env"
set unstable
set fallback
# set dotenv-required := true
export JUST_ENV := "just_env" # WARN: this is also a method to export env var. 
_default:
    @just --list --unsorted
    
alias b := build
[group('dev')]
build:
    # build task here

alias fmt := format
format:
    # format plesase. could also run rfmt

alias t := test
[group('dev')]
test:
    # test.

alias w := watch
watch:
    # watch, mostly spin up an application e.g. `r r`-> read log by less/bat/ov/tailspin

alias sk := seek
seek:
    # seek ...what? maybe reference to other?

# INFO: basic `run` recipe.
alias r := run
default_args := 'args here'
[group('dev')]
run args=default_args:
    ./*kicad*pro

alias d := deploy
[group('prod'),script,no-cd]
deploy args="":
    $finalName = "{{args}}" -eq "" ? (split-path $pwd -Leaf) : "{{args}}"

    $shaShort = git rev-parse --short=5 HEAD
    $current_branch = (git current-branch)
    $deployName = "$current_branch-$shaShort"
    Write-Host "make $deployName" -Fore Blue

    Compress-Archive "production" -DestinationPath "./$deployName.zip" -Update
    rvpa "./$deployName.zip" | scb

alias mp := move-production
[group('prod')]
move-production:
    mv ./*zip ../Finished -Force

