---
tags: HVAC, design
summary: Why should design for higher than nominal airflow.
public: true
---

# A Case For Higher Airflow

In this article we'll explore the case of why I believe we should strive for higher than nominal
airflow in our designs.

## The Reason

The primary reason for higher than nominal airflow is that we can provide better IAQ and better
mixing, especially when we also incorporate a high MERV filter.

## The Problem

I've struggled to find the original document that got me thinking about this topic, but I believe it
was an ASHRAE publication or perhaps an EPA document, that was talking about the required ACH (Air
Changes per Hour) for common rooms in residential buildings.

In this context I am not talking about ACH in terms of fresh air / ventilation. I'm talking about
how many times the room air passes across the filter and is replaced with fresh / clean air.

### Recommended ACH in Residential Rooms

| Room Type     | ACH Requirements |
| ------------- | ---------------- |
| Basements     | 3-4              |
| Bedrooms      | 5-6              |
| Bathrooms     | 6-7              |
| Living Rooms  | 6-8              |
| Kitchens      | 6-8              |
| Laundry Rooms | 8-9              |

## An Example Home

As an experiment, I decided to do a fake load calculation of the first floor layout of my house.

![floor plan](/articles/images/2025-02-22-floor-plan.png)

Which resulted in the following loads:

| Room           | Heating                                         | Cooling (Total)                                  | Volume                                         |
| -------------- | ----------------------------------------------- | ------------------------------------------------ | ---------------------------------------------- |
| Entry          | <span class="text-red-500">7,659</span>         | <span class="text-blue-500">2,916</span>         | <span class="text-orange">1,872</span>         |
| Master Bedroom | <span class="text-red-500">7,577</span>         | <span class="text-blue-500">2,076</span>         | <span class="text-orange">3,238</span>         |
| Living Room    | <span class="text-red-500">6,945</span>         | <span class="text-blue-500">6,829</span>         | <span class="text-orange">2,604</span>         |
| Bedroom-1      | <span class="text-red-500">3,288</span>         | <span class="text-blue-500">2,472</span>         | <span class="text-orange">3,061</span>         |
| Kitchen        | <span class="text-red-500">3,893</span>         | <span class="text-blue-500">5,069</span>         | <span class="text-orange">3,913</span>         |
| Family Room    | <span class="text-red-500">9,160</span>         | <span class="text-blue-500">7,446</span>         | <span class="text-orange">2,711</span>         |
| **Totals**     | <span class="text-red-500"><b>43,426</b></span> | <span class="text-blue-500"><b>28,028</b></span> | <span class="text-orange"><b>17,399</b></span> |

## Formula

To calculate the required CFM to achieve a certain ACH the following formula can be used.

$$ CFM = \frac{V \times ACH}{60} $$

| Where   |                              |
| ------- | ---------------------------- |
| $ V $   | The volume of the room       |
| $ ACH $ | The desired ACH for the room |

## Analyzing Design CFM vs. ACH

After the loads were done, I generated a fake Manual-D with some random duct fittings and reasonable
system airflow rates for equipment that would likely be used, in order to come up with the following
airflows for the rooms.

I then ran each room through the above formula to compare the results, which shows the percentages
of CFM required by the ACH calculation vs. the CFM from the Manual-D design.

| Room           | ACH - Target | CFM - Design | CFM - ACH | Percent (Low)                              | Percentage (High)                       |
| -------------- | ------------ | ------------ | --------- | ------------------------------------------ | --------------------------------------- |
| Entry          | 6-7          | 176          | 187       | <span class="text-orange">94.0%</span>     | <span class="text-red-500">70.5%</span> |
| Master Bedroom | 5-6          | 174          | 270       | <span class="text-red-500">64.5%</span>    | <span class="text-red-500">53.7%</span> |
| Living Room    | 5-6          | 92           | 217       | <span class="text-red-500">42.4%</span>    | <span class="text-red-500">35.3%</span> |
| Bedroom-1      | 6-7          | 254          | 306       | <span class="text-orange">83.0%</span>     | <span class="text-red-500">62.2%</span> |
| Kitchen        | 7-8          | 190          | 457       | <span class="text-red-500">41.6%</span>    | <span class="text-red-500">36.4%</span> |
| Family Room    | 6-7          | 279          | 271       | <span class="text-green-500">102.9%</span> | <span class="text-red-500">77.2%</span> |

- <span class="text-green-500"><b><u>Green</u></b></span> = Percentage is >= to 100%
- <span class="text-orange"><b><u>Orange</u></b></span> = Percentage is >= 80% (probably acceptable)
- <span class="text-red-500"><b><u>Red</u></b></span> = Percentage is < 80%

As you can see the only room that is <span class="text-green-500"><b><u>ok</u></b></span> is the
Family Room using the lowest target. A few other rooms are <span
class="text-orange"><b><u>moderate</u></b></span> using the lowest target. Once we use the highest
targets all rooms <span
class="text-red-500"><b><u>fail</u></b></span>.

> **Note:** It should be noted that on a low load home this problem would likely get worse / harder
> to achieve than this one where the air infiltration was set to the generic `average`. We also must
> consider that this ASSumes fan running at full speed all the time, which is simply not how modern
> equipment generally runs.

## Solutions

One solution, would be to utilize a
[coil-bypass](https://mhoush.com/articles/2023/coil-bypass-overview/) design strategy where can
decouple the coil airflow from the total system airflow.

Another solution would be in-room air filter devices, such as the
[Comparetto Cube](https://www.energyvanguard.com/blog/how-make-high-merv-diy-portable-air-cleaner),
or the [Santa-Fe HEPA Filter](https://www.santa-fe-products.com/product/air-purifier/).

## Conclusion

Based on the example calculations done and recent designs I've done, it is evident that most duct
designs and equipment selections are not going to meet the requirements for the recommended ACH of a
room.

Modern homes and equipment are built to meet "efficiency" standards that will make this even harder
to accomplish. To this point, I often feel that we just end up creating efficiency standards that
just shift the energy usage to accessory devices or equipment. There is no free lunch, the fact is
that it takes energy to create a safe, healthy, and comfortable indoor environment!

Duct leakage, pressure imbalances (MAD Air), and ducts outside the envelope make this more of a
challenge / trade off to achieve in certain climate zones.

As an industry we can barely get simple systems right, so adding complexity doesn't help, however I
think this a valid topic to at least begin to reason / think about.

Lastly, thank you for reading through to the end. I hope that you've found value in this article.

- [Load Calculation and Other Resources](https://drive.google.com/drive/folders/1FWyMJVKBg_oGXE8WSWcmW26FeQIY5U06?usp=sharing)
