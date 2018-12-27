######### Step 2: Download the data

## American Community Survey
install.packages("acs", clean=T)
library("acs")
api.key.install(key="4d1207bf6480c1a036041e923323700e8d73c7f6")
acs.tables.install()

## Census tracts
tracts <- geo.make(state="South Carolina", county="*",
                   tract="*", check=TRUE)

## Census block groups didn't work until I specified all the counties.
# test <- geo.lookup(state="South Carolina", county="*")
counties <- c(1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,
              31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,
              61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91)
blockGroups <- geo.make(state="South Carolina", county=counties, tract="*",
                        block.group="*", check=TRUE)

## Census places
places <- geo.make(state="South Carolina", place="*", check=TRUE)

## Census zip codes
## Unlike for the other areas, zip codes have to be listed.
## I guess they overlap state lines . . .

## For some reason, these zip codes don't work...
# 29002, 29021, 29041, 29071, 29116, 29132, 29143, 29151, 29171, 29177, 29211,
# 29214, 29215, 29216, 29217, 29218, 29219, 29220, 29221, 29222, 29224, 29226,
# 29227, 29228, 29230, 29240, 29250, 29260, 29290, 29292, 29304, 29305, 29318,
# 29319, 29336, 29342, 29348, 29386, 29390, 29391, 29395, 29402, 29413, 29415,
# 29416, 29417, 29419, 29422, 29425, 29430, 29433, 29442, 29447, 29457, 29465,
# 29476, 29484, 29502, 29503, 29504, 29528, 29542, 29551, 29573, 29578, 29587,
# 29589, 29597, 29598, 29602, 29603, 29604, 29606, 29608, 29610, 29612, 29616,
# 29622, 29623, 29632, 29633, 29636, 29641, 29647, 29648, 29652, 29656, 29675,
# 29677, 29679, 29688, 29695, 29698, 29703, 29716, 29721, 29722, 29731, 29734,
# 29744, 29802, 29804, 29808, 29813, 29822, 29839, 29846, 29861, 29901, 29903,
# 29913, 29914, 29925, 29931, 29933, 29938,

zipcodes <- geo.make(
  check=TRUE, zip.code=c(
    29001, 29003, 29006, 29009, 29010, 29014, 29015, 29016, 29018, 29020, 29030,
    29031, 29032, 29033, 29036, 29037, 29038, 29039, 29040, 29042, 29044, 29045,
    29046, 29047, 29048, 29051, 29052, 29053, 29054, 29055, 29056, 29058, 29059,
    29061, 29062, 29063, 29065, 29067, 29069, 29070, 29072, 29073, 29074, 29075,
    29078, 29079, 29080, 29081, 29082, 29101, 29102, 29104, 29105, 29107, 29108,
    29111, 29112, 29113, 29114, 29115, 29117, 29118, 29122, 29123, 29125, 29126,
    29127, 29128, 29129, 29130, 29133, 29135, 29137, 29138, 29142, 29145, 29146,
    29147, 29148, 29150, 29152, 29153, 29154, 29160, 29161, 29162, 29163, 29164,
    29166, 29168, 29169, 29170, 29172, 29175, 29178, 29180, 29201, 29202, 29203,
    29204, 29205, 29206, 29207, 29208, 29209, 29210, 29212, 29223, 29225, 29229,
    29301, 29302, 29303, 29306, 29307, 29316, 29320, 29321, 29322, 29323, 29324,
    29325, 29329, 29330, 29331, 29332, 29333, 29334, 29335, 29338, 29340, 29341,
    29346, 29349, 29351, 29353, 29355, 29356, 29360, 29364, 29365, 29368, 29369,
    29370, 29372, 29373, 29374, 29375, 29376, 29377, 29378, 29379, 29384, 29385,
    29388, 29401, 29403, 29404, 29405, 29406, 29407, 29409, 29410, 29412, 29414,
    29418, 29420, 29423, 29424, 29426, 29429, 29431, 29432, 29434, 29435, 29436,
    29437, 29438, 29439, 29440, 29445, 29446, 29448, 29449, 29450, 29451, 29452,
    29453, 29455, 29456, 29458, 29461, 29464, 29466, 29468, 29469, 29470, 29471,
    29472, 29474, 29475, 29477, 29479, 29481, 29482, 29483, 29485, 29487, 29488,
    29492, 29493, 29501, 29505, 29506, 29510, 29511, 29512, 29516, 29518, 29519,
    29520, 29525, 29526, 29527, 29530, 29532, 29536, 29540, 29541, 29543, 29544,
    29545, 29546, 29547, 29550, 29554, 29555, 29556, 29560, 29563, 29564, 29565,
    29566, 29567, 29568, 29569, 29570, 29571, 29572, 29574, 29575, 29576, 29577,
    29579, 29580, 29581, 29582, 29583, 29584, 29585, 29588, 29590, 29591, 29592,
    29593, 29594, 29596, 29601, 29605, 29607, 29609, 29611, 29613, 29614, 29615,
    29617, 29620, 29621, 29624, 29625, 29626, 29627, 29628, 29630, 29631, 29634,
    29635, 29638, 29639, 29640, 29642, 29643, 29644, 29645, 29646, 29649, 29650,
    29651, 29653, 29654, 29655, 29657, 29658, 29659, 29661, 29662, 29664, 29665,
    29666, 29667, 29669, 29670, 29671, 29672, 29673, 29676, 29678, 29680, 29681,
    29682, 29683, 29684, 29685, 29686, 29687, 29689, 29690, 29691, 29692, 29693,
    29696, 29697, 29702, 29704, 29706, 29708, 29709, 29710, 29712, 29714, 29715,
    29717, 29718, 29720, 29724, 29726, 29727, 29728, 29729, 29730, 29732, 29733,
    29741, 29742, 29743, 29745, 29801, 29803, 29805, 29809, 29810, 29812, 29816,
    29817, 29819, 29821, 29824, 29826, 29827, 29828, 29829, 29831, 29832, 29834,
    29835, 29836, 29838, 29840, 29841, 29842, 29843, 29844, 29845, 29847, 29848,
    29849, 29850, 29851, 29853, 29856, 29860, 29899, 29902, 29904, 29905, 29906,
    29907, 29909, 29910, 29911, 29912, 29915, 29916, 29918, 29920, 29921, 29922,
    29923, 29924, 29926, 29927, 29928, 29929, 29932, 29934, 29935, 29936, 29939,
    29940, 29941, 29943, 29944, 29945))


