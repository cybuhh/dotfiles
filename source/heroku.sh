#!/usr/bin/env bash

alias heroku-deploy-dev='git push heroku-dev `git symbolic-ref --short HEAD`:master -f'
alias heroku-deploy-stage='git push heroku-stage `git symbolic-ref --short HEAD`:master -f'
alias heroku-deploy-promote='heroku pipelines:promote -a `basename $PWD`-stage'
