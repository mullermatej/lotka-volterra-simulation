# Lotka-Volterra Simulation in R

This project demonstrates a basic simulation of an ecosystem with two interacting species — prey and predator — using the Lotka-Volterra system of differential equations.

## Description

The model is based on the following equations:

- dx/dt = αx - βxy  
- dy/dt = δxy - γy

Where:
- x(t): number of prey at time t  
- y(t): number of predators at time t  
- α: natural growth rate of prey  
- β: rate at which predators consume prey  
- δ: rate of predator reproduction based on prey availability  
- γ: natural death rate of predators  

The simulation is implemented using the `deSolve` package in R, and the results are visualized using `ggplot2`.

## Contents

- `lotka_volterra_simulation.R` – main R script for running the simulation and plotting the results  
- `simulation_results.csv` – output data from the simulation  
- Plots:
  - Population over time (prey and predator)
  - Phase space diagram (prey vs predator)

## How to Run

1. Open the project in RStudio  
2. Run the `lotka_volterra_simulation.R` script  
3. The plots will be displayed, and a CSV file with simulation results will be saved

---

This project was developed as part of the **Modeling and Simulations** course  
at the **Faculty of Informatics, University of Pula**.

**Course:** Distributed Systems  
**Mentor:** izv. prof. dr. sc. Darko Etinger
