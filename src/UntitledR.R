data<-read.csv('data/cleanedData.csv')

library(leaflet)
library(mapview)

map<-leaflet()%>%
  addProviderTiles('Esri.WorldTopoMap')%>%
  addCircleMarkers(data=data,
                   lat= ~decimalLatitude,
                   lng= ~decimalLongitude,
                   radius=3,
                   color='pink',
                   fillOpacity = 1)%>%
  addLegend(position='topright',
            title='Species Occurances from GBIF',
            labels='Habronattus americanus',
            color='pink',
            opacity=1)

mapshot(map,file='images'/leafletTest.png)
