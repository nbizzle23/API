# API

#HTTP Verbs
#GET- Retrieve whatever is specified by the URL
#POST- Create resource at URL with data in body
#PUT- Update resource at URL with data in body
#DELETE- Delete resource at URL


#httr Request
library(httr)
r <- GET("http://httpbin.org/get")

#headers
r <- GET("http://httpbin.org/get", 
         add_headers(Name="Nick"))

#body
url <- "http://httpbin.org/post"
body <- list(a=1,b=2,c=3)
r<- POST(url, body = body, encode = "form")
r<- POST(url, body = body, encode = "multipart")
r<- POST(url, body = body, encode = "raw")
r<- POST(url, body = body, encode = "json")

#JSON- JavaScript Object Notation
#Standard data format for web APIs
#{
#"Title": "Frozen",
#"Year": "2013",
#"Rated": "PG",
#"Released": "27 Nov 2013"
#}


#jsonlite
library(jsonlite)
toJSON(list(a = 1, b = 2, c = 3))

fromJSON('{"a":[1],"b":[2],"c":[3]}' )

#verbose()
#To view the HTTP request that httr sends
r <- GET("http://httpbin.org/get", verbose())

#Response

#Status
#Extract status with $status_code or http_status() 
r$status_code
http_status(r)

#Program defensiveky with warn_for_status() and stop_for_status()
r2 <- r
r2$status_code <- 404
warn_for_status(r2)
stop_for_status(r2)

#Headers
#Exact headers with headers()
headers(r)
headers(r)$server

#Content
#Extract content from the body with $content or content()
r$content
content(r,"raw") #As raw
content(r, "text") # As text
content(r, "parse") #named list

#Example
library(httr)
#MY API KEY
#apikey=4461e58e

#Frozen Example

#URL for the movie frozen with API key
url <- "http://www.omdbapi.com/?apikey=4461e58e&t=frozen&y=2013&plot=short&r=json"
frozen <- GET(url)
frozen

#Parse the contents of the url into $ 
details <- content(frozen, "parse")
details

#Year in which the movie was released
details$Year

#Dataframe 
frozendf<- as.data.frame(details)
frozendf
View(frozendf)


#More than a game example
url1 <- "http://www.omdbapi.com/?t=more+than+a+game&apikey=4461e58e"

mtag <- GET(url1)
mtag

details1 <- content(mtag, "parse")
details1

#Dataframe
mtagdf <- as.data.frame(details1)
mtagdf
View(mtagdf)


#Combine dataframes
moviedf <- rbind(mtagdf,frozendf)
moviedf
View(moviedf)
