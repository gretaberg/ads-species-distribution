# gbif.r (purpose) 
# query species occurrence data from gbif 
# clean up the data 
# save it to csv file 
# create a map to display the species occurrence points 

#list of packages to install
packages<-c('tidyverse','rgbif','usethis','CoordinateCleaner','leaflet','mapview')

#install packages that are not yet installed 
installed_packages<-packages %in% rownames(installed.packages())
if(any(installed_packages==FALSE)){
  install.packages(packages[!installed_packages])
}
#packages loading with library functions 
invisible(lapply(packages,library,character.only=TRUE))

usethis::edit_r_environ()
spiderBackbone<-name_backbone(name='habronattus americanus')
speciesKey<-spiderBackbone$usageKey
occ_download(pred('taxonKey',speciesKey),format='SIMPLE_CSV')

d <- occ_download_get('0012224-240202131308920',path='data/') %>%
  occ_download_import()
write_csv(d,'data/rawData.csv')

#cleaning
filterData<-d %>%
  filter(!is.na(decimalLatitude),!is.na(decimalLongitude))
#above gets rid of n/a spots in long/lat 
filterData<-filterData%>%
  filter(countryCode %in% c('US','CA','MX'))
#above keeps all data collect from US, CA, and MX
filterData<-filterData%>%
  filter(!basisOfRecord %in% c('FOSSIL_SPECIMEN','LIVING_SPECIMEN'))
#above gets rid of fossil records and zoo records 
filterData<-filterData%>%
  cc_sea(lon='decimalLongitude',lat='decimalLatitude')
#gets rid of records from the sea 



