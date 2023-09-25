---
author: "Michael Housh"
categories:
    - HVAC
    - Programming
copy: true
date: 2023-09-24T15:37:53-04:00
draft: true
image: part3-banner.png
series: Programming for HVAC
tags:
    - HVAC
    - Programming
    - Software
title: "Introduction to Programming for HVAC Part-3"
---

![banner](part3-banner.png)

In this article we will put together some of the pieces from the last 2 articles, and build our first
program.  If you have missed the first articles, then you can catch up [here](https://mhoush.com/series/programming-for-hvac/)
before continuing with this article.

# Getting Started

We are going to make our first script / program that will remove the background from an image.  We will use a
dependency that we need to install via `brew`, setup a directory to store future scripts in, and learn how
to write a simple script that we can use in the future.

## Creating a scripts directory

We learned in the [first article](https://mhoush.com/posts/introduction-to-programming-for-hvac-1/) how to use
our terminal. Today we are going to use some of the commands we learned then to create a directory where we can
store our script and future scripts.

**Create a directory**

```bash
mkdir -p ~/.local/bin
```

The above command will create a directory in your home folder. We can go ahead and move into the directory we
just created.

```bash
cd ~/.local/bin
```

