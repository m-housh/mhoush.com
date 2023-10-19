---
author: "Michael Housh"
categories:
    - HVAC
copy: true
date: {{ .Date }}
draft: true
image: banner.png
featuredImage: banner.png
series:
slug: {{ .Name }}
tags:
    - HVAC
title: "{{ substr (replace .Name "-" " ") 15 | title }}"
---
