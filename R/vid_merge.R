#' Merge .gpx and Objects
#'
#' Merges object count dataframe produced by vid_yolo() to the .gpx produced by vid_gpx()
#' @examples
#' vid_merge()
#' @export

##read in the gpx file
vid_merge <- function(){
  points <- readGPX(gpx_path, metadata = TRUE, tracks = TRUE)
  gpx <- points$tracks
  ##merge
  merged_df <<- merge(df, gpx, by.x = 0, by.y = 0)
merged_df
}
