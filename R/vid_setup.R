#' Setup command for videogeolocationr
#'
#' Sets working directory, adds output folders. YOLOv3 weights file and gpx.fmt file must be manually placed in same directory as target video prior to execution.
#' @param video_location The directory and name of the video file including extension
#' @examples
#' vid_setup("C:/videos/video.mp4");
#' @export

vid_setup <- function(video_location){
    setwd(dirname(video_location));
    output_dir <- paste(dirname(video_location),"/output/",sep="")
    dir.create(output_dir)
    videoframes_dir <- paste(dirname(video_location),"/videoframes/",sep="")
    dir.create(videoframes_dir)
    boxedimages_dir <- paste(dirname(video_location),"/boxedimages/",sep="")
    dir.create(boxedimages_dir)
    video_path <<- video_location
    video_image_destination <<- videoframes_dir
#    download.file(
#      "https://pjreddie.com/media/files/yolov3.weights",
#      "../output"
#    )
    yolo_weights <<- paste(dirname(video_location),"/yolov3.weights",sep="")
    boxed_images <<- boxed_images_dir
    gpx_path <<- paste(dirname(video_location), "/gpx.fmt",sep="")
}

##currently needs weights and fmt files manually placed in same directory as target video
