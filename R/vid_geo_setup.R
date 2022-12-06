#' Setup command for package
#'
#' Sets working directory, adds output folders, downloads gpx.fmt and yolov3 weights file
#' @param video_location The directory containing the video file
#' @param video_name The name of the video file including extension
#' @examples
#' setup("C:/videos", video.mp4);
#' @export

vid_geo_setup <- function(video_location, video_name){
    setwd(video_location);
    dir.create("../output")
    dir.create("../output/videoframes")
    dir.create("../output/boxedimages")
    video_path <- "../video_name"
    video_image_destination <- "../output/videoframes"
    download.file(
      "https://pjreddie.com/media/files/yolov3.weights",
      "../output"
    )
    yolo_weights <- "../output/yolov3.weights"
    boxed_images <- "../output/boxedimages"
    download.file(
      "https://raw.githubusercontent.com/exiftool/exiftool/master/fmt_files/gpx.fmt",
      "../output"
    )
    gpx_path <- "../output/gpx.fmt"
}
