### This should all work, and probably it takes a bit of time.
### Need to make it a function or set of functions so that it can be easily updated.


# install.packages("curl")
usethis::use_package("curl")

##### Step 1: Download the shapefiles
curl::curl_download( ## 2009 place
  url='ftp://ftp.census.gov/geo/tiger/TIGER2009/45_SOUTH_CAROLINA/tl_2009_45_place.zip',
  './/CensusPlaces2009.zip')
curl::curl_download( ## 2009 block group
  url='ftp://ftp.census.gov/geo/tiger/TIGER2009/45_SOUTH_CAROLINA/tl_2009_45_bg00.zip',
  './/CensusBlockGroups2009.zip')
curl::curl_download( ## 2009 tract
  url='ftp://ftp.census.gov/geo/tiger/TIGER2009/45_SOUTH_CAROLINA/tl_2009_45_tract00.zip',
  './/CensusTracts2009.zip')
curl::curl_download( ## 2010 place
  url='ftp://ftp2.census.gov/geo/pvs/tiger2010st/45_South_Carolina/45/tl_2010_45_place10.zip',
  './/CensusPlaces2010.zip')
curl::curl_download( ## 2010 block group
  url='ftp://ftp2.census.gov/geo/pvs/tiger2010st/45_South_Carolina/45/tl_2010_45_bg10.zip',
  './/CensusBlockGroups2010.zip')
curl::curl_download( ## 2010 tract
  url='ftp://ftp2.census.gov/geo/pvs/tiger2010st/45_South_Carolina/45/tl_2010_45_tract10.zip',
  './/CensusTracts2010.zip')

## The FTP directories are similar for years 2011-2016
for(year in 2011:2016){
  url=paste0('ftp://ftp2.census.gov/geo/tiger/TIGER', year,
             '/PLACE/tl_', year, '_45_place.zip')
  destfile=paste0(".//CensusPlaces", year, ".zip")
  curl::curl_download(url, destfile)

  url=paste0('ftp://ftp2.census.gov/geo/tiger/TIGER', year,
             '/BG/tl_', year, '_45_bg.zip')
  destfile=paste0(".//CensusBlockGroups", year, ".zip")
  curl::curl_download(url, destfile)

  url=paste0('ftp://ftp2.census.gov/geo/tiger/TIGER', year,
             '/TRACT/tl_', year, '_45_tract.zip')
  destfile=paste0('.//CensusTracts', year, '.zip')
  curl::curl_download(url, destfile)
}


for(year in 2009:2016){ ## Unzip all of the files
  zipfile=paste0('CensusTracts', year, '.zip')
  d='CensusTracts'
  unzip(zipfile, exdir=d)

  zipfile=paste0('CensusBlockGroups', year, '.zip')
  d='CensusBlockGroups'
  unzip(zipfile, exdir=d)

  zipfile=paste0('CensusPlaces', year, '.zip')
  d='CensusPlaces'
  unzip(zipfile, exdir=d)
}

## Delete the zip files (manually)

## Merge the unzipped files
usethis::use_package('raster')

tracts <- lapply(2009:2016, function(year){
  list.files(path='./CensusTracts',
             pattern=paste0('tl_',year,'_45_tract[10]*\\.shp$') ) %>%
    paste0("CensusTracts//", .) %>%
    raster::shapefile() -> x
  x@data %<>% dplyr::select(GEOID=4, tractNumber=3,areaLand=9,areaWater=10) %>%
    mutate(year=year)
  x} ) %>% reduce(raster::bind) %>%
  st_as_sf() %>%
  dplyr::mutate(tractNumber = str_sub(GEOID, start=4)) %>%
  dplyr::select(-GEOID)

# tracts <- tracts[!duplicated(select(tracts, -year)),]
## That eliminated over 2,000 polygons

blockGroups <- lapply(2009:2016, function(year){
  list.files(path='./CensusBlockGroups',
             pattern=paste0('tl_',year,'_45_bg[10]*\\.shp$') ) %>%
    paste0('CensusBlockGroups//', .) %>%
    raster::shapefile() -> x
  x@data %<>% dplyr::select(bgNumber=5, areaLand=9, areaWater=10) %>%
    mutate(year=year)
  x} ) %>% reduce(raster::bind) %>%
  st_as_sf()

places <- lapply(2009:2016, function(year){
  list.files(path='./CensusPlaces',
             pattern=paste0('tl_',year,'_45_place[10]*\\.shp$') ) %>%
    paste0("CensusPlaces//", .) %>%
    raster::shapefile() -> x
  x@data %<>% dplyr::select(placeNumber=2) %>%
    mutate(year=year)
  x} ) %>% reduce(raster::bind) %>%
  st_as_sf() %>% arrange(placeNumber, year)

# places <- places[!duplicated(select(places, -year)),]
## That eliminated over 1,000 polygons
## There are now 400 places, 1917 polygons, 8 years...

## Perhaps I should simplify the polygons,
## or use st_equals_exact()
##
# st_equals_exact(x, y, par, sparse = TRUE, prepared = FALSE, dist)

## Goal: a table like this
## ~tractNumber, ~tractID, ~FirstYear, ~LastYear

# saveRDS(blockGroups, 'census_blockGroups.rds')
# saveRDS(tracts, 'census_tracts.rds')
# saveRDS(places, 'census_places.rds')

# The census Tract Numbers provide a unique ID for each tract within a county,
# but the numbers are repeated in different counties.
# Therefore Tract Numbers and County Numbers have been combined to create unique IDs
# for all of the tracts in the State. This allows for a 1:1 join with data downloaded from the ACS.

# TODO: make maps to see the tracts and places change through time.



