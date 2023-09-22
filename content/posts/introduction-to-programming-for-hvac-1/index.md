---
author: "Michael Housh"
categories:
    - HVAC
    - Programming
copy: true
date: 2023-09-21T09:47:18-04:00
draft: false
hideToc: false
image: programming-thumbnail.png
series: Programming for HVAC
tags:
    - HVAC
    - Programming
    - Software
title: "Introduction to Programming for HVAC Part-1"
---

![programming](programming.png)

This is part one of a series of articles to help HVAC technicians (or others) get
started in developing their skills to program. This can help to automate
everyday tasks or just familiarize themselves with some of the tools used by programmers.

# Why

I think if nothing else, this series can help gain knowledge, tips, and tricks to make
you more comfortable with your computer. I hope that you will at least learn how to use your `terminal`
application and more specifically `vim` motions and keybindings (more on that in another article).

The goal of this article is to just get a machine setup with tools and to start exploring.
I am a shill for `macOS`, so all of these will be specifically geared towards that and my workflows,
most everything that is showcased should also work on `linux` machines (not sure about `windows`),
although you may have to search for specific instructions on installing software for other platforms.

What I have learned on my journey in programming is that the more you can lean on small software
packages that focus on a single task, but do them well, the better.  The less you use your mouse,
the more productive you can be.  The more you can work with `text` files and formats the more portable
and transformable your workflows can be.

# Getting Started

The first thing that we will focus on is becoming familiar with the terminal application.
On macOS the terminal application is located at `/Applications/Utilities/Terminal.app`.
However, rather than click around to find it, you can use the `⌘<space>` to pull up your spotlight
search, then type `Terminal` to select the terminal application.

![spotlight](spotlight.png)

# Terminal Overview

Your terminal is a program that allows you to run programs by typing commands into it's window.  There are
a lot of built-in commands and a bunch that you can install.  The terminal is very customizable (and once
familiar, you will constantly be tweaking / adjusting to suit your needs). Right now customization is not
what we will focus on, however in future articles I will provide tips and tricks on customizing it.  Right
now, we only need to know how to open it up and type in commands.

![terminal](terminal.png)

Below is an image / explanation of what the default status line includes.

![terminal-line](terminal-line.png)

## Learn Basic Commands (Built-in)

Here are a few basic commands that you should familiarize yourself with, as you will use them often
when working inside of a terminal.

## Change Directory

`cd` (change directory) is the command that allows you to move around your file system when inside the terminal.

> **Note:** `~` is a representation of your `Home` directory.

```bash
cd ~/Documents
```

The above command will move you into your Documents directory.

> **Note:** If there are spaces in the name of the directory you try to move to
> then the easiest way is to wrap the name in quotes.

```bash
cd "~/Documents/Product Concepts"
```

Some other things to understand when moving around / supplying arguments to the `cd` command.

You can use `..` to go backwards / move up to the parent directory.  For example, say we are in
the `~/Documents` directory, to go back up to the home directory we could use the following:

```bash
cd ..
```

These can be chained together as well. For example say we are located in the `~/Documents/Product Concepts` directory,
we could use the following to go up two directory levels back to the home directory.

```bash
cd ../..
```

> **Pro-Tip:** You can use the `<tab>` key when navigating to auto-complete, generally typing a few characters
> followed with the `<tab>` key will auto-complete for you.

## List files

Use `ls` to output a list of files and directories where you are located.

```bash
ls
```

*Example Output when in my ~/Documents directory*
``` bash
Estimates.app
InkscapeDrawings
KwikModel
MyAparment
NCISummit
Personal
Product Concepts
Receipts.receipts
RingCentral
SketchUP
Tech-Tips
desktop.ini
espanso-migrate-backup
espanso-migrate-backup-2
```

Using options with `ls` to show more statistics and hidden files. There are often hidden files on your
computer that are used for application support or other purposes, these files are not shown using the
default command. Hidden files start with a `.`, below is an example of showing hidden files in your home
directory.

```bash
ls -la ~/
```

