# Michael Glushchenko
# Last edited: 02/08/2021
library(tidyverse)
library(dplyr)
library(RSQLite)

#constants used in code
DATABASE_NAME <- "stonks.db"

currConn <- dbConnect(RSQLite::SQLite(), DATABASE_NAME)

btcMinChart <- dbGetQuery(currConn, "SELECT * FROM BTC_USDT_MINUTE
                          WHERE ema_233 != 'NA'")
total2MinChart <- dbGetQuery(currConn, "SELECT * FROM TOTAL2_MARKET_CAP_MINUTE
                             WHERE ema_233 != 'NA'")


length(btcMinChart[["open"]])
length(total2MinChart[["open"]])
