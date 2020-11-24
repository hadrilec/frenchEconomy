#' @importFrom magrittr "%>%"
#' @importFrom rlang ".data"
#' @noRd
add_style = function(gg, lang = "en", img.file = "./inst/assets/insee.png", insee_logo = TRUE){

  data = gg[["data"]]
  # idbank_used = data %>% distinct(IDBANK) %>% pull(IDBANK) %>% paste0(collapse = " ")

  if(lang == "en"){
    caption_text_start = "Made with frenchEconomy on"
    # caption_text_series = "Used series"
  }else{
    caption_text_start = "Fait avec frenchEconomy le"
    # caption_text_series = "S\u00E9ries utilis\u00E9es"
  }

  caption_text_added = sprintf("%s : %s",
                               caption_text_start, lubridate::now()
  )

  # caption_text_added = sprintf("%s : %s, %s : %s",
  #                              caption_text_start, lubridate::now(),
  #                              caption_text_series, idbank_used
  #                              )

  if(is.null(gg$labels$caption)){
    caption_text = caption_text_added
  }else{
    caption_text = paste0(gg$labels$caption, "\n", caption_text_added)
  }

  gg_new =
    gg +
    ggplot2::scale_x_date(expand = c(0.01, 0.01)) +
    ggplot2::labs(caption = caption_text) +
    ggthemes::theme_stata() +
    ggplot2::theme(
      text = ggplot2::element_text(size = 15),
      axis.text.y  = ggplot2::element_text(angle = 0, hjust = 1),
      axis.title.x = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      plot.caption = ggplot2::element_text(size = 15),
      legend.title = ggplot2::element_blank(),
      legend.position = "bottom"
    )

  if(insee_logo){

    file_img = system.file(img.file, package = "frenchEconomy")

    if(file.exists(file_img)){
      m = png::readPNG(file_img)

      w <- matrix(grDevices::rgb(m[,,1],m[,,2],m[,,3], alpha = 0.7), nrow = dim(m)[1])

      img =  w %>% 
        grid::rasterGrob(interpolate = TRUE,
                         #height =  3*grid::grobHeight(rg),
                         width = grid::unit(1,'cm'),
                         x = grid::unit(1,"npc"),
                         y = grid::unit(1,"npc"),
                         hjust = 1, vjust = 1)

      gg_new = gg_new + ggplot2::annotation_custom(grob = img)
    }

  }

  return(gg_new)
}

