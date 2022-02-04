library(dplyr)
library(car)
library(ggplot2)

MechCar_mpg <- read.csv("../MechaCar_Statistical_Analysis/MechaCar_mpg.csv")
model <- (lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data= MechCar_mpg)) # Generate multiple linear regressions for mpg
summary(model)
avPlots(model)

Suspension_coil <- read.csv("../MechaCar_Statistical_Analysis/Suspension_Coil.csv")
total_summary <- summarize(Suspension_coil, Mean=mean(PSI),Median=median(PSI),Variance=var(PSI), SD=sd(PSI)) # Create a dataframe containing the summary statistics of the suspension coils
lot_summary <- Suspension_coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI),Median=median(PSI),Variance=var(PSI), SD=sd(PSI), .groups = 'keep') ## Create a dataframe containing the summary statistics of the suspension coils by lot

plt <- ggplot(Suspension_coil, aes(y=PSI,x=Manufacturing_Lot))
plt + geom_boxplot()

plt <- ggplot(Suspension_coil,aes(x=PSI)) #import coil compression data into ggplot2
plt + geom_density() #visualize distribution using density plot

ttest_coildata_pop <- t.test(Suspension_coil$PSI, mu = 1500) # TTest comparing the coil compression data against the population mean of 1500psi
t.test(Suspension_coil$PSI, mu = 1500)

coil_lot1 = subset(Suspension_coil, Manufacturing_Lot == "Lot1") # Create dataframe for coil compression data for lot 1
coil_lot2 = subset(Suspension_coil, Manufacturing_Lot == "Lot2") # Create dataframe for coil compression data for lot 2
coil_lot3 = subset(Suspension_coil, Manufacturing_Lot == "Lot3") # Create dataframe for coil compression data for lot 3

plt <- ggplot(coil_lot1,aes(x=PSI)) #import coil compression data for lot 1 into ggplot2
plt + geom_density() #visualize distribution using density plot
plt <- ggplot(coil_lot2,aes(x=PSI)) #import coil compression data for lot 2 into ggplot2
plt + geom_density() #visualize distribution using density plot
plt <- ggplot(coil_lot3,aes(x=PSI)) #import coil compression data for lot 3 into ggplot2
plt + geom_density() #visualize distribution using density plot

t.test(coil_lot1$PSI, mu = 1500) # One sample t-Test for lot 1 against population mean of 1500psi
t.test(coil_lot2$PSI, mu = 1500) # One sample t-Test for lot 2 against population mean of 1500psi
t.test(coil_lot3$PSI, mu = 1500) # One sample t-Test for lot 3 against population mean of 1500psi


t.test(coil_lot1$PSI, coil_lot2$PSI, paired = T) # two sample t-Test comparing mean lot 1 against mean of lot 2
t.test(coil_lot2$PSI, coil_lot3$PSI, paired = T) # two sample t-Test comparing mean lot 2 against mean of lot 3
t.test(coil_lot1$PSI, coil_lot3$PSI, paired = T) # two sample t-Test comparing mean lot 1 against mean of lot 3

summary(aov(PSI ~ Manufacturing_Lot, data=Suspension_coil))# Conduct an ANOVA analysis of the PSI between lots to determine if there is a statistically significant difference between them

