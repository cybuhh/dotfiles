alias heroku-deploy-dev='git push heroku-dev `git symbolic-ref --short HEAD`:master -f'
alias heroku-deploy-stage='git push heroku-stage `git symbolic-ref --short HEAD`:master -f'
alias heroku-deploy-promote='heroku pipeline:promote -a `basename $PWD`-stage'
