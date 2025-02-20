---
image: 2024-04-04-pgp-encryption-introduction.gif
tags: programming, security, PGP, GnuPGP
---

# PGP Encryption Introduction

In this article I introduce PGP and show a use case for me, which perhaps you can use as well.

## What is PGP

PGP stands for **Pretty Good Privacy**, it was first developed in 1991 by Phil Zimmermann. PGP uses
cryptographic privacy and authentication and is generally used in data communication.

According to [Wikipedia](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) it's name was inspired
by a grocery store named, "Ralph's Pretty Goody Grocery" featured in radio host's Garrison Keillor's
fictional town of Lake Wobegon.

PGP is commonly used in software development to "sign" software commits or files to help ensure both
who the commits were from as well as make sure they were not modified from the original versions.

It should also be noted that when people say PGP they are often referring to OpenPGP or GnuPGP which
are implementations of the PGP standard protocol.

## What it does

> Note: I am in no way a cyber-security expert, I am a layman and only describing things in terms
> that I understand / make sense to me. Do what I do at your own risk!

PGP offers both symmetrical encryption (uses a session key and password) or asymmetrical encryption
(uses a session key and a private key). Asymmetrical encryption is more secure but is more resource
intensive (which is generally not a problem with computers of today).

Generally speaking PGP uses what are known as public and private key pairs. The public portion of
the key par is meant to be shared with others freely, while the private portion needs to be secured
/ not shared with anyone **EVER**. It is best practice to generate your keys on a computer that is
"air gapped", meaning it is not connected to any network / internet, and does not save a history of
commands performed on it.

PGP encrypts data (files, messages, etc.) for one or more recipients, using the recipients public
key. The recipients private key is required to decrypt the data once it's been encrypted.

Your key pair is tied to your identity / person, generally by your name and email(s). The key can
also have multiple "subkeys", meaning that if you have more than one public email, alias, etc. it
can be tied to your same private key. This is useful for example for work vs. activism vs. software
development.

Once your key is generated and your private key secured, you can share your public portion of the
key to a "keyserver" where other people can download it and verify messages were sent by you.

## Web of Trust

PGP also uses what is called the **"Web of Trust"**, which is used to validate that messages are
encrypted by a trusted source. There are different levels of trust depending on where a key is
retrieved from. For example, if somebody gave you their public key in person and you were able to
inspect that the identity matches their government id, then you can give it a higher trust level
than one that is sent / retrieved from a keyserver.

My understanding of this portion is that over time your key is signed by other's with their level of
certainty about you / your key, which over time increases the overall trust in your key.

## Out of the weeds

Now that we've got an understanding of some of the technical aspects, lets talk about some real use
cases of PGP encryption.

PGP encryption is used by some email clients / applications, such as
[Canary](https://canarymail.io/),
[Thunderbird](https://www.thunderbird.net/en-US/thunderbird/115.0/holidayeoy/), or
[GPGSuite](https://gpgtools.tenderapp.com/).

In my understanding, it is also what is used in devices such as a
[YubiKey](https://www.yubico.com/).

Many of the mentioned applications allow for an easier interface / adoption, as one of the reasons
it is not very popular is that it can be hard to use PGP for the average person.

Aside from using my PGP key for signing software commits, my major use case is for encrypting files
that I store in a "cloud" provider. Know that when someone says the "cloud", it is really just a
computer (in reality a gang of computers in a data center). You are solely reliant that these cloud
providers are not snooping on, inspecting, or even selling your data.

Of course, some data may not be that sensitive, so maybe you don't care. However with a little bit
of effort on your part you can at least make it very hard for anyone to know what is inside your
documents. You can be in control of the way your items are encrypted and have confidence that nobody
but you can access what is inside your documents.

Heck, I even encrypt documents that are stored on my own network / computer so that if something
get's stolen or someone breach's my network they will not be able to easily get to sensitive data.

## Conclusion

This article is just meant as an overview of PGP encryption. In future articles I will show you how
to use it to encrypt your data and be in control of your privacy.

### Resources

- [GnuPG](https://gnupg.org/)
- [OpenPGP](https://www.openpgp.org/)
- [gpg.wtf](https://gpg.wtf/)
- [RFC4880](https://www.ietf.org/rfc/rfc4880.html)
