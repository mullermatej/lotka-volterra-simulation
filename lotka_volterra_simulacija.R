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

# ---- ANALIZA OSJETLJIVOSTI PARAMETARA ----
# Testiranje različitih vrijednosti alpha (stopa rasta plijena)
alpha_values <- c(0.05, 0.1, 0.15, 0.2)
sensitivity_results <- list()

for(i in 1:length(alpha_values)) {
  params_temp <- parameters
  params_temp["alpha"] <- alpha_values[i]
  
  out_temp <- ode(y = state, times = times, func = lotka_volterra, parms = params_temp)
  out_temp <- as.data.frame(out_temp)
  out_temp$alpha_value <- alpha_values[i]
  sensitivity_results[[i]] <- out_temp
}

# Kombiniranje rezultata
sensitivity_data <- do.call(rbind, sensitivity_results)
sensitivity_data$alpha_label <- paste("α =", sensitivity_data$alpha_value)

# Grafički prikaz osjetljivosti
sensitivity_plot <- ggplot(sensitivity_data, aes(x = time)) +
  geom_line(aes(y = x, color = "Plijen"), size = 1) +
  geom_line(aes(y = y, color = "Grabežljivac"), size = 1) +
  facet_wrap(~alpha_label, scales = "free_y") +
  labs(title = "Osjetljivost na parametre: Različite vrijednosti α",
       x = "Vrijeme", y = "Populacija", color = "Vrsta") +
  theme_minimal()

print(sensitivity_plot)

# ---- ANALIZA RAZLIČITIH POČETNIH UVJETA ----
initial_conditions <- list(
  c(x = 20, y = 5),
  c(x = 40, y = 9),    # originalne vrijednosti
  c(x = 60, y = 15),
  c(x = 30, y = 20)
)

initial_results <- list()
for(i in 1:length(initial_conditions)) {
  out_temp <- ode(y = initial_conditions[[i]], times = times, 
                  func = lotka_volterra, parms = parameters)
  out_temp <- as.data.frame(out_temp)
  out_temp$condition <- paste("Start:", initial_conditions[[i]]["x"], 
                              "plijena,", initial_conditions[[i]]["y"], "grabežljivaca")
  initial_results[[i]] <- out_temp
}

initial_data <- do.call(rbind, initial_results)

# 1. Vremenski prikaz različitih početnih uvjeta
time_initial_plot <- ggplot(initial_data, aes(x = time, color = condition)) +
  geom_line(aes(y = x, linetype = "Plijen"), size = 1) +
  geom_line(aes(y = y, linetype = "Grabežljivac"), size = 1) +
  labs(title = "Vremenski prikaz: Različiti početni uvjeti",
       x = "Vrijeme", y = "Populacija", 
       color = "Početni uvjeti", linetype = "Vrsta") +
  theme_minimal() +
  theme(legend.position = "bottom")
print(time_initial_plot)

# 2. Fazni prostor: Različiti početni uvjeti
phase_initial_plot <- ggplot(initial_data, aes(x = x, y = y, color = condition)) +
  geom_path(size = 1.2) +
  geom_point(data = initial_data[initial_data$time == 0, ], 
             aes(x = x, y = y), size = 3, shape = 16) +
  labs(title = "Fazni prostor: Različiti početni uvjeti",
       x = "Plijen", y = "Grabežljivac", color = "Početni uvjeti") +
  theme_minimal()
print(phase_initial_plot)

# ---- SPREMANJE PODATAKA ----
write.csv(out, "rezultati_simulacije.csv", row.names = FALSE)

