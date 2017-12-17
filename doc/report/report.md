---
output: github_document
author: "Esteban Angel"
---


# Investment Analysis Report



The purpose of this data analysis project is identifying some patterns of successful and unsuccessful companies in the Standard & Poors index. The S&P 500 is an index of 505 companies in the United States stock market which have a market capitalization of at least $6.1 billion. In other words, it's a group of the most relevant public companies.

[More information about the S&P 500](https://www.investopedia.com/terms/s/sp500.asp)

This patterns can help us select or discard companies from our portfolio. There are two approaches for making investment decisions:

- **Fundamental analysis:** takes the real business indicators from a company to help us decide about investments. This is the approach investors like Warren Buffet use, contrasting the real situation of the business with its stock price in the market. If a company has solid indicators and they aren't reflected in the stock price, there's an opportunity for creating wealth from that difference.

- **Technical analysis:** tries to find patterns in the time series of prices. It's focused in the short term. For this project, all my analysis will be fundamental, based on the financial information of the companies and not the technical analysis.

[More information about Fundamental vs Technical Analysis ](https://www.investopedia.com/university/technical/techanalysis2.asp)

## Question

> Common sense is not so common -Voltaire

Using common sense, we can say that a company is good if it sells a lot, increases its revenue year on year and gives some profit from those sales. I want to analyze with this project if this common-sense assumption is also applied in the stock market, in other words:

Companies that increase their sales and their profits also increase their stock price?


## Hypotheses

For this project I will try to test some hypothesis about the companies in the S&P 500:

1. Companies that increase their revenue year on year also increase their stock price.

2. Companies with high profitability have high investment returns for stockholders.

These hypotheses are general and can give us a snapshot of internal business variables that affect the performance of a stock in the market. In the future, the idea with this project is going to another level of fundamental analysis. I want to find the relationship between the quality of the people leading a business and its results and also analyze their official communications using NLP.

## Results

The first step of the analysis was understanding better the structure of the S&P 500 and the types of companies that make part of it. For analyzing this, I used the variable `market cap`, which is just the total value for all the companies in each sector. We can calculate the market capitalization with the following formula:

$$MarketCap = TotalShares * PricePerShare$$
When we add up the `market_cap` for all the companies in each sector of the S&P 500, we can have a general picture of the most and less important sectors that compose it. I summarized them in the following plot:

![Market Cap per Sector](../../results/figures/eda_plot_2.png)

We can see that Financials, Healthcare and IT companies dominate the index. Additional to the `market_cap` per sector, it's relevant to know the performance of the different companies. For analyzing this, I plotted all the individual year-on-year returns for all the companies on each sector:

![Returns per Sector](../../results/figures/eda_plot_1.png)
We can see that the IT sector slightly outperforms the rest of the sectors and Energy is underperforming compared to the rest. After this overview of the S&P index, we can start analyzing the two hypothesis of this project.

## Hypothesis 1

Using common sense, we would say that a company is in a good situation if it increases its sales and in a bad situation if those sales decrease year on year. Most of the times things are more complicated because behind the variation in revenue other factors can affect the future of a company. But assuming that the rest of the variables are held constant, we can plot the changes in revenue per company in the S&P 500 year on year vs the variation in the stock price in that same period. We get the following scatterplot, which shows a slight linear relationship:

![Var Price vs Var Revenue](../../results/figures/hyp_1_plot_1.png)

Additional to the visual analysis, I fitted a simple linear model comparing these variations in price with the changes in revenue:


|term                          |  estimate| std.error| statistic| p.value|
|:-----------------------------|---------:|---------:|---------:|-------:|
|(Intercept)                   | 0.0998371| 0.0091192|  10.94804|       0|
|var_price_revenue$var_revenue | 0.5168894| 0.0550940|   9.38195|       0|

From the previous linear model, we can see that the slope term is significant. Thus we can say that there's a positive linear relationship between the variation in revenue and the variation in the stock price. In other words, if a company increases the revenue by 1%, holding the rest of the variables constant, the stock price of that company increases a 0.5%. The same occurs with negative variations in revenue.

We can also visualize and group the different stocks with the following behaviors:


|revenue  |price    | num_obs|
|:--------|:--------|-------:|
|Increase |Increase |     497|
|Increase |Decrease |     165|
|Decrease |Increase |     147|
|Decrease |Decrease |     143|

With the previous table, we can see that 67% of the observations in the analysis have an effect in line with the analysis (increase in price with increase in revenue and decrease in price with decreases in revenue). We can also group and visualize the results from the previous table with the following plot:

![BoxPlot Revenue](../../results/figures/hyp_1_plot_2.png)

We can see that the mean and median price variation of the companies with a revenue increase are higher than the ones with decreasing revenue. Now that we validated Hypothesis 1, we can continue analyzing Hypothesis 2.

## Hypothesis 2

Additional to increasing sales, a company should also give some profit from that revenue. The purpose of this hypothesis is finding if there's a relation between the market price and the profit these companies have. For this case, I used the `operating_margin`, which is one of the financial measures of profitability. This indicator is calculated dividing the operating profit (Revenue - Costs - Operating Expenses) by the total revenue. Companies with high `operating_margin` leave a nice amount of money per each dollar sold.

The approach for testing this hypothesis was similar to Hypothesis 1, starting with a scatterplot between both variables and fitting a linear model assuming that the rest of the variables are held constant:

![Scatter Profit](../../results/figures/hyp_2_plot_1.png)
In this case, when we compare the `operating_margin` with the `price_variation` it's hard to identify a trend. Observations with different `operating_margin` are distributed along the y-axis uniformly, which makes it hard to identify a relation between both variables. The next step is fitting a simple linear model that can help us to understand this strange plot:


|term                              |   estimate| std.error| statistic|   p.value|
|:---------------------------------|----------:|---------:|---------:|---------:|
|(Intercept)                       |  0.1485044| 0.0116347| 12.763926| 0.0000000|
|var_price_margin$operating_margin | -0.0011767| 0.0003671| -3.205148| 0.0013949|

In this case, we still get a significant slope, and something curious happens, the estimate is negative, which can be interpreted that on each increase in the operating margin of a company, its stock price will fall. 

Even though the linear relationship is significant, if we see the magnitude of the estimate (0.001) we can say that the effect is not relevant, because we're saying that if we increase the operating margin by 1% (one percent in a billion dollar company is a lot of money), the price of that stock falls -0.11%.

## Conclusion

In reality, there are thousands of variables related to the performance of a stock in the market. The stock market is a combination of emotions that get translated into financial operations, so any of these variables can affect those emotions and change the prices. For this analysis, I focused on simple variables of the results of the companies, but even though they are simple, they reflect a lot of what's occurring inside a company.

Sometimes hedge funds and investors get into complex methods for identifying opportunities for making money and forget simple principles like that a company needs to increase its sales year on year for being sustainable and keep returning profits, which at the end are reflected on prices.

## Next steps

For the next version of this analysis, I want to keep focusing on the simple things about companies and that the most successful investors like Warren Buffet focus on. I want to reflect this opportunity in a reproducible analysis which can be executed each time we want to decide what to buy or sell.
