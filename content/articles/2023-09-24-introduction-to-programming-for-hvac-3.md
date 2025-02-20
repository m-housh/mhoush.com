---
tags: HVAC, programming, software
---

# Introduction to Programming for HVAC Part-3

In this article we will put together some of the pieces from the last 2 articles, and build our first program. If you have missed the first
articles, then you can catch up [here](https://mhoush.com/series/programming-for-hvac/) before continuing with this article.

## Getting Started

We are going to make our first script / program. This first program is really just setting up some building blocks for our next program we
will write, that will remove the background from an image.

### Creating a scripts directory

We learned in the [first article](https://mhoush.com/posts/introduction-to-programming-for-hvac-1/) how to use our terminal. Today we are
going to use some of the commands we learned to create a directory where we can store our script and future scripts that we write.

**Create a directory**

```bash
mkdir -p ~/.local/bin
```

The above command will create a "hidden" directory in your home folder. We can go ahead and move into the directory we just created.

> **Note:** The `-p` option allows us to create nested directories if the parent directory doesn't exist.

```bash
cd ~/.local/bin
```

### Hello World

It is common in programming to start out with a "Hello World" program when learning a new scripting paradigm. So let's jump in and get
started.

**Creating our script file:**

```bash
touch hello-world.sh
```

**Now open the file:**

```bash
open hello-world.sh
```

The above command should open the file in the `TextEdit` application. In order to make the text edit application to not auto-capitalize
words and play more nicely, we need to adjust some settings. Open the settings by pressing `⌘,`.

In the **Format** section, select _Plain text_ and in the **Options** section de-select _Check spelling as you type_.

![text-settings](/articles/images/2023-09-24-text-settings.png)

At this point for changes to take place, you will need to close the file and re-open.

> **Tip:** In your terminal you can run the last command in your history by using the `↑` (Up) arrow key.

Now that the file is open again, we will write our hello-world program. The contents of your file should look like the following:

```bash
#!/bin/sh

echo 'Hello World!'
```

The first line is referred to as the `shebang`, this tells your computer which shell interperter to run your file. I have not explained the
shell yet, but it currently would just muddy the waters a bit, but there are several shell interperters on your computer with the `sh` posix
shell being one of the most universal / lowest level ones, which is why I'm choosing this one (in other words this script would work on just
about any machine you were on).

The second line we are using the built-in `echo` command and passing it the 'Hello World!' argument.

Now save and close the file `⌘s` (to save) `⌘q` (to quit the text edit application).

**Run the program from your terminal:**

```bash
/bin/sh hello-world.sh
```

You should see that `Hello World!` was printed to your console.

![hello-output](/articles/images/2023-09-24-hello-output.png)

### Make Executable

Now that we have our basic script working, let's make it an executable.

**In your terminal, type the following:**

```bash
chmod u+x hello-world.sh
```

This will change the mode of the file type to be an executable.

Now move / rename the file so we don't have to call it using `.sh` extension:

```bash
mv hello-world.sh hello-world
```

Now that the file is executable, we can execute it by just calling the name of the file.

```bash
./hello-world
```

> **Note:** We have to prefix the file name with `./` in the above command so that it knows where to find our file. The `./` is saying run
> this file in our current directory. In the future we will setup our shell so that it knows to look in our `~/.local/bin` directory for
> scripts, so that we can call them without this prefix.

## Conclusion

Congratulations, in this article we wrote our first program. We learned how to edit the file, set it's permissions, and execute the program
from our terminal. I should mention that the `TextEdit` application is generally not how you would program, people typically use what is
known as an `IDE (integrated development environment)`, however I chose to use the `TextEdit` application because it is built-in to `macOS`
and allowed us to accomplish our goal without downloading other software.

In our upcoming articles, we will write a program that I hope is useful to you / something that you can build upon and use for a long time.
Thank you for reading to this point.
