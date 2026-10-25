# ---- Project information ----
# Environmental Water Quality Data QA and Analysis
# Dataset: ECCC Fraser River Long-term Water Quality Monitoring Data
# Focus: Total barium, turbidity, and nonfilterable residue
# Tools: Microsoft Access, R, ggplot2
# Date: 2026-10-18


# ---- 0. Setup ----

if (!require(readxl)) install.packages("readxl")
if (!require(ggplot2)) install.packages("ggplot2")

library(readxl)
library(ggplot2)

# Create folder for chart exports if it does not exist
if (!dir.exists("images")) {
  dir.create("images")
}


# ---- 1. Load data ----

# Load all-samples dataset exported from Microsoft Access
barium_data <- read_excel(
  "data/qryQA_BariumTurbidityAllSamples.xlsx"
)

# Load verified paired dataset for the main analysis
barium_verified <- read_excel(
  "data/qryQA_BariumTurbidityVerified.xlsx"
)

# Inspect dataset structure and records
head(barium_data)
str(barium_data)

head(barium_verified)
str(barium_verified)

# Check column names and record counts
names(barium_data)
nrow(barium_data)

names(barium_verified)
nrow(barium_verified)


# ---- 2. Data exploration ----

# Summary statistics for verified paired data
summary(barium_verified)

# Check missing values in analysis variables
colSums(
  is.na(
    barium_verified[
      c("Barium_ugL", "Turbidity_NTU", "Residue_mgL")
    ]
  )
)

# Examine distributions of key measurements
summary(barium_verified$Barium_ugL)
summary(barium_verified$Turbidity_NTU)
summary(barium_verified$Residue_mgL)


# ---- 3. Spearman correlation analysis ----

# Correlation between barium and turbidity
cor_barium_turbidity <- cor.test(
  barium_verified$Barium_ugL,
  barium_verified$Turbidity_NTU,
  method = "spearman",
  exact = FALSE
)

print(cor_barium_turbidity)

# Correlation between barium and nonfilterable residue
cor_barium_residue <- cor.test(
  barium_verified$Barium_ugL,
  barium_verified$Residue_mgL,
  method = "spearman",
  exact = FALSE
)

print(cor_barium_residue)


# ---- 4. Sensitivity analysis ----

# Exclude the highest observed barium concentration (259 µg/L)
barium_sensitivity <- subset(
  barium_verified,
  Barium_ugL != 259
)

# Check the number of remaining observations
nrow(barium_sensitivity)

# Recalculate correlation between barium and turbidity
cor_sensitivity_turbidity <- cor.test(
  barium_sensitivity$Barium_ugL,
  barium_sensitivity$Turbidity_NTU,
  method = "spearman",
  exact = FALSE
)

print(cor_sensitivity_turbidity)

# Recalculate correlation between barium and nonfilterable residue
cor_sensitivity_residue <- cor.test(
  barium_sensitivity$Barium_ugL,
  barium_sensitivity$Residue_mgL,
  method = "spearman",
  exact = FALSE
)

print(cor_sensitivity_residue)


# ---- 5. Chart 1: Barium vs. turbidity ----

# Extract Spearman correlation coefficient for annotation
rho_turbidity <- round(
  unname(cor_barium_turbidity$estimate),
  3
)

# Create scatterplot
plot_turbidity <- ggplot(
  barium_verified,
  aes(x = Turbidity_NTU, y = Barium_ugL)
) +
  geom_point(alpha = 0.7, size = 2) +
  geom_point(
    data = subset(barium_verified, Barium_ugL == 259),
    color = "red",
    size = 3
  ) +
  annotate(
    "text",
    x = Inf,
    y = Inf,
    label = paste("Spearman rho =", rho_turbidity),
    hjust = 1.1,
    vjust = 1.5,
    size = 4
  ) +
  labs(
    title = "Total Barium vs. Turbidity",
    subtitle = "Fraser River water quality monitoring | Site BC08MF0001",
    x = "Turbidity (NTU)",
    y = "Total barium (µg/L)",
    caption = "Red point: highest observed barium concentration (259 µg/L)."
  ) +
  theme_minimal(base_size = 12)

# Display chart
print(plot_turbidity)

# Save scatterplot as PNG
ggsave(
  "images/barium_vs_turbidity.png",
  plot = plot_turbidity,
  width = 8,
  height = 5.5,
  dpi = 300
)


# ---- 6. Chart 2: Barium vs. nonfilterable residue ----

# Extract Spearman correlation coefficient for annotation
rho_residue <- round(
  unname(cor_barium_residue$estimate),
  3
)

# Create scatterplot
plot_residue <- ggplot(
  barium_verified,
  aes(x = Residue_mgL, y = Barium_ugL)
) +
  geom_point(alpha = 0.7, size = 2) +
  geom_point(
    data = subset(barium_verified, Barium_ugL == 259),
    color = "red",
    size = 3
  ) +
  annotate(
    "text",
    x = Inf,
    y = Inf,
    label = paste("Spearman rho =", rho_residue),
    hjust = 1.1,
    vjust = 1.5,
    size = 4
  ) +
  labs(
    title = "Total Barium vs. Nonfilterable Residue",
    subtitle = "Fraser River water quality monitoring | Site BC08MF0001",
    x = "Nonfilterable residue (mg/L)",
    y = "Total barium (µg/L)",
    caption = "Red point: highest observed barium concentration (259 µg/L)."
  ) +
  theme_minimal(base_size = 12)

# Display chart
print(plot_residue)

# Save scatterplot as PNG
ggsave(
  "images/barium_vs_residue.png",
  plot = plot_residue,
  width = 8,
  height = 5.5,
  dpi = 300
)


# ---- 7. Regression-line charts ----

# Add linear regression line to barium vs. turbidity chart
plot_turbidity_regression <- plot_turbidity +
  geom_smooth(
    method = "lm",
    se = TRUE
  )

# Display chart
print(plot_turbidity_regression)

# Save chart with regression line
ggsave(
  "images/barium_vs_turbidity_regression_line.png",
  plot = plot_turbidity_regression,
  width = 8,
  height = 5.5,
  dpi = 300
)

# Add linear regression line to barium vs. residue chart
plot_residue_regression <- plot_residue +
  geom_smooth(
    method = "lm",
    se = TRUE
  )

# Display chart
print(plot_residue_regression)

# Save chart with regression line
ggsave(
  "images/barium_vs_residue_regression_line.png",
  plot = plot_residue_regression,
  width = 8,
  height = 5.5,
  dpi = 300
)


# ---- 8. Results summary ----

# Display number of paired observations
cat("Verified paired observations:", nrow(barium_verified), "\n")

# Display full-dataset correlation coefficients
cat(
  "Barium vs. turbidity Spearman rho:",
  round(unname(cor_barium_turbidity$estimate), 3),
  "\n"
)

cat(
  "Barium vs. nonfilterable residue Spearman rho:",
  round(unname(cor_barium_residue$estimate), 3),
  "\n"
)

# Display sensitivity analysis correlation coefficients
cat(
  "Turbidity correlation excluding 259 µg/L:",
  round(unname(cor_sensitivity_turbidity$estimate), 3),
  "\n"
)

cat(
  "Residue correlation excluding 259 µg/L:",
  round(unname(cor_sensitivity_residue$estimate), 3),
  "\n"
)

# Confirm chart export location
cat("Four charts saved in the images folder.\n")