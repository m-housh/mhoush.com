---
tags: tech-tip, HVAC, formulas, psychrometrics, psychrometric-chart
---

# Pounds of Water Removed

This is an article that shows how to calculate the pounds of water removed from an air stream, given the entering conditions (return air
stream) and the outlet conditions (supply air stream).

This is useful in the field when you want to calculate the amount of moisture removed from an air-conditioner or a dehumidifier. This
article assumes that you have knowledge of a psychrometric chart. If you do not have basic knowledge of the psychrometric chart, then here
are a couple articles to familiarize yourself.

## Articles

- [Understand Dew-Point](https://hvacrschool.com/understand-dew-point-absolute-moisture-right-side-psych-chart/)
- [Impact of Adding or Removing Water from Air](https://hvacrschool.com/the-impact-of-adding-or-removing-water-from-air/)

## Scenario

Let's imagine that we have an air-conditioner that has the following measurements taken:

- Return Air: 75° / 50% RH
- Supply Air: 55° / 81% RH

We plot the two values on the psychrometric chart (black line represents the return air conditions and blue line represents the supply air
conditions).

![chart](/articles/images/2023-09-08-pounds-of-water-removed.png)

We start by finding the corresponding dry-bulb temperature at the bottom of the chart and draw a straight line up to where it intersects the
relative humidity curve. After that we draw a straight line to the right side of the psychrometric chart to find the grains of moisture per
pound of air.

This gives us the following values:

- Return Air: 66 gr/lb
- Supply Air: 52 gr/lb

We can then use the following formula to calculate the pounds of water removed.

![formula](/articles/images/2023-09-08-formula.png)

| **Where**    |                                                          |
| ------------ | -------------------------------------------------------- |
| **W**        | _Weight of water in pounds per hour_                     |
| **4.5**      | _Constant based on density / specific heat of moist air_ |
| **CFM**      | _Airflow in cubic feet per minute_                       |
| **&#8710;G** | _Difference in grains of moisture_                       |
| **7000**     | _Constant based on grains of moisture in saturated air_  |

## Solution

First, we solve for the difference in grains between the two air streams.

&#8710;G = 66 - 52 = 14

Next, we've measured our airflow and have determined to have **797 CFM** of airflow across the evaporator coil, so we can substitute our
values into the formula.

![solution](/articles/images/2023-09-08-solution.png)

So, we are removing about 7 pounds of water per hour at these conditions.

Another thing to note is that 1 pound of water is approximately 1 pint of water, which can be useful when working with dehumidifiers that
can often be rated in pints per day.

I hope you've found this article helpful, thanks for reading!
