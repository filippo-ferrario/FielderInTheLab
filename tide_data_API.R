

# from 'https://rdrr.io/github/yonghah/esri2sf/f/README.md'
#-------------------------------------------------------------
library(esri2sf)

# url <- "http://sampleserver6.arcgisonline.com/arcgis/rest/services/Census/MapServer/layers"
url <-'http://sampleserver6.arcgisonline.com/arcgis/rest/services/Census/MapServer/layers?dynamicLayers=[{"id":101,"source":{"type":"mapLayer","mapLayerId":0}}]&amp;f=pjson'
df <- esri2sf(url)


# from 'https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html'
#-------------------------------------------------------------
library(httr)
library(jsonlite)


a<-GET('http://sampleserver6.arcgisonline.com/arcgis/rest/services/Census/MapServer/layers?dynamicLayers=[{"id":101,"source":{"type":"mapLayer","mapLayerId":0}}]&amp;f=pjson')
a<-GET("http://sampleserver6.arcgisonline.com/arcgis/rest/services/Census/MapServer/layers?f=pjson") # this gives a "text/plain"
http_type(a)

a<-GET("http://sampleserver6.arcgisonline.com/arcgis/rest/services/Census/MapServer/layers?f=json") # this gives a "application/json"
http_type(a)
res<-jsonlite::fromJSON(content(a, "text"), simplifyVector = TRUE)

str(res)





a<-GET("https://gisp.dfo-mpo.gc.ca/arcgis/rest/services/FGP/TidalStations_EN/MapServer/2?f=json") # this gives a "application/json"
http_type(a)
res<-jsonlite::fromJSON(content(a, "text"), simplifyVector = FALSE)
res2<-jsonlite::fromJSON('https://gisp.dfo-mpo.gc.ca/arcgis/rest/services/FGP/TidalStations_EN/MapServer/2?f=json', simplifyVector = FALSE) # funziona senza passare da "httr"

adim<-GET('https://gisp.dfo-mpo.gc.ca/arcgis/rest/services/FGP/TidalStations_EN/MapServer/2?dynamicLayers=[{"STATION_NUMBER":2780}]&amp;f=json')
http_type(adim)
adim

res3<-jsonlite::fromJSON('https://gisp.dfo-mpo.gc.ca/arcgis/rest/services/FGP/TidalStations_EN/MapServer/2?f=json', simplifyVector = FALSE) 

GET('https://ws-shc.qc.dfo-mpo.gc.ca/observations;?format=json')

# guardare qui: http://marees.gc.ca/docs/Specifications%20-%20Spine%20observation%20and%20predictions%202.0.3(en).pdf
# guardare qui: https://cran.r-project.org/web/views/WebTechnologies.html