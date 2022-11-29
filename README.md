# video_geolocation_r
 Recognition and geolocation of objects from video using r

A pair of scripts for processing geotagged video into an R dataframe containing object counts tied to location at a specified time interval. 
Scripts use ExifTool and YOLOv3 for obtaining geolocation data and object recognition respectively. 

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
#Exiftool must be installed to machine manually
yolov3.weights -> https://pjreddie.com/media/files/yolov3.weights
#incorporating these to package at later time
gpx.fmt -> https://github.com/exiftool/exiftool/blob/master/fmt_files/gpx.fmt
#incorporating into package at later time