# 1 year estimates aren't available by tract, but they are available by "Place".
# 5 year estimates are available by tract and block group.

#### Median Household Income in the past 12 months table.number="B19013""
## Need to adjust for inflation.
blockGroupIncome <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names='pretty', geography=blockGroups, endyear=x,
                 table.number='B19013')
  tibble(year=x, countyNumber=y@geography$county,
         tractNumber=y@geography$tract, blockgroup=y@geography$blockgroup,
         blockgroupName=y@geography$NAME, estimate=y@estimate[,1],
         standard.error=y@standard.error[,1]) } ) %>% bind_rows()

tractsIncome <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names="pretty", geography=tracts, endyear=x, table.number="B19013")
  tibble(year=x, countyNumber=y@geography$county,
         tractNumber=y@geography$tract, tractName=y@geography$NAME,
         estimate=y@estimate[,1], standard.error=y@standard.error[,1] )
} ) %>% bind_rows() %>%
  mutate(tractNumber = paste0(countyNumber, tractNumber) %>%
           str_pad(8, "left", "0")) %>%
  select(-countyNumber)

## from 2009 to 2015, there were >300 'places' where 5 year values are reported
placesIncome <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names="pretty", geography=places, endyear=x, table.number="B19013")
  tibble(year=x, placeNumber=y@geography$place, placeName=y@geography$NAME,
         estimate=y@estimate[,1], standard.error=y@standard.error[,1] ) } ) %>% bind_rows()

## from 2012 to 2016, there were 3-6 'places' where 1 year values are reported
placesIncome1yr <- lapply(2012:2016, function(x){
  y <- acs.fetch(span=1, col.names="pretty", geography=places, endyear=x, table.number="B19013")
  tibble(year=x, placeNumber=y@geography$place, placeName=y@geography$NAME,
         estimate=y@estimate[,1], standard.error=y@standard.error[,1] ) } ) %>% bind_rows()

#### Units in Structure, table.number="B25024"
blockGroupUnits <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names='pretty', geography=blockGroups, endyear=x, table.number="B25024")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, countyNumber=county, tractNumber=tract,
                            blockgroup=blockgroup, blockgroupName=NAME)) %>%
    mutate(year=x) } ) %>% bind_rows()

tractsUnits <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names="pretty", geography=tracts, endyear=x, table.number="B25024")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, countyNumber=county,
                            tractNumber=tract, tractName=NAME)) %>%
    gather(key=`Structure Type`, value=`Count`, -tractNumber, -tractName, -countyNumber) %>%
    mutate(year=x)
  standard.errors <- as.tibble(y@standard.error) %>%
    gather(key=`Structure Type`, value="standard.error")
  bind_cols(estimates, select(standard.errors, standard.error) ) } ) %>% bind_rows() %>%
  mutate(tractNumber = paste0(countyNumber, tractNumber) %>%
           str_pad(8, "left", "0")) %>%
  select(-countyNumber)

