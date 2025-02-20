---
tags: HVAC, design
---

# Coil Bypass Overview

This is the first article in a series that explores the idea of a coil bypass strategy in an HVAC system. This article introduces you to a
coil bypass strategy at a high level, future posts will dive deeper into the features, benefits, as well as the challenges of this style of
system.

## What is a Coil Bypass

A coil bypass is not to be mistaken for a zoning system bypass, where airflow is "relieved" from the supply side of the system back into the
return. Instead, a coil bypass diverts a portion of the airflow around the coil using a bypass damper(s). The bypass can serve several
functions depending on the application, but in general it allows for a constant volume of air to be delivered to the space while the output
of the coil can be shifted towards more or less dehumidification. In other words, it decouples the total system airflow from the coil
airflow.

The bypassed air mixes with the supply air stream to act as a reheat source, however unlike a typical reheat source it does not add more
sensible load to the structure, instead it just brings the supply air temperature closer to the existing home's temperature while still
covering the latent and sensible loads of the home. A warmer duct system reduces the losses of the duct to unconditioned spaces as well as
reduces the risk for duct condensation.

The coil bypass strategy, as far as I know, was pioneered by [Harry Boody](https://www.linkedin.com/in/harry-boody-9b8a4366/) of Energy
Innovations and Scientific Environmental Design, Inc. However their websites are no longer active, so I'm not sure if they are still active
in the HVAC design space or not.

## The Problem

| Why      |                                                                  |
| -------- | ---------------------------------------------------------------- |
| Question | Why would we want to utilize a strategy such as the coil bypass? |
| Answer   | Improved indoor air quality (IAQ)                                |

ASHRAE's recommandation for the amount of air changes per hour (ACH) in a residential structure to be in the range of 3-5 ACH, and in
general the higher the better, along with a MERV 13+ filter. In some / most cases the system airflow does not meet that criteria, especially
low load homes or high volume homes.

For example, let's imagine a single story ranch home that is 2,500 square feet with 9 foot ceilings. This home is relatively tight
construction and after doing the heating and cooling loads we've selected a 2.5 Ton system for this home. It is located in a green grass
climate that needs some priority on dehumidification and requires an airflow of 350 CFM/Ton (875 CFM).

We determine the volume of the conditioned space.

2,500 x 9 = 22,500 ft^3

![volume-equation](/articles/images/2023-08-10-volume-equation.png)

| **Where:** |                                       |
| ---------- | ------------------------------------- |
| **V**      | _is the volume of the home_           |
| **ACH**    | _is the desired air changes per hour_ |
| **60**     | _conversion from hours to minutes_    |

Below is a table of the required CFM to meet the different air changes per hour.

|                 |         CFM         |
| --------------- | :-----------------: |
| (22,500 x 3)/60 | **_1,125 @ 3 ACH_** |
| (22,500 x 4)/60 | **_1,500 @ 4 ACH_** |
| (22,500 x 5)/60 | **_1,875 @ 5 ACH_** |

As you can see we have a discrepency of meeting even the low end of 3 ACH. The high end of 5 ACH is over 2x the airflow for our 2.5 Ton
system. The coil bypass strategy is one viable way, by decoupling the total system airflow from the coil airflow without, which eliminates
the need of an auxilary fan / system that circulates air through some sort of filtration system.

### Multi-Stage Systems

A challenge with multi-stage systems, even when sized properly, is that we often run at part-load conditions, and spend the majority of the
time in lower stages. The lower stages often do worse at dehumidification than when running at full load.

When the equipment runs in lower stages on a traditional system the total system airflow is reduced even further from the recommended air
changes per hour. This reduced airflow also causes the throw of the air from the registers to be reduced which can lead to increased odds of
stratification, poor air mixing, and increased potential for poor mean radiant temperatures (MRT) of the surfaces. The decreased airflow in
low stages, lowers the velocity in the duct system, while low velocity is not a concern, it does increase the duct gains and increase the
possibility of condensation on the ducts when they're located outside of the thermal envelope of the building.

Let's imagine we have a duct system that has high wall registers located in a soffit at the interior wall that moves 100 CFM and we are
trying to throw the air to the exterior wall which includes a window. The wall is @ 12 feet from the register. We've selected a register
that meets the criteria, at high stage airflow it has a throw of 11.5 feet (shown as the green rectangle). When the system runs in low
stage, the airflow is reduced to 70% of high stage (70 CFM), which would give us a throw from the register of @ 7 feet (shown as the red
rectangle).

![register-throw](/articles/images/2023-08-10-register-throw.png)

The reduced flow through the register causes the air to only make it about 60% across the room before reaching it's terminal velocity, which
can cause the room to feel uncomfortable since the air never reaches the exterior wall and window.

By decoupling the fan from the coil airflow it is possible to run in low stages, still have adequate dehumidification performance out of the
system, and achieve the proper throw from the registers.

## Conclusion

In this article we've begun to scratch the surface of what a coil bypass strategy is in an HVAC system, as well as some of the challenges
that it can help solve. We've learned about why we may desire to decouple the total system airflow from the coil airflow.

In future articles we will continue to explore some of the features, benefits, and challenges presented by such a strategy.

## Related Resources

[HVAC School - Bypass Dehumidification / Airflow HVAC Design](https://hvacrschool.com/bypass-dehumidification-airflow-hvac-design/)
