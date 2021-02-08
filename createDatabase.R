# Michael Glushchenko
# Last edited: 02/08/2021
library(tidyverse)
library(dplyr)
library(RSQLite)

#constants used in code
DATABASE_NAME <- "stonks.db"
DESIRED_COLUMN_NAMES <- c("time", "open", "high", "low", "close",
                          "ema_34", "ema_21", "ema_13", "ema_9", 
                          "volume", "volume_ma_20", "ema_55",
                          "ema_89", "ema_144", "ema_233", "macd_histogram",
                          "macd", "signal", "mfi", "rsi")
#list of all table names
CURRENT_TABLE_NAMES <- list("TOTAL_MARKET_CAP_MINUTE", "TOTAL_MARKET_CAP_HOUR",
                          "TOTAL_MARKET_CAP_DAY", "TOTAL_MARKET_CAP_MONTH",
                          "TOTAL2_MARKET_CAP_MINUTE", "TOTAL2_MARKET_CAP_HOUR",
                          "TOTAL2_MARKET_CAP_DAY", "TOTAL2_MARKET_CAP_MONTH",
                          "BTC_USDT_MINUTE", "BTC_USDT_HOUR",
                          "BTC_USDT_DAY", "BTC_USDT_MONTH",
                          "ETH_USDT_MINUTE", "ETH_USDT_HOUR",
                          "ETH_USDT_DAY", "ETH_USDT_MONTH",
                          "ZIL_USDT_MINUTE", "ZIL_USDT_HOUR",
                          "ZIL_USDT_DAY", "ZIL_USDT_MONTH",
                          "LINK_USDT_MINUTE", "LINK_USDT_HOUR",
                          "LINK_USDT_DAY", "LINK_USDT_MONTH",
                          "DOT_USDT_MINUTE", "DOT_USDT_HOUR",
                          "DOT_USDT_DAY", "DOT_USDT_MONTH",
                          "GRT_USDT_MINUTE", "GRT_USDT_HOUR",
                          "GRT_USDT_DAY", "GRT_USDT_MONTH",
                          "THETA_USDT_MINUTE", "THETA_USDT_HOUR",
                          "THETA_USDT_DAY", "THETA_USDT_MONTH")
# set up correct directory
getwd()
setwd("/Users/Mike/Desktop/stonks")

# I downloaded all csv files from tradingview.com by exporting data
# here we load the csv files into dataframes
# put the dataframes into lists to make database creating easier

total_market_cap_min <- read.csv("candlestick_data/crypto_cap_total/min.csv")
total_market_cap_hour <- read.csv("candlestick_data/crypto_cap_total/hour.csv")
total_market_cap_day <- read.csv("candlestick_data/crypto_cap_total/day.csv")
total_market_cap_month <- read.csv("candlestick_data/crypto_cap_total/month.csv")

total <- list(total_market_cap_min, total_market_cap_hour,
         total_market_cap_day, total_market_cap_month)

total2_market_cap_min <- read.csv("candlestick_data/crypto_cap_total2/min.csv")
total2_market_cap_hour <- read.csv("candlestick_data/crypto_cap_total2/hour.csv")
total2_market_cap_day <- read.csv("candlestick_data/crypto_cap_total2/day.csv")
total2_market_cap_month <- read.csv("candlestick_data/crypto_cap_total2/month.csv")

total2 <- list(total2_market_cap_min, total2_market_cap_hour,
               total2_market_cap_day, total2_market_cap_month)

btc_usdt_binance_min <- read.csv("candlestick_data/btc_usdt_binance/min.csv")
btc_usdt_binance_hour <- read.csv("candlestick_data/btc_usdt_binance/hour.csv")
btc_usdt_binance_day <- read.csv("candlestick_data/btc_usdt_binance/day.csv")
btc_usdt_binance_month <- read.csv("candlestick_data/btc_usdt_binance/month.csv")

btc <- list(btc_usdt_binance_min, btc_usdt_binance_hour,
            btc_usdt_binance_day, btc_usdt_binance_month)

