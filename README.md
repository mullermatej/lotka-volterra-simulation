# Reinforcement Learning for Ecosystem Stability in a Lotka-Volterra Predator-Prey Model

### Abstract
This project investigates the application of Reinforcement Learning (RL) to maintain ecosystem stability within the classic Lotka-Volterra predator-prey model. A Q-learning agent is trained to manage population dynamics by making discrete interventions, such as adding prey or removing predators. The agent's goal is to learn a policy that prevents the extinction of either species, a common risk in unmanaged Lotka-Volterra simulations. The performance of the trained RL agent is systematically compared against two baseline scenarios: a non-intervention (natural dynamics) model and a random-action agent. Results demonstrate that the RL agent successfully learns a "crisis intervention" strategy, significantly outperforming both baselines by preventing ecosystem collapse in critical, near-extinction scenarios. This work highlights the potential of RL as a tool for proactive and intelligent management of complex ecological systems.

### Project Overview
The entire simulation, from model definition and agent training to results analysis and visualization, is implemented in a single Jupyter Notebook (`lotka_volterra_simulation.ipynb`).

**Core Components:**
- **Lotka-Volterra Model:** The ecosystem dynamics are modeled using the Lotka-Volterra differential equations, solved with SciPy's `odeint` function.
- **Reinforcement Learning Agent:** A Q-learning agent is implemented from scratch.
  - **State Space:** Discretized bins of prey and predator populations.
  - **Action Space:** `[do_nothing, add_prey, remove_predators]`
  - **Reward Function:** The agent is rewarded for maintaining both populations above a minimum threshold and penalized heavily for extinction events.
- **Simulation & Analysis:** The project includes a comparative analysis framework to test the trained agent against baseline models, with results visualized using Matplotlib.

**Technologies Used:**
- **Python:** Core programming language.
- **NumPy:** For numerical operations and Q-table management.
- **SciPy:** For solving the Lotka-Volterra ordinary differential equations (ODEs).
- **Matplotlib:** For data visualization and plotting results.
- **Jupyter Notebook:** For interactive development and presentation.

---
This project was submitted as part of the **Modeling and Simulations** course.

> **Author:** Muller Matej  
> **Faculty:** Faculty of Informatics in Pula  
> **Course:** Modeling and Simulations  
> **Mentors:** Robert Šajina, Darko Etinger
