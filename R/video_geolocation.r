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

#### Using loops with each step for more image input allowance

  ## Create file paths as objects
  ##This needs to be setVidDir function

  video_path <- "I:/ResearchProject/Videos/GH010006.MP4"
  video_image_destination <- "I:/ResearchProject/Videos/images/video_images"
  yolo_weights <- "I:/ResearchProject/yolov3.weights"
  image_folder <- "I:/ResearchProject/Videos/images/image_folder"
  object_detected_images <- "I:/ResearchProject/Videos/images/object_detected_images"
  gpx_path <- "I:/ResearchProject/gpx.fmt"

### Video to image conversion
  ##separate function?

test_vid_images <- av_video_images(video = video_path,
                                   destdir = video_image_destination,
                                   format = "jpg",
                                   fps = 1)


## set up yolo
test_yolo <- yolo3(
  net_h = 416, # Input image height. Must be divisible by 32
  net_w = 416, # Input image width. Must be divisible by 32
  grayscale = FALSE, # Should images be loaded as grayscale or RGB
  n_class = 80, # Number of object classes (80 for COCO dataset)
  anchors = coco_anchors # Anchor boxes
)

## test yolo set up
test_yolo

## load yolo weights
test_yolo %>% load_darknet_weights(yolo_weights)

## load in images
img_paths <- list.files(path = video_image_destination, full.names = TRUE, pattern = "*.jpg")

## initialize list object to store feature vectors in within loop
feature_vectors <- list()

## loop over every image file name extracted from the .mp4
for (i in seq_along(img_paths)) {
  print(i)
  feature_vectors[[i]] <- img_paths[i] %>%
      image_load(., target_size = c(416, 416), grayscale = FALSE) %>%
        image_to_array() %>%
        '/'(255) %>%
    abind(along = 4) %>%
    aperm(c(4, 1:3))
}

## initialize list of object predictions
obj_preds <- list()

## loop over feature vectors of each image
for (i in seq_along(feature_vectors)) {
  print(i)
  obj_preds[[i]] <- test_yolo %>%
    predict(feature_vectors[[i]])
}

## initialize list of prediction boxes
pred_boxes <- list()

## loop over object predictions of each image
for (i in seq_along(obj_preds)) {
  print(i)
  tryCatch(
    expr = {
    val <<- get_boxes(preds = obj_preds[[i]], # Raw predictions form YOLOv3 model
                      anchors = coco_anchors, # Anchor boxes
                      labels = coco_labels, # Class labels
                      obj_threshold = 0.6, # Object threshold
                      nms = TRUE, # Should non-max suppression be applied
                      nms_threshold = 0.6, # Non-max suppression threshold
                      correct_hw = FALSE) # Should height and width of bounding boxes be corrected to image height and width
  },
  error = function(cond) {
    print(cond)
    val <<- NA
    print("error on ", i)

    },
  finally = {
    print(paste0("complete ", i))
    pred_boxes[[i]] <- val
    }
  )
}

## setting plot names
names = img_paths %>% basename %>% str_sub(1, -5) %>% paste0("_boxes.jpg")

## plotting the boxes and saving the new images to a folder (have to restart R session after in order to view images in folder)
for (i in seq_along(pred_boxes)){

  print(i)

  if (is.na(pred_boxes[i])) {
    next
  }

  else {
    boxed_image_paths <- file.path(object_detected_images, paste(names[i], sep = ""))

    jpeg(file = boxed_image_paths)

    plot_boxes(
      images_paths = img_paths[[i]], # Images paths
      boxes = pred_boxes[[i]], # Bounding boxes
      correct_hw = TRUE, # Should height and width of bounding boxes be corrected to image height and width
      labels = coco_labels, # Class labels
    )

    dev.off()
  }
}


## do not go further until fixed to allow for NA's

## use map to extract object from list by index or by name
all_object_names <- pred_boxes %>%
  map(1) %>%
  map("label") %>%
  unlist() %>%
  unique()

## initialize empty data frame here
df <- data.frame(matrix(NA,
                        nrow = 1,
                        ncol = length(all_object_names))) %>%
  set_colnames(c(all_object_names))

## get single row df with NA for the sake of joining
df_na <- data.frame(matrix(rep(NA, length(all_object_names)), nrow=1)) %>%
  set_colnames(all_object_names)

## i can't think of how to get around a loop here
for (i in 1:length(pred_boxes)) {

  ## get counts of every object
  row_tmp <- pred_boxes[[i]] %>%
    map("label") %>%
    unlist() %>%
    plyr::count() %>%
    t() %>%
    set_colnames(.[1,]) %>%
    data.frame() %>%
    slice(-1)

  ## get counts of every object with zeroes in place
  row <- rbindlist(list(df_na, row_tmp), fill = TRUE) %>%
    slice(-1) %>%
    mutate_all(~replace(., is.na(.), 0))

  ## set row values to counts
  df[i,] <- row
}


df

##read in the gpx file

points <- readGPX(gpx_path, metadata = TRUE, tracks = TRUE)
gpx <- points$tracks

##merge
merged_df <- merge(df, gpx, by.x = 0, by.y = 0)

merged_df






