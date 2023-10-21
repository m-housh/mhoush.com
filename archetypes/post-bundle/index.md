---
author: "Michael Housh"
categories:
    - HVAC
copy: true
draft: true
date: {{ .Date }}
lastmod: {{ .Date }}
image: banner.png
featuredImage: banner.png
series:
tags:
    - HVAC
title: "{{ substr (replace .Name "-" " ") 15 | title }}"
slug: "{{ substr (.Name) 15 }}"
---
