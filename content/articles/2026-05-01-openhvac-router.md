---
image: https://mhoush.com/articles/images/2026-05-01-openhvac-router.png
tags:
  - HVAC
  - open-source
  - controls
---

# Open HVAC Control: A Case for an Open, Local-First Signal Router

## Introduction

Residential HVAC systems sit at the intersection of comfort, energy, air quality, and safety. Yet
their control systems remain largely closed, fragmented, and inflexible.

At one end of the spectrum, conventional 24V thermostats are simple, reliable, and interoperable  
but limited. At the other end, proprietary communicating systems unlock advanced performance but at
the cost of openness, flexibility, and user control.

This creates an unnecessary tradeoff:

- **Open + flexible** → limited control capability
- **Advanced + efficient** → vendor lock-in

This document proposes:

An **open, local-first HVAC control layer** built around a modular **signal router architecture**
that augments — not replaces — existing systems.

---

## Core Concept: HVAC as Signal Routing

Traditional thermostat signals collapse multiple behaviors into one. In reality, HVAC control
consists of separate domains:

- Thermostat intent
- Indoor airflow behavior
- Outdoor compressor behavior
- Accessory control

An open system separates these.

This enables:

- High airflow without compressor
- Ventilation without cooling
- IAQ-driven recirculation
- Humidity-aware operation

---

## The Device: HVAC Signal Router

A new device class:

**HVAC Signal Router**

It acts as a local control backplane.

### Architecture

Thermostat → Signal Router → Indoor / Outdoor / Accessories

The router also connects:

- Sensors
- Control algorithms
- Data logging pipeline

---

## Design Principles

### Local First

- Works without cloud
- Cloud optional
- Data stays local

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

---

## LEGO Architecture

### Hardware Modules

- Relay modules (outputs)
- Sensor modules
- Input modules
- Accessory modules

Modules expose **ports**, not fixed roles.

### Software Recipes

Reusable strategies:

- IAQ recirculation
- Ventilation
- Humidity control
- Energy optimization

---

## Control Model

Algorithms submit **time-limited proposals (leases)**.

Example:

- Assert indoor airflow
- Block compressor
- Expire automatically

No permanent overrides.

---

## Arbitration

Multiple algorithms may exist.

A local arbiter resolves:

Safety > Manual > Thermostat > IAQ > Energy

One authority drives outputs.

---

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

---

## Why This Matters

- Full observability
- No vendor lock-in
- Better IAQ control
- Energy optimization
- Contractor-friendly diagnostics

---

## Adoption Strategy

1. Start with 24V systems
2. Build signal routers
3. Standardize data + control
4. Integrate with platforms
5. Expand ecosystem

---

## Long-Term Vision

- Open HVAC ecosystem
- Modular hardware
- Portable algorithms
- Local-first control
- Optional cloud

---

## Conclusion

This approach does not replace HVAC systems.

It unlocks them.

By separating signals, enabling modular control, and standardizing data, HVAC becomes:

- Programmable
- Observable
- Reliable
- Open

While still working when everything “smart” is turned off.
