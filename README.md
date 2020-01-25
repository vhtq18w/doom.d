# doom.d

I :heart: [Doom](https://github.com/hlissner/doom-emacs)

Recently, I have changed to use vanilla Emacs, after I started building own `.config/emacs`, I found because of I frequently build and use the latest version Emacs from source, maintain private configuration is diffcult, I can't correctly track or debug when it startup failed. I felt ashamed and back to the hug of doom XD.

## Get Started

Just follow the next content step-by-step.

1. Clone the Doom project source (After Emacs26)

```sh
    git clone -b develop https://github.com/hlissner/doom-emacs ~/.config/emacs
```

2.  Clone this repository

```c2hs-haskell
    git clone -b opensuse https://github.com/vhtq18w/doom.d ~/.config/doom
```

## Introduction

This configuration can’t work independently. If you activate some features, you must first install pre-dependences. And you can find all modules’ dependences in each module's documentation (you visit it by click `C-h d m MODULE`).

### Dependencies

- ccls --- C/C++ lsp server
- rust-analyzer --- Rust lsp server
- bash-language-server --- BASH lsp server
