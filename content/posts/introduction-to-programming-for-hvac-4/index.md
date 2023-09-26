---
author: "Michael Housh"
categories:
    - HVAC
    - Programming
copy: true
date: 2023-09-26T11:17:26-04:00
draft: false
image: part4-banner.png
series: Programming for HVAC
tags:
    - HVAC
    - Programming
    - Software
title: "Introduction to Programming for HVAC Part-4"
---

![banner](part4-banner.png)

This article builds upon our [last](https://mhoush.com/posts/introduction-to-programming-for-hvac-3/) article, so make sure to catch up before continuing with this article.

## Arguments

Before we start creating our program that will remove the background from images let's go over
arguments in shell scripts.  Arguments are supplied to shell scripts are separated by a space `" "`,
as opposed to options which start with a `-<character>` or `--<word>`.

To illustrate this, let's change our `hello-world` script we wrote in the last article.

**Move into our scripts directory:**
```bash
cd ~/.local/bin
```

**Make a copy of the hello-world script:**

```bash
cp hello-world greet
```

Above we make a copy of the hello-world file and name the copy `greet`.

**Open the greet file:**

```bash
open -a TextEdit greet
```

> **Note:** Because the greet file is an executable, in order to open it in the `TextEdit`
application we must supply the `-a` option. Otherwise it will just run our `greet` program in
another terminal. Use `man open` to read more about the open command.

**Edit the greet file:**

```bash
#!/bin/sh

echo "Hello, ${1}!"
```

Make sure to save `⌘s` the file.

Take note that the quotes need to be changed to `"` (double quotes) from our original `hello-world`
program.

The `${1}` is indicating that we will insert / interpret the first argument passed to our program
and insert it at that location. Arguments are interpreted in order they are passed in with `${0}`
always representing the filename of the program that is called (generally not needed / used in your
scripts).

**Test it out:**

```bash
./greet Michael
```

![greet-output](greet-output.png)

If you'd like to supply multiple words (or arguments that contain spaces) as a single argument then you can wrap
them in quotes.

```bash
./greet "Michael Housh"
```

> **Tip:** Wrapping in quotes is especially useful for commands that take file paths, if any of the folders or
file names contain spaces.

## More Useful Program

At this point, it's time to build a more useful program that we can use.  First, we must download
some dependencies for our program.

**Install imagemagick:**

```bash
brew install imagemagick
```

> **Note:** If you'd like to check out the documentation / website for imagemagick you can run `brew
home imagemagick`.

This will take a bit for brew to install imagemagick and it's dependencies.  When it's completed, we
can check to make sure that imagemagick is installed by running the following command.

```bash
magick --version
```

It should output something along the lines of this below.

```bash
Version: ImageMagick 7.1.1-17 Q16-HDRI aarch64 21569 https://imagemagick.org
Copyright: (C) 1999 ImageMagick Studio LLC
License: https://imagemagick.org/script/license.php
Features: Cipher DPC HDRI Modules OpenMP(5.0)
Delegates (built-in): bzlib fontconfig freetype gslib heic jng jp2 jpeg jxl lcms lqr ltdl lzma openexr png ps raw tiff webp xml zlib
Compiler: gcc (4.2)
```

> **Tip:** Don't forget, you can use the `clear` command to clear the terminal.

**Create our script:**

```bash
touch mktrans
```

We are going to name our script `mktrans` as a short for make transparent.

**Open the file:**
```bash
open mktrans
```

**The program:**

```bash
#!/bin/bash

# The input file path, passed in as the first argument.
inputfile="${1}"

# The color to make transparent, optionally passed in as the second argument.
# by default we handle / make white backgrounds transparent.
color="${2:-white}"

# Use the built-in basename command to normalize the input file name
# this will convert a file path, such as ~/Pictures/my-image.png to my-image.png.
fullfilename=$(basename -- "$inputfile")

# Use the text of the `fullfilename` up to the first '.' as the file name.
filename="${fullfilename%%.*}"

# Use the text after the last '.' as the file extension.
extension="${fullfilename##*.}"

# Create the output file name to use.
#
# For an input file of `input.png`, our output name would be
# `input-transparent.png`.
#
# This will output the file in the directory that we are
# in when we use our script (which may different than where
# the image is located)
outputfile="${filename}-transparent.${extension}"

# Make the magick happen :)
convert "${inputfile}" -fuzz 10% -transparent "${color}" "${outputfile}"

```

I've included comments in the program above, which is good practice, as there is high odds that you
will forget what is going on when / if you open the file up in the future to look at it. We are
using a lot of what is called parameter expansion magic in this file. You can read up more on what
we are doing in the
[bash documentation](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html).

This script is far from perfect, there are a lot of things to be improved upon. For example, if you
download / save the banner image of this post and run this script, it will also remove some color in
the wizards beard, eyes, and eye brows.  However, it does work very well for my general use case,
which is to remove the background from screenshots of pdf documents. It should be noted that it will
not work on all types of images, some image types do not allow transparency, so it is safest to call
this with input image being a `.png` image type, however you can use the `imagemagick` program that
we downloaded to convert other image types to `.png`, but that will be left up to you to figure out.

## Using Our Program

This is going to assume that you have download the banner image at the top of this article. You can
do this by right-clicking and choosing `Save As`. This should save the image in your downloads
folder, and you can keep the name of `part4-banner.png`.

**Make the program executable:**

```bash
chmod u+x mktrans
```

**Make the image background transparent:**
```bash
./mktrans ~/Downloads/part4-banner.png
```

**Open the image:**
```bash
open part4-banner-transparent.png
```

It should look like below.

![banner-transparent](part4-banner-transparent.png)

> **Note:** If you are viewing this site in *light* mode, the image does not look that bad. Hit the
moon button in the top above my profile image to see some of the flaws of our program.

----

> **Tip:** Remove the image from the `~/.local/bin` by using `rm part4-banner-transparent.png`.  Be
aware that the `rm` command can not be undone, so use with caution / knowledge.  It is safer, until
you are more comfortable to use the `Finder` application and move the file to the trash.  In
`Finder`, you can show hidden directories by typing `⌘.` or go directly to the folder by typing
`⇧⌘G` (shift + command + G) and in the pop-up typing `~/.local/bin`.

----

That is it for this article. In the upcoming articles we will setup our `shell` environment so that
we can use the commands we've built without having to navigate to the `~/.local/bin` directory.
Thank you for reading to the end, I hope you're finding this series helpful.

