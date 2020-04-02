library(corrplot)


#Load the data 
data <- read.csv(file.choose())
names(data)
summary(data) # Summary Statistics 
data$Vessel <- NULL # Removing character for our analysis
c <-cor(data)
corrplot(c, method = "circle")

#Based on Correlation Analysis removing variables which are not needed for the predict model
data$SaleDate <-NULL
data$YearBuilt <- NULL


# Plot of Price
hist(data$Price,
     main="Histogram of Ship Prices",
     xlab="Price",
     xlim=c(20,160),
     col="darkmagenta",
     breaks = 10
)


#Regression Plots as per Individual Variables
plot(data$Age.at.Sale, data$Price, col = "red" , main = " Age to Price Linear Regression Line" , xlab = "Age (In Years)" , ylab = " Price (In Milions)")
abline(lm(Price~Age.at.Sale, data = data), col = "blue")

plot(data$DWT, data$Price, col = "red" , main = " DWT to Price Linear Regression Line" , xlab = "DWT (In Tonnes)" , ylab = " Price (In Milions)")
abline(lm(Price~DWT, data = data), col = "blue")

plot(data$Capesize, data$Price, col = "red" , main = " Capesize to Price Linear Regression Line" , xlab = "Capesize (Index)" , ylab = " Price (In Milions)")
abline(lm(Price~Capesize, data = data), col = "blue")


# Creating a lm predict Model 
model <- lm(Price~., data = data, method ="qr")
summary(model)
datanew <- data.frame(Age.at.Sale = c(11), DWT = c(172), Capesize = c(12479))
predict(model,newdata = datanew) #Predicted price of the Bet-Performer 
model$fitted.values

# COnfidence Interval 
predict(model,newdata = datanew , interval = "confidence")




#The above Model is a simple Multiple Linear Regression Model #

