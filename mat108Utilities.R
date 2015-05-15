source('~/mat108/utilities.R')
install_from_mat108 <- function (course_name="histograms") 
  {
    if (!is.character(course_name)) {
      stop("Argument 'course_name' must be surrounded by quotes (i.e. a character string)!")
    }
    course_name <- make_pathname(course_name)
    url <- "http://github.com/zeugirdoR/mat108/zipball/master"
    response <- GET(url)
    path <- file.path(get_swirl_option("courses_dir"), "temp.zip")
    writeBin(content(response, "raw"), path)
    file_names <- unzip(path, list = TRUE)$Name
    unzip_list <- Filter(function(x) {
      grepl(paste0("/", course_name, "/"), x)
    }, file_names)
    if (length(unzip_list) == 0) {
      stop(paste0("Course '", course_name, "' not found in course repository! ", 
                  "Make sure you've got the name exactly right, then try again."))
    }
    unzip(path, exdir = get_swirl_option("courses_dir"), files = unzip_list)
    top_dir <- file.path(get_swirl_option("courses_dir"), sort(dirname(unzip_list))[1])
    dirs_to_copy <- list.files(top_dir, full.names = TRUE)
    if (file.copy(dirs_to_copy, get_swirl_option("courses_dir"), 
                  recursive = TRUE)) {
      swirl_out("Course installed successfully!", skip_after = TRUE)
    }
    else {
      swirl_out("Course installation failed.", skip_after = TRUE)
    }
    unlink(top_dir, recursive = TRUE, force = TRUE)
    unlink(file.path(get_swirl_option("courses_dir"), "__MACOSX"), 
           recursive = TRUE, force = TRUE)
    unlink(path, force = TRUE)
    invisible()
  }
