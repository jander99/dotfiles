# macOS setup

>  My macOS setup from scratch using [yadm](https://yadm.io).
> `GNU` utils, dev setup, app, configs & Mac App Store installs.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Pre-setup

### Install `homebrew`

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install `yadm`

```bash
brew install yadm
```

## Setup

### Clone and bootstrap

```bash
yadm clone https://github.com/jander99/dotfiles.git --bootstrap # https!
```

**NB:** Bootstraping updates the remote url to ssh, so an ssh key will have to be configured after this (see below).

**NB:** There might be some need to enter the sudo password.

**NB:** Mac App Store installs will ask for a login.

## Done! 