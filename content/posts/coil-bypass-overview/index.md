---
author: "Michael Housh"
categories: ["Coil Bypass"]
copy: true
date: 2023-08-10T20:26:42-04:00
draft: true
series: "Coil Bypass"
tags: ["Coil Bypass", "HVAC"]
title: "Coil Bypass Overview"
---

This article explores the idea of a coil bypass strategy in an HVAC system.

> **Note:**
> Some items are more of a generalization / hypothesis and may need more data / thought.

A coil bypass is not to be mistaken for a zoning system bypass, where airflow is "relieved" from
the supply side of the system back into the return. Instead, a coil bypass diverts a portion
of the airflow around the coil using a bypass damper(s).  The bypass can serve several functions
depending on the application, but in general it allows for a constant volume of air to be
delivered to the space while the output of the coil can be shifted towards more or less
dehumidification. In other words, it decouples the total system airflow from the coil airflow.

## The Problem

ASHRAE's recommandation for the amount of air changes per hour (ACH) in a residential structure to
be in the range of 3-5 ACH, and in general the higher the better, along with a MERV 13+ filter.
In some / most cases the system airflow does not meet that criteria, especially low load homes
or high volume homes.

For example, let's imagine a single story ranch home that is 2,500 square feet with 9 foot ceilings.
This home is relatively tight construction and after doing the heating and cooling loads we've selected
a 2.5 Ton system for this home. It is located in a green grass climate that needs some priority
on dehumidification and requires an airflow of 350 CFM/Ton (875 CFM).

We determine the volume of the conditioned space.

$ 2,500 \times 9 = 22,500 $ $ ft^3 $

We can then determine the CFM for the given air changes per hour (ACH) using the following formula.

$$ \frac{(V \times ACH)}{60} $$
| **Where:** |     |
| ---------- | --- |
| **V** | *is the volume of the home* |
| **ACH** | *is the desired air changes per hour* |
| **60** | *conversion from hours to minutes* |

Below is a table of the required CFM to meet the different air changes per hour.

|     |  CFM  |
| --- | :---: |
| $ (22,500 \times 3)/60 $ | ***1,125 @ 3 ACH*** |
| $ (22,500 \times 4)/60 $ | ***1,500 @ 4 ACH*** |
| $ (22,500 \times 5)/60 $ | ***1,875 @ 5 ACH*** |

As you can see we have a discrepency of meeting even the low end of 3 ACH. The high end of
5 ACH is over 2x the airflow for our 2.5 Ton system.


