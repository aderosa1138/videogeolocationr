#' Set .gpx Path
#'
#' Sets path to .gpx file extracted from target video
#' @param gpx_location The full path to the desired video, with extension.
#' @examples
#' vid_gpx("C:/videos/video.gpx")
#' @export

vid_gpx <- function(gpx_location){
      gpx_path <<- gpx_location
}
