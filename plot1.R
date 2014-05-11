plot1 <- function(){
data <- read.table("household_power_consumption.txt",sep = ";")
data_plot <- data[data[,1] == "1/2/2007" | data[,1] == "2/2/2007",]
Clobal_Active_Power <- as.numeric(as.character(data_plot[,3]))

hist(Clobal_Active_Power,xlab = "Clobal Active Power(kilowatts)",main = "Clobal Active Power",col = "red")

dev.copy(png, file = "plot1.png")
dev.off()

}