eth_usdt_binance_min <- read.csv("candlestick_data/eth_usdt_binance/min.csv")
eth_usdt_binance_hour <- read.csv("candlestick_data/eth_usdt_binance/hour.csv")
eth_usdt_binance_day <- read.csv("candlestick_data/eth_usdt_binance/day.csv")
eth_usdt_binance_month <- read.csv("candlestick_data/eth_usdt_binance/month.csv")

eth <- list(eth_usdt_binance_min, eth_usdt_binance_hour,
            eth_usdt_binance_day, eth_usdt_binance_month)

zil_usdt_binance_min <- read.csv("candlestick_data/zil_usdt_binance/min.csv")
zil_usdt_binance_hour <- read.csv("candlestick_data/zil_usdt_binance/hour.csv")
zil_usdt_binance_day <- read.csv("candlestick_data/zil_usdt_binance/day.csv")
zil_usdt_binance_month <- read.csv("candlestick_data/zil_usdt_binance/month.csv")

zil <- list(zil_usdt_binance_min, zil_usdt_binance_hour,
            zil_usdt_binance_day, zil_usdt_binance_month)

link_usdt_binance_min <- read.csv("candlestick_data/link_usdt_binance/min.csv")
link_usdt_binance_hour <- read.csv("candlestick_data/link_usdt_binance/hour.csv")
link_usdt_binance_day <- read.csv("candlestick_data/link_usdt_binance/day.csv")
link_usdt_binance_month <- read.csv("candlestick_data/link_usdt_binance/month.csv")

link <- list(link_usdt_binance_min, link_usdt_binance_hour,
            link_usdt_binance_day, link_usdt_binance_month)

dot_usdt_binance_min <- read.csv("candlestick_data/dot_usdt_binance/min.csv")
dot_usdt_binance_hour <- read.csv("candlestick_data/dot_usdt_binance/hour.csv")
dot_usdt_binance_day <- read.csv("candlestick_data/dot_usdt_binance/day.csv")
dot_usdt_binance_month <- read.csv("candlestick_data/dot_usdt_binance/month.csv")

dot <- list(dot_usdt_binance_min, dot_usdt_binance_hour,
            dot_usdt_binance_day, dot_usdt_binance_month)

grt_usdt_binance_min <- read.csv("candlestick_data/grt_usdt_binance/min.csv")
grt_usdt_binance_hour <- read.csv("candlestick_data/grt_usdt_binance/hour.csv")
grt_usdt_binance_day <- read.csv("candlestick_data/grt_usdt_binance/day.csv")
grt_usdt_binance_month <- read.csv("candlestick_data/grt_usdt_binance/month.csv")

grt <- list(grt_usdt_binance_min, grt_usdt_binance_hour,
            grt_usdt_binance_day, grt_usdt_binance_month)

theta_usdt_binance_min <- read.csv("candlestick_data/theta_usdt_binance/min.csv")
theta_usdt_binance_hour <- read.csv("candlestick_data/theta_usdt_binance/hour.csv")
theta_usdt_binance_day <- read.csv("candlestick_data/theta_usdt_binance/day.csv")
theta_usdt_binance_month <- read.csv("candlestick_data/theta_usdt_binance/month.csv")

theta <- list(theta_usdt_binance_min, theta_usdt_binance_hour,
            theta_usdt_binance_day, theta_usdt_binance_month)

#list of everything used in the study so far
cryptoList <- list(total, total2, btc, eth, zil, link, dot, grt, theta)


#open connection for the SQLite database
currentConnect <- dbConnect(RSQLite::SQLite(), DATABASE_NAME)


#for deleting all tables in the database
#(useful for testing and building the actual database)
'''
for (i in CURRENT_TABLE_NAMES){
  dbRemoveTable(currentConnect, i)
}
'''

createDatabase <- function(tempConnect, tableNames, tableList){
  counter <- 1
  for(i in tableList){
    for(j in i){
      colnames(j) <- DESIRED_COLUMN_NAMES
      dbWriteTable(tempConnect, tableNames[[counter]], j)
      counter <- counter + 1
    }
  }
}

createDatabase(currentConnect, CURRENT_TABLE_NAMES, cryptoList)
dbDisconnect(currentConnect)