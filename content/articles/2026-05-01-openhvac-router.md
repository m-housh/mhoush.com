---
tags:
  - HVAC
  - open-source
  - controls
---

# Open HVAC Control:

## A Case for an Open, Local-First Signal Router

This article is a thought experiment and derived from notes surrounding the custom controls that I
built for my system.

Based primarily on the following frustrations:

- Can not control desired fan speed based on IAQ events
- Not many controls that allow reheat dehumidification
- Not many controls that offer dew-point based dehumidification setpoint
- I hate vendor lock-in / prefer self hosted options (I think this a reason why most "new" control
  companies fail to achieve that much adoption unless they're owned by google or amazon that has
  large marketing spend / reach)

### Introduction

Residential HVAC systems sit at the intersection of comfort, energy, air quality, and safety. Yet
thleir control systems remain largely closed, fragmented, inflexible, and outdated.

At one end of the spectrum, conventional 24V thermostats are simple, reliable, and interoperable  
, but limited. At the other end, proprietary communicating systems unlock advanced performance but
at the cost of openness, flexibility, and user control.

This creates an unnecessary tradeoff:

- **Open + flexible** → limited control capability
- **Advanced + efficient** → vendor lock-in

This document proposes:

An **open, local-first HVAC control layer** built around a modular **signal router architecture**
that augments, not replaces, existing systems.

## Core Concept: HVAC Signal Routing

Traditional thermostat signals collapse multiple behaviors into one. In reality, HVAC control
consists of separate domains:

- Thermostat intent
- Indoor airflow behavior
- Outdoor compressor behavior
- Accessory control

An open control system separates these and enables:

- High airflow without compressor
- Ventilation with or without cooling/heating
- IAQ-driven recirculation
- Better humidity-aware operation

## The Device: HVAC Signal Router

We need a new device class, it should act as a local control backplane.

### Architecture

Thermostat → HVAC Signal Router → Indoor / Outdoor / Accessories

The HVAC signal router sits in-between the conventional thermostat signal and the output of that
signal to the equipment. Giving it the opportunity to log the signal / intent, interrupt the signal,
and/or pass through the signal.

The router also could connect:

- Sensors
- Control algorithms
- Data logging pipelines
- Be the integration point for IOT hubs / control planes

## Design Principles

The following design principles are non-negotiable.

### Local First

- Works without cloud
- Cloud optional
- Data stays local (optional cloud storage)

### Fail-Safe

- Thermostat still works if system fails
- Physical/logical bypass supported

### OEM Safety Preserved

- Equipment handles safety internally
- Open system handles supervisory control

### Domain Separation

Signals are endpoint-specific:

- thermostat.Y1
- indoor.Y1
- outdoor.Y1

This allows control isolation in order to control fan speed independently from the outdoor unit
operation, for example.

## LEGO Architecture

The "lego" architecture is just how I make it make sense in my mind ;)

The concept would be that modules (legos) should be able to be added to the router based on the
specific application.

```
                      ┌────────────┐
                      │ Thermostat │
                      └──────┬─────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ HVAC signal      │
                    │ router/backplane │
                    └─────┬─────┬──────┘
                          │  ▲  │
          ┌───────────────┘  │  └───────────────┐
          ▼                  │                  ▼
 ┌─────────────────┐         │         ┌──────────────────┐
 │ Indoor equipment│         │         │ Outdoor equipment│
 │ blower / heat   │         │         │ compressor / HP  │
 └─────────────────┘         │         └──────────────────┘
                             │
                             ▼
             sensors / IAQ / dampers / accessories
                             ▲
                             │
                             ▼
                algorithms + data logging
```

### Hardware Modules

- Relay modules (outputs)
- Sensor modules
- Input modules
- Accessory modules

Modules expose **ports** (functionality), not fixed roles. This is so the architecture is scalable
to different usecases. The modules themselves declare the capability that they have. They
"introduce" themselves to the router, declaring the capabilities they have.

### Software Recipes

Reusable strategies:

- IAQ recirculation
- Ventilation
- Humidity control
- Energy optimization

## Control Model

Algorithms submit **time-limited proposals (leases)**.

Example:

- Assert indoor airflow
- Block compressor
- Expire automatically

No permanent overrides.

This just means don't allow the router to set a desired state permenantly, it should be for a small
window of time and require feedback to continue in that state.

## Arbitration

Multiple algorithms may exist, but a local arbiter resolves:

Safety > Manual > Thermostat > IAQ > Energy

This is the one authority that drives outputs based on state and signals from the different modules.

## Data Logging

Four layers:

1. State
2. Events
3. Cycles
4. Summaries

Example insights:

- What was requested vs executed
- Runtime by equipment
- IAQ effectiveness
- Energy usage patterns

## Why This Matters

- Full observability
- No vendor lock-in
- Better IAQ control
- Energy optimization
- Contractor-friendly diagnostics

## Adoption Strategy

1. Start with 24V systems
2. Build signal routers
3. Standardize data + control
4. Integrate with platforms
5. Expand ecosystem

Incremental adoption is possible. Only use the services / modules that you need.

## Long-Term Vision

- Open HVAC ecosystem
- Modular hardware
- Portable algorithms
- Local-first control
- Optional cloud (because lets face it most folks don't wanna run their own infastructure, except me
  ;)
- If mass adoption is reached then there's higher odds the manufacturers will open avenues for
  "proprietary" controls to integrate.

## Conclusion

This approach does not replace HVAC systems that we know and love... It unlocks them!

By separating signals, enabling modular control, and standardizing data, HVAC becomes:

- Programmable
- Observable
- Reliable
- Open

While still working when everything “smart” is turned off.
