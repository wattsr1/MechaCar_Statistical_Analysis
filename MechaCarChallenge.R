library(dplyr)
library(car)
library(ggplot2)

MechCar_mpg <- read.csv("MechaCar_mpg.csv")
model <- (lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data= MechCar_mpg)) # Generate multiple linear regressions for mpg
summary(model)
avPlots(model)

Suspension_coil <- read.csv("../MechaCar_Statistical_Analysis/Suspension_Coil.csv")
total_summary <- summarize(Suspension_coil, Mean=mean(PSI),Median=median(PSI),Variance=var(PSI), SD=sd(PSI)) # Create a dataframe containing the summary statistics of the suspension coils
lot_summary <- Suspension_coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI),Median=median(PSI),Variance=var(PSI), SD=sd(PSI), .groups = 'keep') ## Create a dataframe containing the summary statistics of the suspension coils by lot

plt <- ggplot(Suspension_coil, aes(y=PSI,x=Manufacturing_Lot))
plt + geom_boxplot()

ttest_coildata_pop <- t.test(Suspension_coil$PSI, mu = 1500) # TTest comparing the d
t.test(Suspension_coil$PSI, mu = 1500)

coil_lot1 = subset(Suspension_coil, Manufacturing_Lot == "Lot1")
coil_lot2 = subset(Suspension_coil, Manufacturing_Lot == "Lot2")
coil_lot3 = subset(Suspension_coil, Manufacturing_Lot == "Lot3")

t.test(coil_lot1$PSI, mu = 1500)
t.test(coil_lot2$PSI, mu = 1500)
t.test(coil_lot3$PSI, mu = 1500)


t.test(coil_lot1$PSI, coil_lot2$PSI, paired = T)
t.test(coil_lot2$PSI, coil_lot3$PSI, paired = T)
t.test(coil_lot1$PSI, coil_lot3$PSI, paired = T)

summary(aov(PSI ~ Manufacturing_Lot, data=Suspension_coil))# Conduct an ANOVA analysis of the PSI between lots to determine if there is a statistically significant difference between them

