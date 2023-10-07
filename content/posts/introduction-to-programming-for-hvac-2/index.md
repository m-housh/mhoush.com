---
author: "Michael Housh"
categories:
  - HVAC
  - Programming
copy: true
date: 2023-09-22T15:38:03-04:00
draft: false
hideToc: false
image: brew.png
featuredImage: brew.png
series: Programming for HVAC
tags:
  - HVAC
  - Programming
  - Software
title: "Introduction to Programming for HVAC Part-2"
---

In this article, learn about installing a package manager. If you missed it,
check out the
[first](https://mhoush.com/posts/introduction-to-programming-for-hvac-1/)
article in the series where we learned about using your terminal. This article
builds upon that foundation.

# What is a Package Manager

A package manager is a piece of software that helps to install software and
manage updates for your system. For me, the first thing that I do with a new
machine is install `Homebrew`. [Homebrew](https://brew.sh) is my preferred
package manager for `macOS`.

# Why

A package manager is nice because often software relies / requires other
dependencies in order to work properly. By using a package manager it will make
sure that the correct dependencies are installed for the software that you need
to run. It allows you to be able to update and manage software through a
centralized interface.

# Installation

Installation is simple. Open up your terminal and enter the following command
(easiest to just copy / paste from the homepage linked above).

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This will prompt you for your password in order to create some directories and
install the required software for `brew` to work. The installation may take some
time, while it downloads the command line tools for `Xcode`.

When completed, follow the `Next Steps` and copy / paste the command listed,
that should look like below.

```bash
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/<you>/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

![brew-output](brew-output.png)

The first line of this command sets up some things in your shell profile (which
we have not discussed yet) that will make `Homebrew` available to you anytime
you start a new session in your terminal. The second line of the command makes
it available in your current terminal session.

Next run the following command and make sure that everything is setup correctly.

```bash
brew doctor
```

Which should output the following:

```
Your system is ready to brew.
```

## Terminology

Homebrew calls command line applications `formula` and normal graphical
applications `casks`. It has the ability to install both styles of applications.

# Search Command

The following command is used to search for software packages:

```bash
brew search chrome
```

# Open a Homepage

The following command can be used to view the homepage of a formula or cask in
your browser:

```bash
brew home google-chrome
```

# Update Homebrew

The following command is used to update homebrew:

```bash
brew update
```

# Update packages installed on your system

The following command is used to update software that is installed / managed by
homebrew.

```bash
brew upgrade
```

You can combine the update and upgrade commands, which will update homebrew and
upgrade all the software it manages on you machine with the following command.

```bash
brew update && brew upgrade
```

# Conclusion

That is it for this article. I will say that for me, when I find a piece of
software that I want to use, I generally try to search for it in `brew` first,
before installing it via other means.

I hope you've found this article helpful. In the next article we will start to
use the skills that we've learned in these first two articles and write our
first program / script.