placesUnits <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names="pretty", geography=places, endyear=x, table.number="B25024")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, placeNumber=place, placeName=NAME)) %>%
    gather(key=`Structure Type`, value=`Count`, -placeNumber, -placeName) %>%
    mutate(year=x)
  standard.errors <- as.tibble(y@standard.error) %>%
    gather(key=`Structure Type`, value="standard.error")
  bind_cols(estimates, select(standard.errors, standard.error) ) } ) %>% bind_rows()

placesUnits1yr <- lapply(2013:2016, function(x){
  y <- acs.fetch(span=1, col.names="pretty", geography=places, endyear=x, table.number="B25024")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, placeNumber=place, placeName=NAME)) %>%
    gather(key=`Structure Type`, value=`Count`, -placeNumber, -placeName) %>%
    mutate(year=x)
  standard.errors <- as.tibble(y@standard.error) %>%
    gather(key=`Structure Type`, value="standard.error")
  bind_cols(estimates, select(standard.errors, standard.error) ) } ) %>% bind_rows()


#### Industry by Occupation table.number=="C24050"
### Can't get it to work for block groups.
# blockGroupIndustry <- lapply(2009:2016, function(x){
#   y <- acs.fetch(span=5, col.names='pretty', geography=blockGroups, endyear=x, table.number='B99241') ## Imputation Of Industry For Civilian Employed Population
#   estimates <- as.tibble(y@estimate) %>%
#     bind_cols(dplyr::select(y@geography, countyNumber=county, tractNumber=tract,
#                             blockgroup=blockgroup, blockgroupName=NAME)) %>%
#     mutate(year=x) } ) %>% bind_rows()


tractsIndustry <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names="pretty", geography=tracts, endyear=x, table.number="C24050")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, countyNumber=county,
                            tractNumber=tract, tractName=NAME)) %>%
    gather(key="Industry", value=`Count`, -tractNumber, -tractName, -countyNumber) %>%
    mutate(year=x)
  standard.errors <- as.tibble(y@standard.error) %>%
    gather(key="Industry", value="standard.error")
  bind_cols(estimates, select(standard.errors, standard.error) ) } ) %>% bind_rows() %>%
  mutate(Industry = str_sub(Industry, start=80)) %>%
  filter(Industry %in% c("Agriculture, forestry, fishing and hunting, and mining", "Construction", "Manufacturing", "Wholesale trade", "Retail trade", "Transportation and warehousing, and utilities", "Information", "Finance and insurance, and real estate and rental and leasing", "Professional, scientific, and management, and administrative and waste management services", "Educational services, and health care and social assistance", "Arts, entertainment, and recreation, and accommodation and food services", "Other services, except public administration", "Public administration")) %>%
  mutate(tractNumber = paste0(countyNumber, tractNumber) %>%
           str_pad(8, "left", "0")) %>%
  select(-countyNumber)

placesIndustry <- lapply(2009:2016, function(x){
  y <- acs.fetch(span=5, col.names="pretty", geography=places, endyear=x, table.number="C24050")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, placeNumber=place, placeName=NAME)) %>%
    gather(key="Industry", value=`Count`, -placeNumber, -placeName) %>%
    mutate(year=x)
  standard.errors <- as.tibble(y@standard.error) %>%
    gather(key="Industry", value="standard.error")
  bind_cols(estimates, select(standard.errors, standard.error) ) } ) %>% bind_rows() %>%
  mutate(Industry = str_sub(Industry, start=80)) %>%
  filter(Industry %in% c("Agriculture, forestry, fishing and hunting, and mining", "Construction", "Manufacturing", "Wholesale trade", "Retail trade", "Transportation and warehousing, and utilities", "Information", "Finance and insurance, and real estate and rental and leasing", "Professional, scientific, and management, and administrative and waste management services", "Educational services, and health care and social assistance", "Arts, entertainment, and recreation, and accommodation and food services", "Other services, except public administration", "Public administration"))

