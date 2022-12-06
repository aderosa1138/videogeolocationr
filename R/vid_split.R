#'Video Frame Extraction
#'
#' Sets working directory, adds output folders, downloads gpx.fmt and yolov3 weights file
#' @param vid_fps The desired rate of frame extraction from the video, in frames per second.
#' @examples
#' vid_split(1)
#' @export

#test_vid_images <- av_video_images(video = video_path,
#                                   destdir = video_image_destination,
#                                   format = "jpg",
#                                   fps = 1)


vid_split <- function(vid_fps){
  av_video_images(video = video_path,
                 destdir = video_image_destination,
                 format = "jpg",
                 fps = vid_fps)
}