> **Note:** Above I added the `~/` which will allow you to list the files in your home directory even if you
> currently are not there in your terminal, if you were already there (for example by using `cd ~/` then
> you would not need to use that at the end of the command.

*Example Output*

```
total 168
drwxr-xr-x+  46 michael  staff   1472 Sep 22 10:45 .
drwxr-xr-x    6 root     admin    192 Sep 22 09:08 ..
-r--------    1 michael  staff      7 Apr  8  2021 .CFUserTextEncoding
-rw-r--r--@   1 michael  staff  14340 Sep 18 10:15 .DS_Store
drwx------+   5 michael  staff    160 Sep 20 17:03 .Trash
-rw-r--r--    1 michael  staff    186 Sep 12 15:20 .actrc
drwxr-xr-x    4 michael  staff    128 Dec 13  2021 .bin
drwxr-xr-x    3 michael  staff     96 Mar  6  2023 .bundle
drwxr-xr-x    7 michael  staff    224 Sep 12 11:40 .cabal
drwxr-xr-x    7 michael  staff    224 Sep 12 15:20 .cache
drwxr-xr-x   13 michael  staff    416 Aug 10 08:47 .config
drwx------    3 michael  staff     96 Jun 21  2021 .cups
drwxr-xr-x   12 michael  staff    384 Sep 15 15:22 .docker
drwxr-xr-x   20 michael  staff    640 Sep 19 08:11 .dotfiles
drwxr-xr-x    4 michael  staff    128 Jul 26  2021 .gem
drwxr-xr-x    3 michael  staff     96 Oct 11  2021 .jssc
-rw-------    1 michael  staff     20 Sep 22 10:45 .lesshst
drwxr-x---    3 michael  staff     96 Mar 29 08:47 .lldb
drwxr-xr-x    8 michael  staff    256 Mar  1  2023 .local
drwxr-xr-x    4 root     staff    128 Apr 12  2021 .newtek
drwxr-xr-x    5 michael  staff    160 Dec 13  2021 .npm
-rw-------    1 michael  staff  27436 Apr 10 10:21 .psql_history
drwxr-xr-x    7 michael  staff    224 Apr 18  2022 .ssh
drwxr-xr-x    6 michael  staff    192 Sep 21 09:06 .swiftpm
lrwxr-xr-x    1 michael  staff     25 Dec 27  2021 .tmux.conf -> .dotfiles/tmux/.tmux.conf
drwxr-xr-x    8 michael  staff    256 Mar 27 16:14 .twilio-cli
drwxr-xr-x    6 michael  staff    192 Sep 18 11:08 .vim
-rw-------    1 michael  staff  23086 Sep 21 09:45 .viminfo
-rw-r--r--    1 michael  staff    254 Sep 21 09:32 .wget-hsts
lrwxr-xr-x    1 michael  staff     43 Jan  3  2022 .zshenv -> /Users/michael/.dotfiles/zsh/config/.zshenv
drwxr-xr-x    8 michael  staff    256 Dec 14  2021 AmazonWorkDocsCompanion
drwx------@   4 michael  staff    128 Dec 13  2021 Applications
lrwxr-xr-x    1 michael  staff     40 Jun  6 12:00 Applications (Parallels) -> /Volumes/Bucket/Applications (Parallels)
drwx------@  30 michael  staff    960 Sep 21 08:54 Desktop
drwx------@  19 michael  staff    608 Sep 14 10:15 Documents
drwx------@  21 michael  staff    672 Sep 21 09:43 Downloads
drwx------+ 115 michael  staff   3680 Sep 14 10:04 Library
drwxr-xr-x    3 michael  staff     96 Sep  8 13:06 LocalProjects
lrwxr-xr-x    1 michael  staff     29 Dec 30  2021 Movies -> /Volumes/Bucket/Videos/Movies
lrwxr-xr-x    1 michael  staff     21 Dec 30  2021 Music -> /Volumes/Bucket/Music
drwx------@   2 michael  staff     64 Mar  6  2023 Parallels
drwx------@   7 michael  staff    224 Sep 14 09:52 Pictures
drwxr-x---+   4 michael  staff    128 Apr  8  2021 Public
drwxr-xr-x+   3 michael  staff     96 Sep 14 09:52 Sites
drwxr-xr-x    3 michael  staff     96 Jun  7  2021 WorkDocs Drive
drwxr-xr-x    3 michael  staff     96 Sep 18 11:36 go
```

As you can see, I have a lot of hidden files and folders, your output will probably look much different than mine.

## Clearing the Terminal

Often times you may want to clear the terminal screen. You can use the `clear` command to clear the screen of the terminal.

```bash
clear
```

Or use a keyboard shortcut `⌃l` (`<control>l`)

## Creating Directories

Use `mkdir` (make directory) to create a directory.

First, let's move into the `tmp` directory, the `tmp` directory is a directory on your file system that is
typically used for applications to write temporary logs / files to, it get's erased everytime your computer
is restarted. We can use the `cd` command that we learned earlier.

```bash
cd /tmp
```

Next, let's create a new directory called "MyDirectory".

```bash
mkdir MyDirectory
```

### Gotcha's with 'mkdir'

By default you can't create directories that are multiple levels deep, unless the directories already existed or we
provide the `-p` option. For example, if we want to create a directory at `/tmp/MyOtherDirectory/Nested/Deeply` then
we could use the following command when inside the `tmp` directory.

```bash
mkdir -p MyOtherDirectory/Nested/Deeply
```
Now, try out using the `<tab>` key with the `cd` command to navigate to the `Deeply` folder.

```bash
cd MyOther <tab> <tab> <tab>
```

## Open Command

You can use the open command to open files or folders in the default application for the file type.

For example, if we want to open a `Finder` window while in the `/tmp` directory, we can use the following
command:

```bash
open .
```

## Manual Pages

Lastly, to learn more about commands you can use the `man <command>`. To bring up the manual pages for
the command in the terminal. You can use the arrow keys to navigate around the manual pages and type the
letter `q` to quit / close the manual pages.

```bash
man ls
```

That is it for the first installment in this series. I hope you learned something and have better understanding
of using your terminal.

