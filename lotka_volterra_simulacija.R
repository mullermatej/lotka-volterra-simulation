# ========================================
# Lotka-Volterra simulacija (Plijen - Predator)
# ========================================

# ---- UČITAVANJE PAKETA ----
if(!require(deSolve)) install.packages("deSolve", dependencies = TRUE)
if(!require(ggplot2)) install.packages("ggplot2", dependencies = TRUE)

library(deSolve)
library(ggplot2)

# ---- DEFINICIJA MODELA ----
lotka_volterra <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    dx <- alpha * x - beta * x * y      # Rast plijena
    dy <- delta * x * y - gamma * y     # Rast grabežljivca
    list(c(dx, dy))
  })
}

# ---- PARAMETRI I STANJE ----
parameters <- c(
  alpha = 0.1,   # stopa rasta plijena
  beta  = 0.02,  # utjecaj grabežljivca na plijen
  delta = 0.01,  # koristi za grabežljivca od plijena
  gamma = 0.1    # stopa smrtnosti grabežljivca
)

state <- c(
  x = 40,  # inicijalni broj plijena
  y = 9    # inicijalni broj grabežljivaca
)

times <- seq(0, 200, by = 1)

# ---- SIMULACIJA ----
out <- ode(y = state, times = times, func = lotka_volterra, parms = parameters)
out <- as.data.frame(out)

# ---- GRAFIČKI PRIKAZ ----

# 1. Populacije kroz vrijeme
pop_plot <- ggplot(out, aes(x = time)) +
  geom_line(aes(y = x, color = "Plijen"), size = 1.2) +
  geom_line(aes(y = y, color = "Grabežljivac"), size = 1.2) +
  labs(title = "Lotka-Volterra: Populacije kroz vrijeme",
       x = "Vrijeme", y = "Populacija", color = "Vrsta") +
  theme_minimal()

print(pop_plot)

# 2. Fazni prostor
phase_plot <- ggplot(out, aes(x = x, y = y)) +
  geom_path(color = "darkblue", size = 1) +
  labs(title = "Fazni prostor (x = plijen, y = grabežljivac)",
       x = "Plijen", y = "Grabežljivac") +
  theme_minimal()

print(phase_plot)

# ---- SPREMANJE PODATAKA (opcionalno) ----
write.csv(out, "rezultati_simulacije.csv", row.names = FALSE)

# ---- KRAJ ----
