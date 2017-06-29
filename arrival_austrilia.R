setwd("I:\\kaggle\\Time series analysis\\Time_series_analysis")
#arival from austrilia_monthly
library(caret)
library(car)
library(tseries)
library(TTR)
library(forecast)
library(readxl)
library(ggplot2)
library(Metrics)
#reading the data
arivals=read_xlsx("arrivals_from_australia_monthly.xlsx")
str(arivals)
sum(is.na(arivals))
#explore the data
ggplot(arivals,aes(x=Date,y=arivals$`Number of arrivals`))+geom_point()
#convert to time series data
arivals$Date[100]
ts_arival=ts(arivals$`Number of arrivals`,start = c(1993,1),frequency = 12)
is.ts(ts_arival)
plot.ts(ts_arival)
#we have sesoality and trend in that line
#decomposition 
decom_ts=decompose(ts_arival)
plot(decom_ts)
# Trend and sesonality 
#split train and test
trian_ts=ts_arival[1:100]
test_ts=ts_arival[-c(1:100)]
#apply holtwinter 
?HoltWinters
holt_ts=HoltWinters(trian_ts,beta = FALSE,gamma = FALSE,start.periods = 2)
print(holt_ts)
#forecasting the model
?forecast
holt_for=forecast(holt_ts,model="ets",h=28)
print(holt_for$mean)
plot(forecast(holt_ts,model="ets",h=28))

#rmse of the model
RMSE(test_ts,holt_for$mean) #10463.09
rmse(test_ts,holt_for$mean)
holt_ts$coefficients
#when we apply the arima for this
#for arima check stationary
plot.ts(trian_ts)
plot.ts(diff.default(trian_ts,lag = 1))

#augmented diffy fullren
adf.test(trian_ts)
kpss.test(trian_ts)

#check for acf
acf(trian_ts) #6
pacf(trian_ts)#2
#apply the auto arima
auto.arima(trian_ts)
model_ar=arima(trian_ts,order = c(2,1,0))
print(model_ar) #2045.68 

#forecasting the arima
arima_for=forecast(model_ar,h=28)
plot(forecast(model_ar))
print(arima_for$mean)
RMSE(test_ts,arima_for$mean)
pacf(model_ar$residuals)
