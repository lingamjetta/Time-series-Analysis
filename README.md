# Time-series-Analysis
This is a Time series analysis for how many passengers are travlling to austrillia each month,
this dataset contains data from 1993 it extract each month.
> str(arivals)
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	128 obs. of  2 variables:
 $ Date              : chr  "1991M01" "1991M02" "1991M03" "1991M04" ...
 $ Number of arrivals: num  27566 27621 25696 21653 21197 ...
 it has 2 variables and 128 observatons.
 ploting the data
ggplot(arivals,aes(x=Date,y=arivals$`Number of arrivals`))+geom_point()
![rplot](https://user-images.githubusercontent.com/24644939/27676282-fcc16b2a-5cca-11e7-9473-c7b89c8180d2.png)

converting normal data to time series data using ts()
### ts_arival=ts(arivals$`Number of arrivals`,start = c(1993,1),frequency = 12)
> checking the time series data using 
is.ts(ts_arival) it gives the "TRUE " if it is time series data

### ploting Time series data
![rplot01](https://user-images.githubusercontent.com/24644939/27676877-4c9a6f82-5ccd-11e7-9e28-b8df2d10d3c0.png)

 From that above we observe that it has terend & seasonality exist in that
 > Using Decomposition we find the trend and seasonlity of the time series
 decom_ts=decompose(ts_arival)
plot(decom_ts)
![rplot02](https://user-images.githubusercontent.com/24644939/27678227-1f0b58b0-5cd2-11e7-8e0a-aed80ed4be09.png)

> From that we have a Uptrend exists and seasonality on every end of the year,
### Applying the holtwiinter model
Holtwiinter model works on when the Time series fallows Trend and seasonality.

"holt_ts=HoltWinters(trian_ts,beta = FALSE,gamma = FALSE,start.periods = 2)" 
print(holt_ts)
"Call:
HoltWinters(x = trian_ts, beta = FALSE, gamma = FALSE, start.periods = 2)

Smoothing parameters:
 alpha: 0.1185768
 beta : FALSE
 gamma: FALSE

Coefficients:
      [,1]
a 42894.18"
> holtwinter uses most recent items to forecast the data
> forecast the  time series
"holt_for=forecast(holt_ts,model="ets",h=28)
 print(holt_for$mean)
 plot(forecast(holt_ts,model="ets",h=28))"
 
 ![holt](https://user-images.githubusercontent.com/24644939/27678557-4a9e12c8-5cd3-11e7-902b-ca78128ee3de.png)
By forecastiing the travling rate is between 45000 p/m

## Find the accuracy 
Time series is a contiinous data so we use 
RMSE,or MSE
"RMSE(test_ts,holt_for$mean)"
# 10463.09
# Applying the ARIMA
ARIMA it works well on statonary data
For checkking the Statonary we have 2 hypothesis test 
## Augmented Dickey-fuller test
adf s hypothesis test checking the statonaryof the time seriesdata if the p--vales is <0.05 it accept the Alternative hypothesis
> if Alternatve hypothesis accept then it is statonary data
"adf.test(trian_ts)"
Augmented Dickey-Fuller Test

data:  trian_ts
Dickey-Fuller = -6.0527, Lag order = 4, p-value = 0.01
alternative hypothesis: stationary
> It is a Statonary data
## KPSS test
It is also similar to adf test but it was opsite to adf test, it accept null hypothesis when the time series is stationary.
kpss.test(trian_ts)
KPSS Test for Level Stationarity

data:  trian_ts
KPSS Level = 1.7985, Truncation lag parameter = 2, p-value = 0.01
> It was a statonary data
## check for Autocorrelation and partial autocorrelaton
Acf is auto-correlation of the time series data and its log values, IIt s used to how many number of MA terms used for ARIMA
i.e. How many lines are negative log values
"acf(trian_ts)"
![acf](https://user-images.githubusercontent.com/24644939/27679260-c84dca36-5cd5-11e7-842f-bb502ead2892.png)

> we have o negative log values so 0 MA terms

pacf it is partial autocorreltion with its log values, it is used to find the number of AR terms in ARIIMA
![pacf](https://user-images.githubusercontent.com/24644939/27681062-8e126a60-5cdb-11e7-9efc-a0a060e91fea.png)
> how many number of positive lines are in the pacf plot we have total AR(2)

## auto.arima
auto.arima(trian_ts)
it is find what are parameters to use for arima

"Series: trian_ts 
ARIMA(2,1,0)                    

Coefficients:
          ar1      ar2
      -0.6382  -0.4916
s.e.   0.0867   0.0858

sigma^2 estimated as 52572161:  log likelihood=-1019.84
AIC=2045.68   AICc=2045.93   BIC=2053.46"

> from that ARIMA(2,1,0) means 2 AR terms,1 Integration and 0 MA terms.
the AIC value was 2045, the model with low AIC is the best model

>  model_ar=arima(trian_ts,order = c(2,1,0))
print(model_ar)
"arima(x = trian_ts, order = c(2, 1, 0))

Coefficients:
          ar1      ar2
      -0.6382  -0.4916
s.e.   0.0867   0.0858

sigma^2 estimated as 51510089:  log likelihood = -1019.84,  aic = 2045.68"
 
# AIC 2045.68
> forecating model
arima_for=forecast(model_ar,h=28)
plot(forecast(model_ar))
![armia_for](https://user-images.githubusercontent.com/24644939/27681397-bb1ff8e6-5cdc-11e7-88bc-73c9a2c6aad5.png)
> the forecast value b/w  40000-50000 
# conclusion ARIMA(2,1,0) with AIC 2045.68 is best model
Thank you!
