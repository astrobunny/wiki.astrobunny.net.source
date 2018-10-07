---
tags:
---

# The docker way:

The easiest way to start using Hibiol is by using docker:

    mkdir my_new_wiki
    cd my_new_wiki
    mkdir -p data/pages images
    touch data/pages/home.md
    docker run -v `pwd`/data:/app/data -v `pwd`/images:/app/images -p 4567:4567 -p 5000:5000 -ti davidsiaw/hibiol

And simply go to http://localhost:4567

---

# Building it yourself:

## Requires

- node js
- ruby

## Install packages

    bundle install

## How to run

    mkdir my_new_wiki
    cd my_new_wiki
    mkdir -p data/pages images
    touch data/pages/home.md
    foreman start

And simply go to http://localhost:4567
