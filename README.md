---
editor_options: 
  markdown: 
    wrap: 72
---

# videogeolocationr

Recognition and geolocation of objects from video using R

A package for processing geotagged video into an R dataframe containing
object counts tied to location at a specified time interval. ExifTool
and YOLOv3 are used for obtaining geolocation data and object
recognition respectively.

## Walkthrough

videogeolocationr requires the tensorflow and keras libraries to be
installed.

```{r}
install.packages("keras", "tensorflow")
keras::install_keras()
tensorflow::install_tensorflow()
```

If a .gpx file for the target video is not available, one may be
extracted from a geotagged .mp4 file using Exiftool by Peter Harvey:

<https://exiftool.org/>

Exiftool requires a gpx format file, which is available here:

<https://github.com/exiftool/exiftool/blob/master/fmt_files/gpx.fmt>

Modify the following script to point to your target video file and
gpx.fmt file, and ensure the output .gpx file has the same name as the
target video file, then run via command line.

    C:\exiftool.exe -p "C:\gpx.fmt" -ee "C:\example.MP4" > "C:\example.gpx"

A pre-trained YOLOv3 weights file may be downloaded here, and must also
be placed without renaming in the same directory as the target video:

<https://pjreddie.com/media/files/yolov3.weights>
