---
tags: formulas, HVAC, tech-tip
image: https://photos.housh.dev/share/c4OvpS6w6IK00NPwavqkyyAkt1VgpjQCgq7urPGoBfsQ0iC0AjkzLF_KetTXmB9KwoM
---

# Calculate SEER Degradation by Age

This is a quick tech-tip to learn how to calculate the degradation of SEER based on age.

The degradation of SEER is due to fouling of the evaporator coil with dirt and refrigerant charge
losses. It should be noted that this is not true for all applications, but is used as an estimation
based on research done by the `DOE` of the average degradation based on systems tested.

## Formula

This is the formula used to calculate the SEER based on age of the evaporator coil / air handler.

$$ SEER_d = SEER_n \times (1 - M)^{age} $$

| Where      |                                            |
| ---------- | ------------------------------------------ |
| $ SEER_d $ | Degradated SEER rating                     |
| $ SEER_n $ | Nominal SEER rating when equipment was new |
| $ M $      | Maintenance factor, 0.01-0.03              |
| $ age $    | The age of the equipment, in years         |

The maintenance factor of 0.01 is for expertly maintained equipment and 0.03 is for unmaintained.
The maintenance factor in essence is based on 1%-3% degradation per year, however there are some
[studies](https://publications.energyresearch.ucf.edu/wp-content/uploads/2018/09/FSEC-PF-474-18.pdf)
that show that this can actually be as high as 5% or above depending on climate. We could use up to
0.05 as the maintenance factor, just to see what the "range" of degradation would be.

Interestingly, the study linked also shows that the degradation is higher the higher the tonnage of
the equipment. It also shows that the degradation is lower per year the higher the nominal SEER
rating of the system, which is correlated to using TXV's and lower airflow rates because of the
equipment having multiple stages.

## Example

Let's consider that we have a 13 SEER piece of equipment that was matched when installed and the
system is 15 years old.

Plugging those numbers into our formula.

---

#### Lowest Range (1% degradation / year)

$$ SEER_d = 13 \times (1 - 0.01)^{15} = 11.2 $$

---

#### Highest Range (5% degradation / year)

$$ SEER_d = 13 \times (1 - 0.05)^{15} = 6 $$

---

An expertly maintained system may not have degraded that much, with an 11.2 SEER vs. a poorly
maintained / dirty system that also suffers from refrigerant charge losses can be as low as 6 SEER.

Thanks for learning how to estimate SEER degradation based on equipment age!
