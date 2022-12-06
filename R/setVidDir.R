#' Set Folders
#'
#' Sets working directory and adds output folders
#' @param video_location The directory containing the video file
#' @examples
#' setfolders("C:/videos");
#' @export

setfolders <- function(video_location){
    setwd(video_location);
    dir.create("../output")
    dir.create("../output/videoframes")
    dir.create("../output/boxedimages")
    return(video_location)
    list.files()
}
