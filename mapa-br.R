
brasil <- geobr::read_country()


estado_sp <- geobr::read_state(code_state = 35)

#muni_sp <- read_municipality(code_muni= "SP", year=2018)

library(scales)
library(patchwork)
library(ggplot2)
library(ggthemes)
# Remove plot axis
no_axis <- theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank())




br_sp <- ggplot() +
  geom_sf(
    data = brasil,
    fill = "#eeeeee",
    color = "#eeeeee",
    size = .15,
    show.legend = FALSE
  ) +
  
  geom_sf(
    data = muni_sp,
    fill = "#4c4c4c",
    color = "#4c4c4c",
    size = .15,
    show.legend = FALSE
  ) +
  theme_minimal() +
  no_axis




ugrhis_sp <- ggplot() +
  geom_sf(
    data = muni_sp,
    fill = "#bcbcbc",
    color = "#bcbcbc",
    size = .15,
    show.legend = FALSE
  ) +
  geom_sf(
    data = muni_mmp_daee,
    fill = "#4c4c4c",
    color = "#4c4c4c",
    size = .15,
    show.legend = FALSE
  ) +
  labs(fill = "UGRHI") +
  theme(legend.position = "none") +
  theme_minimal() +
  no_axis



ugrhis <- ggplot() +
  geom_sf(data = muni_mmp_daee,
          aes(fill = ugrhi),
          size = .15 ,
          show.legend = FALSE
          ) +
          labs(fill = "UGRHI") +
            theme_minimal() +
            scale_fill_colorblind() +
            no_axis +
            theme(
              legend.position = "bottom",
              legend.box = "horizontal",
              legend.justification = "center",
              legend.title = element_text(size =8), 
               legend.text = element_text(size = 8)
                  
            )+
  scale_size(range=c(2,10), guide="none")+
  guides(fill=guide_legend(nrow=3,byrow=TRUE), 
         shape = guide_legend(override.aes = list(size = 0.5)))



patchwork <- (br_sp + ugrhis_sp)/ ugrhis


patchwork + plot_annotation(tag_levels = 'A')+ 
  plot_layout(widths = c(1, 2))


((br_sp / ugrhis_sp + plot_layout(guides = 'keep')) | ugrhis) + plot_layout(guides = 'collect')+ plot_annotation(tag_levels = 'A')