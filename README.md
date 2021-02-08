# cryptoRegAnalysis

## SQLite database containing: 
* Total cryptocurrency market cap.
* Total cryptocurrency market cap excluding BTC.
* BTC/USDT.
* ETH/USDT.
* LINK/USDT.
* ZIL/USDT.
* DOT/USDT.
* GRT/USDT.
* THETA/USDT.

## For every given ticker, we collected the following info:
* High, Open, Low, and Close data points for 4 different timeframes.
* 8 EMA indicator values.
* Standard MACD, MFI 14, RSI 14.

## Goals:
* First, we attempt to use R to perform regression analysis, analysis of variance, and a graphical analysis on this data to find patterns and trends in this market. 
* Develop a trading strategy based off these findings
* Attempt to optimize the strategy via machine learning and AI
* Backtest the strategies
* Towards the end, the goal is to create a paper detailing the problem, approach, and results of this project.

## Technologies used so far:
* R through RStudio
* SQLite Database

## Sources:
* [TradingView Charts](https://tradingview.com)
* [Finviz Data](https://finviz.com)
* [Fibonacci Sequence Applications](https://www.investopedia.com/articles/trading/05/advfibonacci.asp)
* [SQLite Usage Through DBI](https://db.rstudio.com/dbi)
