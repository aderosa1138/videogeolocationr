---

---

# videogeolocationr

Recognition and geolocation of objects from video using R

A package for processing geotagged video into an R dataframe containing object counts tied to location at a specified time interval. ExifTool and YOLOv3 are used for obtaining geolocation data and object recognition respectively.

## Setup

videogeolocationr requires the tensorflow and keras libraries to be installed.

```{r}
install.packages("keras", "tensorflow")
keras::install_keras()
tensorflow::install_tensorflow()
```

If a .gpx file for the target video is not available, one may be extracted from a geotagged .mp4 file using Exiftool by Peter Harvey:

<https://exiftool.org/>

Exiftool requires a gpx format file, which is available here:

<https://github.com/exiftool/exiftool/blob/master/fmt_files/gpx.fmt>

Modify the following script to point to your target video file and gpx.fmt file, and ensure the output .gpx file has the same name as the target video file, then run via command line.

    C:/data/exiftool.exe -p "C:/data/gpx.fmt" -ee "C:/data/example.MP4" > "C:/data/example.gpx"

A pre-trained YOLOv3 weights file may be downloaded here, and must also be placed without renaming in the same directory as the target video:

<https://pjreddie.com/media/files/yolov3.weights>

## Walkthrough

The following is the full order of operations to obtain a dataframe containing object counts and location data from the file "example.mp4", located at the path "C:/data/example.mp4"

1.  Load and install Keras and Tensorflow libraries as described above.

2.  Download exiftool. For this example, the exiftool.exe file will be placed in the same directory as the video.

3.  Download yolov3.weights file and gpx.fmt file, place these in the same directory as the video.

4.  Install and load the videogeolocationr package and its dependencies.

5.  Modify the above exiftool script to the paths of your exiftool.exe and target video, and run it via command line to produce a .gpx file for the video. In this case, the script would remain:

        C:/data/exiftool.exe -p "C:/data/gpx.fmt" -ee "C:/data/example.MP4" > "C:/data/example.gpx"

6.  Direct videogeolocationr to the video with vid_setup():

    ```{r}
    vid_setup("C:\data\example.MP4")
    ```

7.  Direct videogeolocationr to the .gpx file with vid_gpx():

    ```{r}
    vid_gpx("C\data\example.gpx")
    ```

8.  Extract frames from the video with vid_split(), specifying the frame rate of extraction, in this case, one frame per second:

    ```{r}
    vid_split(1)
    ```

9.  Run the object detection model with vid_yolo(), then join the resulting dataframe of detected objects with example.gpx using vid_merge(). Neither command requires arguments:

    ```{r}
    vid_yolo()
    vid_merge()
    merged_df
    ```
