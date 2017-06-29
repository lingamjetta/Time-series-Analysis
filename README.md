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
