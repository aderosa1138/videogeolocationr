# videogeolocationr
 Recognition and geolocation of objects from video using r

A package for processing geotagged video into an R dataframe containing object counts tied to location at a specified time interval. 
ExifTool and YOLOv3 are used for obtaining geolocation data and object recognition respectively. 

##Dependencies

#r libraries:
library(keras)
#keras library must be loaded, then installed with command install_keras
library(tensorflow)
#tensorflow library must be loaded, then installed with command install_tensorflow
library(platypus)
library(plyr)
library(tidyverse)
library(abind)
library(dplyr)
library(tidyr)
library(pryr)
library(purrr)
library(magrittr)
library(data.table)
library(av)
library(plotKML)

#library documentation
https://github.com/maju116/platypus
https://cran.r-project.org/web/packages/keras/index.html
https://cran.r-project.org/web/packages/tensorflow/index.html

#Other
ExifTool -> https://exiftool.org/
#Exiftool currently must be installed to machine manually and operated via shell to produce .gpx file
yolov3.weights -> https://pjreddie.com/media/files/yolov3.weights
#incorporating these to package at later time? too large for github, must be automatically downloaded from source
gpx.fmt -> https://github.com/exiftool/exiftool/blob/master/fmt_files/gpx.fmt
#file is in data-raw

