---
tags: programming, networking, nas, how-to
---

# UNVR as NAS

In this post, I'm going to show how to setup a Samba server on a Ubiquity UNVR so that it can be
used as NAS (network attached storage). Be aware that this should be done with caution and may void
any warranty on your UNVR as we are using it for purposes beyond it's original intent. It's also
possible that this setup will break when / if updating the UNVR software. With that said, let's jump
in.

This post follows along with
[this reddit post](https://www.reddit.com/r/Ubiquiti/comments/11o7v8l/how_to_use_the_unvr_as_a_nas_instructions/),
with some adaptations to get it to work on the latest Unifi-OS release of `3.2.12`.

## Step One - Setup SSH & Login

In your unifi network console you need to enable the `SSH` login option and set a secure password
for the root user to login to the UNVR.

![ssh.png](/articles/images/2024-03-15-ssh.png)

Once that is complete you can login to your UNVR using your terminal and the IP address of your UNVR
on your network.

`ssh root@192.168.1.10`

## Step Two - Install Samba

First, we'll update the package registry information.

`apt-get update`

Next, install samba.

`apt-get install samba`

## Step Three - Setup Samba

In order to edit the configuration we are going to need to install your terminal based text editor
of choice (generally nano or vim), for me I will install vim.

`apt-get install vim`

Create a backup of the default configuration.

`cp /etc/samba/smb.conf /etc/samba/smb.conf.bak`

Open the configuration file to be edited.

`vim /etc/samba/smb.conf`

Just above the `Share Definitions` section of the configuration, I added some global settings to
make the samba server act better for time machine backups.

```
#======================= MacOS Client Optimizations  =======================
vfs objects = fruit streams_xattr
fruit:metadata = stream
fruit:model = MacSamba
fruit:posix_rename = yes
fruit:veto_appledouble = no
fruit:nfs_aces = no
fruit:wipe_intentionally_left_blank_rfork = yes
fruit:delete_empty_adfiles = yes

```

Also because we want users we create to be able to read and write to their home directories created
on the samba server, we need to change the option under the `[homes]` share definition to be
`read only = no`.

That is our primary configuration. You can add more share definitions at the bottom of the file to
suit your use case, there are decent examples of this in the original reddit post, linked in the
beginning.

Save and exit the file.

`:wq`

## Step Four - Start Samba

Use the following command to start the samba server.

`sudo service smbd start`

You can check the status, by running the following command.

`systemctl status smbd`

![status](/articles/images/2024-03-15-status.png)

Enable the samba server to start on boot.

`systemctl enable smbd.service`

## Step Five - Create Users

Create a user with a home directory that they can use.

`useradd --create-home michael`

Give the user a password to login to the samba server.

`smbpasswd michael`

## Step Six - Login to Samba Server from Client

In the `Finder` app on macOS you can type `⌘k` to connect to a server.

In the text field enter `smb://<USER>@<UNVR_IP>` to connect to the samba server.

![connect](/articles/images/2024-03-15-connect.png)

You can also automatically connect to the server when you login to your client device, for this to
work you need the credentials to be stored in your keychain (ticking the box in the step above when
you first connect to the server).

This is found in `System Settings -> General -> Login Items -> Open at Login`. Click the plus button
and select the volume you would like to mount at login.

![login](/articles/images/2024-03-15-login.png)

Once you have it setup so that the server is connected on login, you can also set it up as location
for Time Machine Backups. `System Settings -> General -> Time Machine`

![time-machine](/articles/images/2024-03-15-time-machine.png)
