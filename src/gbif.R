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