placesIndustry1yr <- lapply(2013:2016, function(x){
  y <- acs.fetch(span=1, col.names="pretty", geography=places, endyear=x, table.number="C24050")
  estimates <- as.tibble(y@estimate) %>%
    bind_cols(dplyr::select(y@geography, placeNumber=place, placeName=NAME)) %>%
    gather(key="Industry", value=`Count`, -placeNumber, -placeName) %>%
    mutate(year=x)
  standard.errors <- as.tibble(y@standard.error) %>%
    gather(key="Industry", value="standard.error")
  bind_cols(estimates, select(standard.errors, standard.error) ) } ) %>% bind_rows() %>%
  mutate(Industry = str_sub(Industry, start=80)) %>%
  filter(Industry %in% c("Agriculture, forestry, fishing and hunting, and mining", "Construction", "Manufacturing", "Wholesale trade", "Retail trade", "Transportation and warehousing, and utilities", "Information", "Finance and insurance, and real estate and rental and leasing", "Professional, scientific, and management, and administrative and waste management services", "Educational services, and health care and social assistance", "Arts, entertainment, and recreation, and accommodation and food services", "Other services, except public administration", "Public administration"))

# The code above downloads median income, units in structure, and industrial employment
# for all places and tracts in South Carolina for ACS 5 year estimates,
# and also 1 year estimates for some places.


census_places <- readRDS('census_places.rds')
census_tracts <- readRDS('census_tracts.rds')
census_blockGroups <- readRDS('census_blockGroups.rds')

placesIndustry1yr %<>% select(-standard.error) %>%
  spread(Industry, Count)

placesIncome1yr %<>% select(-standard.error) %>%
  rename(MedianIncome = estimate)

placesUnits1yr %<>% select(-standard.error) %>%
  spread(`Structure Type`, Count)

placesIndustry %<>%
  select(-standard.error) %>%
  spread(Industry, Count) %>%
  anti_join(placesIndustry1yr, by=c('year', 'placeNumber')) %>%
  bind_rows(placesIndustry1yr)

placesIncome %<>% select(-standard.error) %>%
  rename(MedianIncome = estimate) %>%
  anti_join(placesIncome1yr, by=c('year', 'placeNumber')) %>%
  bind_rows(placesIncome1yr)

placesUnits %<>% select(-standard.error) %>%
  spread(`Structure Type`, Count) %>%
  anti_join(placesUnits1yr, by=c('year', 'placeNumber')) %>%
  bind_rows(placesUnits1yr)

places_stats <- left_join(placesIncome, placesIndustry) %>%
  left_join(placesUnits)

rm(placesIndustry1yr, placesIncome1yr, placesUnits1yr,
   placesIndustry, placesIncome, placesUnits)

tractsIndustry %<>% select(-standard.error) %>%
  spread(Industry, Count)

tractsIncome %<>% select(-standard.error) %>%
  rename(MedianIncome = estimate)

tractsUnits %<>% select(-standard.error) %>%
  spread(`Structure Type`, Count)

tracts_stats <- left_join(tractsIncome, tractsIndustry) %>%
  left_join(tractsUnits)

rm(tractsIndustry, tractsIncome, tractsUnits)

blockgroup_stats <- left_join(blockGroupIncome, blockGroupUnits) %>%
  select(-standard.error) %>%
  rename(MedianIncome = estimate) %>%
  mutate(countyNumber = str_pad(countyNumber, 3, 'left', '0'),
         tractNumber = str_pad(tractNumber, 6, 'left', '0')) %>%
  mutate(bgNumber = paste0(45, countyNumber, tractNumber, blockgroup)) %>%
  select(-countyNumber, -tractNumber, -blockgroup) %>%
  arrange(bgNumber)

blockGroups <- dplyr::left_join(census_blockGroups, blockgroup_stats)
places <- dplyr::right_join(census_places, places_stats)
tracts <- dplyr::left_join(census_tracts, tracts_stats)

usethis::use_data(blockGroups, overwrite=TRUE)
usethis::use_data(tracts, overwrite=TRUE)
usethis::use_data(places, overwrite=TRUE)

# saveRDS(blockGroups, 'blockGroups.RDS')
# saveRDS(places, 'places.RDS')
# saveRDS(tracts, 'tracts.RDS')

# blockGroups <- readRDS('data-raw//blockGroups.RDS')
# tracts <- readRDS('data-raw//tracts.RDS')
# places <- readRDS('data-raw//places.RDS')

# write_excel_csv(places_stats, 'census_places_attributes.csv')
# write_excel_csv(tracts_stats, 'census_tracts_attributes.csv')
# write_excel_csv(blockgroup_stats, 'census_blockgroup_attributes.csv')

# st_write(census_places, 'census_places.shp', delete_dsn=TRUE)
# st_write(census_tracts, 'census_tracts.shp', delete_dsn=TRUE)
# st_write(census_blockGroups, 'census_blockGroups.shp', delete_dsn=TRUE)
