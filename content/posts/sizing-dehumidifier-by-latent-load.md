---
author: "Michael Housh"
categories: ["Tech-Tips"]
copy: true
date: 2023-09-15T22:31:24-04:00
draft: false
series: "Tech-Tips"
tags: ["Tech-Tips", "HVAC", "Formulas", "Design"]
title: "Dehumidifier Sizing"
---

This is a quick article to show how to calculate the size of dehumidifier needed
based on the latent load of a building. This is useful if you've done a load
calculation and know the latent load of the structure.

## Formulas

The formula to solve for the pints per hour is:

$$ P_h = \frac{Q_l}{1054} $$

| Where |              |
| ----- | ------------ |
| $Q_l$ | Latent load  |
| $P_h$ | Pints / hour |

We can then convert to pints per day by multiplying the answer by 24 hours,
below is the combined formula.

$$ P_d = (\frac{Q_l}{1054}) \times 24 $$

| Where |             |
| ----- | ----------- |
| $Q_l$ | Latent load |
| $P_d$ | Pints / day |

In some cases you may want to size the dehumidifier for less than the full
latent load, assuming that the air-conditioner (when sized properly) is going to
cover the full latent load when at peak design temperatures and that the peak
latent period for your area is during peak cooling demand.

## Example

Let's imagine we have done a load calulation and have a latent load of 4,334
BTU/h. So, plugging that into our above formula.

$$ P_d = (\frac{4334}{1054}) \* 24 = 98.7 $$

Or if we just want to cover the latent capacity at 85% of the full latent load.

$$ P_d = (\frac{4334 \times 0.85 }{1054}) \* 24 = 83.9 $$

This gives us some guidance that we would need to select a dehumidifier that is
rated for 84-99 pints per day, depending on which condition we wanted to use.

I don't feel oversizing a dehumidifier, within reason, is that problematic (or
at least it does not come with the same problems as an oversized air
conditioner), so I would personally go for a 100-120 pint per day model
dehumidifier in this application.

Thanks for reading!
