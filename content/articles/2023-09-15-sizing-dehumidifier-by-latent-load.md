---
tags: tech-tip, HVAC, formulas, design
image: https://photos.housh.dev/share/loI_jV-wfvh1V8AeEoWDLiM_PJWcg7C5473hLq6gKa0Rd8r5cPWXHUjE9QKCs78ZuBI
---

# Dehumidifier Sizing by Latent Load

This is a quick article to show how to calculate the size of dehumidifier needed based on the latent
load of a building. This is useful if you've done a load calculation and know the latent load of the
structure.

## Formulas

The formula above is used to solve for the pints per hour required to size a dehumidifier.

| Where |              |
| ----- | ------------ |
| Ql    | Latent load  |
| Ph    | Pints / hour |

We can then convert to pints per day by multiplying the answer by 24 hours, below is the combined
formula.

![pints-per-day-formula](https://photos.housh.dev/share/qI9xZEtT9LEncdciPmMx9434z9vLEVKWEL-ci2Cgfych3tOoMxM5EAVqQlg4Qrek49A)

| Where |             |
| ----- | ----------- |
| Ql    | Latent load |
| Pd    | Pints / day |

In some cases you may want to size the dehumidifier for less than the full latent load, assuming
that the air-conditioner (when sized properly) is going to cover the full latent load when at peak
design temperatures and that the peak latent period for your area is during peak cooling demand.

## Example

Let's imagine we have done a load calculation and have a latent load of 4,334 BTU/h. So, plugging
that into our above formula.

![pints-per-day-formula-example](https://photos.housh.dev/share/ibFnGJxD2DBq6aRTWSHOY91ryxmgATUWQ2BEaa7Wlj3krbofSUgKtpzjSG3BrhDmyyk)

Or if we just want to cover the latent capacity at 85% of the full latent load.

![pints-per-day-formula-example](https://photos.housh.dev/share/yrUSSEMrcgQcVfgfB8NonxbdQV5B60XAufoeuwL3XjTSTbSDxmxYXyon3oSTltMXvY4)

This gives us some guidance that we would need to select a dehumidifier that is rated for 84-99
pints per day, depending on which condition we wanted to use.

I don't feel oversizing a dehumidifier, within reason, is that problematic (or at least it does not
come with the same problems as an oversized air conditioner), so I would personally go for a 100-120
pint per day model dehumidifier in this application.

Thanks for reading!
