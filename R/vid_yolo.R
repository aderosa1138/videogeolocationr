#' Process Extracted Frames with YOLOv3
#'
#' Initializes YOLOv3, imports weights file, and runs YOLOv3 on extracted video frames. No arguments.
#' @examples
#' vid_yolo()
##' @export



vid_yolo <- function() {## set up yolo
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
    boxed_image_paths <- file.path(boxed_images, paste(names[i], sep = ""))

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
}

## do not go further until fixed to allow for NA's
