library(httr)
library(jsonlite)
library(rlist)
library(dplyr)
library(lubridate)

client_id <- 'BUHR3VE5RXUS1GAFWZA6KJEAVCDR53P1'
symbol <- 'AAPL'

price_endpoint <- paste0('https://api.tdameritrade.com/v1/marketdata/',symbol,'/pricehistory')
payload = list(apikey = client_id, periodType = 'day', period = '10', frequencyType = 'minute', frequency='15')

request = GET(url = price_endpoint, query = payload)
response <- content(request, as = "text", encoding = "UTF-8")
price <- fromJSON(response, flatten = TRUE) %>% data.frame()
price <- select(price, 
                symbol,
                datetime = candles.datetime,
                open = candles.open,
                high = candles.high,
                low = candles.low,
                close = candles.close,
                volume = candles.volume
)
price$datetime = as_datetime(price$datetime/1000)
price

symbol = 'AAPL'
quotes_endpoint <- paste0('https://api.tdameritrade.com/v1/marketdata/',symbol,'/quotes')
payload = list(apikey = client_id)
request <- GET(url = quotes_endpoint, query = payload)

response <- content(request, as = "text", encoding = "UTF-8")
quotes <- fromJSON(response, flatten = TRUE) %>% data.frame()
t(quotes)

