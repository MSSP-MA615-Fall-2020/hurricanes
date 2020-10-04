

library(tidyverse)
library(drat)
library(hurricaneexposuredata)

addRepo("geanders")

## The data is located in 
## https://github.com/geanders/hurricaneexposuredata
## a repo created to support the hurricaneexposure package
## This is a part of a number of similar packages resulting
## from environmental investigations undertaken by
## Brooke Anderson at Colorado State University in 2016, 2017, 2018
## See, for example, the futureheatwaves package.
## https://cran.r-project.org/web/packages/futureheatwaves/index.html
## 

data("hurr_tracks")

data_ht <- as.data.frame(hurr_tracks)


#####Data is located in the "geanders" definitions from 
#####https://rdrr.io/github/geanders/hurricaneexposuredata/src/R/data.R
##
##\item{storm_id}{Unique storm identifier with the storm name and year,
  ##                  separated by a hyphen (e.g., "Alberto-1988",
  ##                  "Katrina-2005"). Some storms are "Unnamed" or have other
  ##                  generic names. In these cases, it may be preferable to identify
  ##                  the storm using the first four characters of their
  ##                  ATCF ID (\code{usa_atcf_id}) and the storm season rather than
  ##                  the storm ID (e.g., 'AL13-1988').}
  ##   \item{usa_atcf_id}{Character string with the Automated Tropical Cyclone
  ##                  Forecasting System ID for the storm.}
  ##   \item{date}{Character string with date and time of storm track recording, in
  ##               the Universal Time Coordinated (UTC) time zone. This date is formated
  ##               as \code{\%Y\%m\%d\%H\%M}.}
  ##   \item{latitude}{Latitude of storm center, in decimal degrees}
  ##   \item{longitude}{Longitude of storm center, in decimal degrees (note:
  ##                    longitudes are given as negative values for
  ##                    longitudes west of the prime meridian)}
  ##   \item{wind}{1-minute maximum sustained surface wind speed, measured at
  ##              10 meters above the ground, in knots (values are rounded to
  ##              the nearest 5-knot value)}
##
##
##   \item{fips}{Character string with the county's 5-digit 
##   Federal Information Processing Standard (FIPS) code}
##
##   \item{lag}{Number of days from date when storm was closest to the county
##              (e.g., \code{0} indicates the date the storm was closest to the
##              county, \code{-2} indicates two days before the date when the
##              storm was closest to the county)} 
##   \item{precip}{Average daily precipitation, in millimeters, for NLDAS grid
##    points with the county for the given lag day}
##   \item{precip_max}{Maximum daily precipitation, in millimeters, across the NLDAS grid
##    points with the county for the given lag day}

## Note that the data are organized by county.  Each fips number
## is a county.  


## for summary data purposes:
##               use wind for wind in knots
##               use precip_max for rain in mm per day
##               for wind and rain: min, max, mean, median
##               for dates earliest and latest dates
##               for storm name separated from year
##               for year  
## 
##   This will result in one row of data for each storm:
##    year, storm, begin_date, end_date, max_wind, max_rain
##
##   Plots x = data, y = rain, size = wind
## 





               